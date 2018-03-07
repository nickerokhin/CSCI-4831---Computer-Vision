function [ disparityMap ] = ssdDisparity( frameLeftRect, frameRightRect, windowSize)
    
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
        k_size = ceil(windowSize/2)
        frameLeftRect = padarray(frameLeftRect, [k_size k_size], 'replicate', 'both');
        frameRightRect = padarray(frameRightRect, [k_size k_size], 'replicate', 'both');
    else
        
        k_size = 0
        
    end
    
    imSize = size(frameLeftRect);
    disparityMap = zeros(imSize);
    colSize = imSize(2);
    rowSize = imSize(1);
    for row = 1 + k_size:rowSize - k_size
        for col = 1 + k_size:colSize - k_size
            if col - 63 - k_size < 2
                dispRange = col - 1 - k_size;
            else
                dispRange = 63;
            end
            
            finalDisparity = 0;
            lowestDiff = 999999;
            
            if windowSize > 1

                tMat = frameLeftRect(row - k_size:row + k_size, col - k_size:col+k_size);
                
            end
            
            if dispRange > 1
            
                for disparity = dispRange:-1:1
                    if windowSize == 1
                        
                        diff = frameLeftRect(row, col) - frameRightRect(row, col - disparity);
                        diff = diff^2;
                    
                    else
                        
                        diffMat =  zeros(k_size);
                        fMat = frameRightRect(row - k_size:row+k_size, col - k_size - disparity:col+k_size - disparity);
                        for ii = 1:k_size
                            for jj = 1:k_size
                                diffMat(jj, ii) = tMat(jj,ii) * gaussKernel(jj,ii) - fMat(jj, ii) * gaussKernel(jj,ii);
                            end
                        end
                        diff = sum(sum(diffMat));
                 
                    end
                    if diff <= lowestDiff
                        lowestDiff = diff;
                        finalDisparity = disparity;
                    end

                end
            disparityMap(row - k_size, col - k_size) = finalDisparity;
            end
            
        end
        
    end
            

end