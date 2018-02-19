%Nicholas Erokhin
%CSCI 4830
%HW 2
%Ioana Fleming

%tower2, tower1
function [ outPoints ] = getPoints( inImg1, inImg2, ptCt )

figure(1);
imshow(inImg1);
axis1 = gca;
title('Image1');

figure(2);
imshow(inImg2);
axis2 = gca;
title('Image2');

for i = 1:ptCt
    
axes(axis1);
outPoints(i, 1:2) = fliplr(ginput(1));
axes(axis2);
outPoints(i, 3:4) = fliplr(ginput(1));

end

end