function [ outImg ] = meanFilter(inImg, kernel_size)
    kernel = ones(kernel_size, kernel_size) * (1/(kernel_size*kernel_size));
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
               outImg(row-k_overlap, col-k_overlap, rgb) = mean2(kernShadow);
            end
            
        end
    end
end
    