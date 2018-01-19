function [ outImg ] = meanFilter(inImg, kernel_size)
    kernel = ones(kernel_size, kernel_size) * (1/(kernel_size*kernel_size));
    imSize = size(inImg);
    rgbArr = imSize(3);
    xSize = imSize(2);
    ySize = imSize(1);
    kernel_overlap = floor(kernel_size/2);
    for rgb = 1:rgbArr
        %Loop through rgb pixels
        for col = 1:xSize
            %loop through rows
            for row = 1:ySize
                colBuff = -floor(kernel_size/2);
                rowBuff = -floor(kernel_size/2);
                convSum = 0;
                kernShadow = zeros(3,3);
                for colKern = 1:kernel_size
                    rowBuff = -floor(kernel_size/2);
                    for rowKern = 1:kernel_size
                        modRow = mod(row + rowBuff, ySize);
                        
                        if modRow == 0
                            modRow = 1;
                        end
                        
                        modCol = mod(col + colBuff, xSize);
                        
                        if modCol == 0
                            modCol = 1;
                        end
                     
                        convSum = convSum + kernel(rowKern,colKern) * inImg(modRow, modCol, rgb);
                        rowBuff = rowBuff + 1;
                        
                        outImg(row,col,rgb) = convSum;
                    end
                    colBuff = colBuff + 1;
                end     
            end
        end
    end
end
    