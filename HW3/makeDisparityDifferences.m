function [ dispDiff ] = makeDisparityDifferences(frameDisp, groundTruth)

    imSize = size(frameDisp);
    
    for row = 1:imSize(1)
        
        for col = 1:imSize(2)
            dispDiff(row, col) = abs(frameDisp(row, col) - groundTruth(row, col));
            
        end
        
    end


end