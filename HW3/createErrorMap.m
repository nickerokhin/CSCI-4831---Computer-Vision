function [ map ] = createErrorMap(frameDisp, groundTruth)

imSize = size(frameDisp)


for row = 1:imSize(1)
    for col = 1:imSize(2)
       if groundTruth(row, col) - frameDisp(row, col) == 0
           map(row, col) = 63;
       else
           map(row, col) = 0;
           
       end
        
        
    end
    
end


end