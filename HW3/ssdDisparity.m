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

    frameLeftRect = uint8(conv2(frameLeftRect,gaussKernel, 'same'));
    frameRightRect = uint8(conv2(frameRightRect,gaussKernel, 'same'));
    end
    
    imSize = size(frameLeftRect);
    disparityMap = zeros(imSize);
    colSize = imSize(2);
    rowSize = imSize(1);
    for row = 1:rowSize
        for col = 1:colSize
            if col - 63 < 2
                dispRange = col - 1;
            else
                dispRange = 63;
            end
            
            finalDisparity = 0;
            lowestDiff = 999999;
            if dispRange > 1
            
                for disparity = 1:dispRange
                    
                    diff = frameLeftRect(row, col) - frameRightRect(row, col - disparity);
                    diffSq = diff^2;
                   
                    if diffSq < lowestDiff
                        lowestDiff = diffSq;
                        finalDisparity = disparity;
                    end

                end
            disparityMap(row, col) = finalDisparity;
            end
            
        end
        
    end
            

end