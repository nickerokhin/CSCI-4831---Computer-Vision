function [ outImg ] = swirlFilter( inImg, factor, ox, oy)
 
imSize = size(inImg);
rgbArr = imSize(3);
xSize = imSize(2);
ySize = imSize(1);
   
    for col = 1:xSize
       
        for row = 1:ySize
           
            x = col;
            y = row;
           
            
            radx = ((x^2 + y^2)^.5);
            %Polar angle
            theta = atan2(ox-x,oy-y);
            %Distance from origin
            radius = ((ox-x)^2 + (oy-y)^2)^.5;
            %Scaling thete depending on radius
            scaleTheta = theta + (radius/100)*factor;
            %Converting new theta back to x,y
            x = radius * cos(scaleTheta);
            y = radius * sin(scaleTheta);
            %Nearest neighbor & adding ox, oy back to x,y
            [sx sy] = sampleNearest(x,y, imSize, ox, oy);
           
            %Inverse map
            outImg(row,col, :) = inImg(sy,sx, :);
           
           
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