image = imread('uttower1.jpg');

imgPoints = [528.0000  313.0000  984.0000  335.0000;
  442.0000  303.0000  890.0000  327.0000;
  502.0000  399.0000  958.0000  423.0000;
  314.0000  617.0000  778.0000  649.0000;
  182.0000  503.0000  640.0000  539.0000;
  494.0000  371.0000  952.0000  393.0000;
  374.0000  291.0000  816.0000  319.0000;
  320.0000  459.0000  776.0000  493.0000;
  464.0000  495.0000  924.0000  533.0000;
  112.0000  573.0000  576.0000  607.0000]

imSize = size(image);

rgb = imSize(3);
col = imSize(2);
row = imSize(1);
homo = computeH(imgPoints);
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
figure
imagesc(uint8(outImg))