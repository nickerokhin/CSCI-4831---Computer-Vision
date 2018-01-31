function [ outImg ] = grayScale( inImg )

    outImg = 0.2989 * inImg(:, :, 1) + 0.5870 * inImg(:,: ,2) + 0.1140 * inImg(:, :, 3);


end
