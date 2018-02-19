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
                %Nearest neighbor approximation upper bound
                approxRow = ceil(row/factor);
                approxCol = ceil(col/factor);
                
                %In case approximation is out of bounds of original image
                if approxRow > ySize
                    approxRow = ySize;
                end
                
                if approxCol > xSize
                    approxCol = xSize;
                end
                
                outImg(row, col, rgb) = inImg(approxRow, approxCol, rgb);
                
            end
        end
    end
end