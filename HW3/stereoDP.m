function [ dMap ] = stereoDP( e1, e2, maxDisp, occ)

    rowSize = size(e1);
    rowSize = rowSize(2) + 1;
    %build cost matix
    dCost = zeros([rowSize rowSize 3]);
    dCost(:, :, 1) = 1000 * ones([rowSize rowSize]);

  for i = 1:rowSize
    for j = 1:rowSize

        if i == 1
            dCost(i, j) = j * occ;

        elseif j == 1
            dCost(i, j) = i * occ;

        end
    end
  end
    
    for i = 2:rowSize
                         
         if i + maxDisp > rowSize
            dispRange = rowSize - i;

         else
            dispRange = maxDisp;

         end
            for j = i:(i + dispRange)
                dispRange;
                i;
                j;
                dCost(j, i, 1) = (e1(j - 1) - e2(i - 1))^2;
                northwest = dCost(j - 1, i - 1, 1) + dCost(j, i, 1);
                west = dCost(j, i - 1, 1) + occ;
                north = dCost(j - 1, i, 1) + occ;
                [M, idx] = min([northwest west north]);
                
                switch idx
                    case 1
                        
                        dCost(j, i, 2) = j - 1;
                        dCost(j, i, 3) = i - 1;
                        
                    case 2
                        
                        dCost(j, i, 2) = j;
                        dCost(j, i, 3) = i - 1;
                        
                    case 3
                        
                        dCost(j, i, 2) = j - 1;
                        dCost(j, i, 3) = i;
                        
                end
                
                
            end
    end
    
            

rowSize;
%dCost(:, :, 1)

%backtrack
imSize = size(dCost);
i = imSize(2);
j = imSize(1);
%i is the position of pixel
%matching pixel on other img is j
%Disparity is j - i
%disparity is only set when moving west or northwest
%disparity is decreased when moving north

while i ~= 1 && j ~= 1
    if i == 0 || j == 0
        break
    end
    i;
    j;
    ip = dCost(j, i, 3);
    jp = dCost(j, i, 2);
    
    if jp == j - 1 && ip == i - 1 || ip == i - 1
       %moving northwest or west, set disparity
       dMap(i) = j - i;
               
    end
    
    i = ip;
    j = jp;

   
    
end

end




