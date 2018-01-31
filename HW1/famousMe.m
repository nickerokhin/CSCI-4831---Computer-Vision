function [ outImg ] = famousMe( backImg, srcImg, ox, oy)

%Scaling source image down
srcImg = scaleNearest(srcImg, 0.2);
%Convert source to gray
grayOut = grayScale(srcImg);

%Remove whiteboard with binary image
binOut = grayOut > 180;
srcImgSize = size(srcImg);



for col = 1+ox:ox+srcImgSize(2)
    for row = 1+oy:oy+srcImgSize(1)
        if ~binOut(row-oy, col-ox)
            %if pixel in binary image is 0, replace corresponding pixel on
            %background image with pixel from source image
            backImg(row,col, :) = srcImg(row-oy, col-ox, :);
        end
    end
    
end
outImg = backImg;

end