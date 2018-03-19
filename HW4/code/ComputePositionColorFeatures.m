function features = ComputePositionColorFeatures(img)
% Compute a feature vector of colors and positions for all pixels in the
% image. For each pixel in the image we compute a feature vector
% (r, g, b, x, y) where (r, g, b) is the color of the pixel and (x, y) is
% its position within the image.
%
% INPUT
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of computed features of size h x w x 5 where
%            features(i, j, :) is the feature vector for the pixel
%            img(i, j, :).

    height = size(img, 1);
    width = size(img, 2);
    features = zeros(height, width, 5);
    for col = 1:width
        for row = 1:height
            features(row, col, 1) = img(row, col, 1);
            features(row, col, 2) = img(row, col, 2);
            features(row, col, 3) = img(row, col, 3);
            features(row, col, 4) = col;
            features(row, col, 5) = row;
        end
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                                                                         %
    %                              YOUR CODE HERE                             %
    %                                                                         %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end