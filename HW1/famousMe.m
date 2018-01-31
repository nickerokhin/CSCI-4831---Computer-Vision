function [ outImg ] = famousMe( backImg, srcImg, ox, oy)

srcImg = scaleNearest(srcImg, 0.2);
greyOut = grayScale(srcImg);
binOut = greyOut > 180;
srcImgSize = size(srcImg);



for col = 1+ox:ox+srcImgSize(2)
    for row = 1+oy:oy+srcImgSize(1)
        if ~binOut(row-oy, col-ox)
            backImg(row,col, :) = srcImg(row-oy, col-ox, :);
        end
    end
    
end
outImg = backImg;

end