function [ outImg ] = scaleNearest( inImg, factor)
    imSize = size(inImg);
    rgbArr = imSize(3);
    xSize = imSize(2);
    ySize = imSize(1);
    newxSize = ceil(xSize * factor);
    newySize = ceil(ySize * factor);
    outImg = zeros([newySize newxSize rgbArr]);
    
    for rgb = 1:rgbArr
        for col = 1:newxSize
            for row = 1:newySize
                outImg(row, col, rgb) = inImg(ceil(row/factor), ceil(col/factor), rgb);
                
            end
        end
    end
end