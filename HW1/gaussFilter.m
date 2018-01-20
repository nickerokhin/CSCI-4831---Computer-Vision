function [ outImg ] = gaussFilter( inImg, sigma )

kernel_size = 2 * ceil(2 * sigma) + 1
center = ceil(kernel_size/2)

for x = 1:kernel_size
    for y = 1:kernel_size
        ydist = abs(y-center);
        xdist = abs(x-center);
        gaussKernel(x, y) = (1/(2 * pi * pow2(sigma))) * exp(-((pow2(xdist) + pow2(ydist))/(2 * pow2(sigma))))
    end
end

k_overlap = floor(kernel_size/2);
inImg = padarray(inImg, [k_overlap k_overlap], 'replicate', 'both');
imSize = size(inImg);
rgbArr = imSize(3);
xSize = imSize(2);
ySize = imSize(1);
size(inImg)
for rgb = 1:rgbArr
    %Loop through rgb pixels
    for col = 1 + k_overlap:xSize - k_overlap
        %loop through rows
        for row = 1 + k_overlap:ySize - k_overlap
           kernShadow = inImg(row - k_overlap:row + k_overlap, col - k_overlap:col + k_overlap, rgb);
           kernSum = 0;
           for y = 1:kernel_size
               for x = 1:kernel_size
                   kernSum = kernSum + kernShadow(x,y) * gaussKernel(x,y);
               end
                   
           end
           outImg(row-k_overlap, col-k_overlap, rgb) = kernSum;
        end

    end
end

end