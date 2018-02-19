%Nicholas Erokhin
%CSCI 4830
%HW 2
%Ioana Fleming

function [ outImg ] = warp1( inImg, homo )


imSize = size(image);
col = imSize(2);
row = imSize(1);
maxIndices = round(homo * [row col 1]')
maxIndices = maxIndices/maxIndices(3);
outImg = zeros([maxIndices(1), maxIndices(2), 3]);

invHomo = inv(homo);
for c = 1:maxIndices(2)
    for r = 1:maxIndices(1)
        xlated = invHomo * [r c 1]';
        xlated = xlated/xlated(3);
        
        if xlated(1) <= 0 || xlated(2) <= 0 || xlated(1) > maxIndices(2) || xlated(2) > maxIndices(1)
            continue
            
        end
        if xlated(1) > imSize(1) || xlated(2) > imSize(2)
            
            continue
        end
        
        outImg(r, c, :) = image(ceil(xlated(1)), ceil(xlated(2)), :);
       
    end
    
end

outImg = uint8(outImg)

end