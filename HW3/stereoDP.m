function [ dMap ] = stereoDP( e1, e2, maxDisp, occ)
    rowSize = size(e1);
    rowSize = rowSize(2);
    %build cost matix
    dCost = zeros([rowSize rowSize 3]);
    dCost(:, :, 1) = ones([size(e1) size(e1)]);
    dCost(:, :, 1) =  1000 * dCost(:, :, 1);
  for i = 1:rowSize(2) + 1
    for j = 1:rowSize(2) + 1

        if i == 1
            dCost(i, j) = j * occ;

        elseif j == 1
            dCost(i, j) = i * occ;

        end
    end
  end
    
    for i = 2:rowSize(2) + 1
              
             if i + maxDisp > rowSize(2)
                dispRange = rowSize(2) - i;

             else
                dispRange = maxDisp;

             end

            for d = 1:dispRange
                
                dCost(i, i + d, 1) = (e1(i + d) - e2(i))^2;
                northwest = dCost(i - 1, i + d - 1, 1) + dCost(i, i + d, 1);
                west = dCost(i, i + d - 1, 1) + occ;
                north = dCost(i - 1, i + d, 1) + occ;
                [~, idx] = min([northwest west north]);
                switch idx
                    case 1
                        
                        dCost(i, i + d, 2) = i - 1;
                        dCost(i, i + d, 3) = i + d - 1;
                        
                    case 2
                        
                        dCost(i, i + d, 2) = i;
                        dCost(i, i + d, 3) = i + d - 1;
                        
                    case 3
                        
                        dCost(i, i + d, 2) = i - 1;
                        dCost(i, i + d, 3) = i + d;
                        
                end
                
                
            end
    end
    
            


%backtrack
imSize = size(dCost);
i = imSize(2);
j = imSize(1);
%i is the position of pixel
%matching pixel on other img is j
%Disparity is j - i
%disparity is only set when moving west or northwest
%disparity is decreased when moving north

while i ~= 0 && j ~= 0
    ip = dCost(i, j, 2);
    jp = dCost(i, j, 3);
    
    if jp == j - 1 && ip == i - 1 || ip == i - 1
       %moving northwest, set disparity
       dMap(i) = j - i;
               
    end
    
    i = ip
    j = jp
    
    
end

end




