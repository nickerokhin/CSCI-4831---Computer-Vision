function [ outImg ] = scaleBilinear( inImg, factor)
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
                
                x1 = ceil(col/factor) + 1;
                x2 = ceil(col/factor);
                y1 = ceil(row/factor) + 1;
                y2 = ceil(row/factor);
                if x1 > xSize
                    x1 = xSize;
                end
                
                if y1 > ySize
                    y1 = ySize;
                end
                
                R1 = inImg(x1,y1, rgb) + ((col - x1)/(x2 - x1)) * (inImg(x1, y2, rgb) - inImg(x1,y1, rgb));
                R2 = inImg(x2, y1, rgb) + ((col - x1)/(x2 - x1)) * (inImg(x2, y2, rgb) - inImg(x2, y1, rgb));
                P = R2 + ((row - y2)/(y2 - y1))*(R1  - R2);
                outImg(col, row, rgb) = P;
                
            end
        end
        
    end
end