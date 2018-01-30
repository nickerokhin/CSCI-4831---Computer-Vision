function [ outImg ] = swirlFilter( inImg, factor, ox, oy)

imSize = size(inImg);
rgbArr = imSize(3);
xSize = imSize(2);
ySize = imSize(1);
   
    for col = 1:xSize
        
        for row = 1:ySize
            
            x = col - ox;
            y = row - oy;
            
            if y == 0
                y = 1;
            end
            
            if x == 0
                x = 1;
            end
            
            theta = atan(y/x);
            radius = (x^2 + y^2)^.5;
            scaleTheta = mod(theta + radius/factor, 2*pi)
            x = radius * cos(scaleTheta);
            y = radius * sin(scaleTheta);
            [sx sy] = sampleNearest(x,y, imSize, ox, oy);
            
           
            outImg(row,col, :) = inImg(sx,sy, :);
            
            
        end
        
    end
    
end

function [ newX, newY ] = sampleNearest(x, y, imSize, ox, oy)

newX = ceil(x) + ox;
newY = ceil(y) + oy;

if newX > imSize(2)
    newX = imSize(2);
end

if newY > imSize(1)
    newY = imSize(1);
end

if newY < 1
    newY = 1;
    
end

if newX < 1
    newX = 1;
end
end

