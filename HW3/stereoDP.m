function [ dCost ] = stereoDP( e1, e2, maxDisp, occ)
    rowSize = size(e1)
    %build cost matix

    for j = 1:rowSize(2) + 1

        if i == 1
            dCost(i, j) = j * occ;

        elseif j == 1
            dCost(i, j) = i * occ;

        else 
             if j + maxDisp > rowSize(2)
                dispRange = rowSize(2) - j;

             else
                dispRange = maxDisp;

             end

            for d = 1:dispRange
                dCost(j, j + d) = (e1(j + d) - e2(j))^2;

            end
            
            
            
        end
        
    end


end