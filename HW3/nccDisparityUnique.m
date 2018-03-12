function [ disparityMap ] = nccDisparity( frameLeft, frameRight, windowSize )

profile on
imSize = size(frameLeft)
colSize = imSize(2)
rowSize = imSize(1)
kernDist = floor(windowSize/2)
frameLeft = double(frameLeft);
frameRight = double(frameRight);

uniqueMap = zeros([rowSize colSize]);

for col = 1 + kernDist:colSize - kernDist
    col
    for row = 1 + kernDist:rowSize - kernDist
        
        f = frameRight(row - kernDist:row + kernDist, col - kernDist:col + kernDist);
        fmean = mean2(f);
        fstd = sqrt(sum((f(:) - fmean).^2));

        fhat = (f - fmean)/fstd;

        
        if col + 63 > colSize - kernDist
            dispRange = colSize - kernDist - col;
            
        else
            dispRange = 63;
            
        end
        bestCorr = -2;
        bestDisparity = 0;
      
        
        if dispRange > 1
        
            for disparity = 1:dispRange
                if uniqueMap(row, col + disparity) <= 1
                    g = frameLeft(row - kernDist:row + kernDist, col - kernDist + disparity:col + kernDist + disparity);

                    gmean = mean2(g);
                    gstd = sqrt(sum((g(:) - gmean).^2));
 
                    ghat = (g - gmean)/gstd;

                    corr = sum(sum(ghat .* fhat));

                    if corr > bestCorr
                        bestCorr = corr;
                        bestDisparity = disparity;
                    end
                    
                else
                    continue
                end
            end
                
            bestDisparity;
            
            disparityMap(row - kernDist, col - kernDist) = bestDisparity;

            uniqueMap(row, col + bestDisparity) = uniqueMap(row, col + bestDisparity) + 1;
            
           
        end
    end
    
end

end