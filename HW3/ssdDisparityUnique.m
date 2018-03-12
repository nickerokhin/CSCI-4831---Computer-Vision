function [ disparityMap ] = ssdDisparity( frameLeftRect, frameRightRect, windowSize)
    frameLeftRect = double(frameLeftRect)
    frameRightRect = double(frameRightRect)
    if windowSize > 1
        sigma = 1
        kernel_size = windowSize
        center = ceil(windowSize/2)
        %Creating the gaussian kernel
        for x = 1:kernel_size
            for y = 1:kernel_size
                ydist = abs(y-center);
                xdist = abs(x-center);
                gaussKernel(x, y) = 1/(2 * pi * sigma^2) * exp(-((xdist^2 + ydist^2)/(2 * sigma^2)));
            end
        end
        k_size = floor(windowSize/2)
        frameLeftRect = padarray(frameLeftRect, [k_size k_size], 'replicate', 'both');
        frameRightRect = padarray(frameRightRect, [k_size k_size], 'replicate', 'both');
    else
        
        k_size = 0
        
    end
    
    imSize = size(frameLeftRect);
    disparityMap = zeros(imSize);
    colSize = imSize(2);
    rowSize = imSize(1);
    uniqueMap = zeros(imSize);
    for col = 1 + k_size:colSize - k_size
        for row = 1 + k_size:rowSize - k_size
            if col + 63 > colSize - k_size
                dispRange = colSize - k_size - col;
            else
                dispRange = 63;
            end
            
            finalDisparity = 0;
            lowestDiff = 999999;
            
            if windowSize > 1

                tMat = frameRightRect(row - k_size:row + k_size, col - k_size:col+k_size);
                
            end
            
            if dispRange > 1
            
                for disparity = 1:dispRange
                    if uniqueMap(row, col + disparity) <= 1
                        if windowSize == 1

                            diff = frameRightRect(row, col + disparity) - frameLeftRect(row, col);
                            diff = diff^2;

                        else

                            diffMat =  zeros(k_size);
                            fMat = frameLeftRect(row - k_size:row+k_size, col - k_size + disparity:col+k_size + disparity);
                            for ii = 1:k_size
                                for jj = 1:k_size
                                    diffMat(jj, ii) = tMat(jj,ii) * gaussKernel(jj,ii) - fMat(jj, ii) * gaussKernel(jj,ii);
                                end
                            end
                            diff = sum(sum(diffMat.^2));

                        end
                        if diff <= lowestDiff
                            lowestDiff = diff;
                            finalDisparity = disparity;
                        end
                    end

                end

            disparityMap(row - k_size, col - k_size) = finalDisparity;
            uniqueMap(row, col + finalDisparity) = 1;
            end
            
        end
        
    end
            

end