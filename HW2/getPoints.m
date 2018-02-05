%Nicholas Erokhin
%CSCI 4830
%HW 1
%Ioana Fleming

function [ outPoints ] = getPoints( inImg1, inImg2 )

figure(1);
imshow(inImg1);
axis1 = gca;
title('Image1');

figure(2);
imshow(inImg2);
axis2 = gca;
title('Image2');

for i = 1:10
    
axes(axis1);
outPoints(i, 1:2) = ginput(1);
axes(axis2);
outPoints(i, 3:4) = ginput(1);

end

end