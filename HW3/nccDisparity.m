function [ disparityMap ] = nccDisparity( frameLeft, frameRight, windowSize )
profile on
imSize = size(frameLeft)

colSize = imSize(2)
rowSize = imSize(1)
kernDist = floor(windowSize/2)
frameLeft = single(frameLeft);
frameRight = single(frameRight);

for row = 1 + kernDist:rowSize - kernDist
    row
    for col = 1 + kernDist:colSize - kernDist
        
        f = frameLeft(row - kernDist:row + kernDist, col - kernDist:col + kernDist);
        fmean = mean2(f);
        fstd = sqrt(sum((f(:) - fmean).^2));
        fhat = (f - fmean)/fstd;
        
        if col - kernDist - 63 < 2
            dispRange = col - 1 - kernDist;
            
        else
            dispRange = 63;
            
        end
        bestCorr = -99999999;
        bestDisparity = 0;
        if dispRange > 1
        
            for disparity = dispRange:-1:1
                
                g = frameRight(row - kernDist:row + kernDist, col - kernDist - disparity:col + kernDist - disparity);
        
                gmean = mean2(g);
                gstd = sqrt(sum((g(:) - gmean).^2));
                ghat = (g - gmean)/gstd;
                
                corr = sum(sum(ghat .* fhat));
                
                if corr > bestCorr
                    bestCorr = corr;
                    bestDisparity = disparity;
                end
            end
    
            disparityMap(row - kernDist, col - kernDist) = bestDisparity;
            
        end
    end
    
end

end