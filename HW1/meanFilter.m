function [ outImg ] = meanFilter(inImg, kernel_size)

    imSize = size(inImg);
    outImg = zeros(imSize);
    rgbArr = imSize(3);
    xSize = imSize(2);
    ySize = imSize(1);

%location of source pixel in relation to kernel frame

    kCenterCol = ceil(kernel_size/2);
    kCenterRow = ceil(kernel_size/2);

    %Calculating distances due to n,m potentially being even or odd

    kVertEdgeDistTop = kCenterRow - 1;
    kVertEdgeDistBot = kernel_size - kCenterRow;
    kHorizEdgeDistLeft = kCenterCol - 1;
    kHorizEdgeDistRight = kernel_size - kCenterCol;

    
    for rgb = 1:rgbArr
        %Loop through rgb pixels
        for col = 1:xSize
            %loop through rows
            for row = 1:ySize
                rowStart = row - kVertEdgeDistTop;
                rowEnd = row + kVertEdgeDistBot;
                colStart = col - kHorizEdgeDistLeft;
                colEnd = col + kHorizEdgeDistRight;
         
            %Conditionals for edges and corners
            
                if rowStart <= 0
                    rowStart = 1;
                end

                if rowEnd > ySize
                    rowEnd = ySize;
                end

                if colStart <= 0
                    colStart = 1;
                end

                if colEnd > xSize
                    colEnd = xSize;
                end

                kernShadow = inImg(rowStart:rowEnd, colStart:colEnd, rgb);
                outImg(row, col, rgb) = mean2(kernShadow);
            end
            
        end
    end
end
    