function [ outImg ] = frosty( inImg, n, m)

%Dimensions of image

imSize = size(inImg);
outImg = zeros(imSize);
rgbArr = imSize(3);
xSize = imSize(2);
ySize = imSize(1);

%location of source pixel in relation to kernel frame

kCenterCol = ceil(m/2);
kCenterRow = ceil(n/2);

%Calculating distances due to n,m potentially being even or odd

kVertEdgeDistTop = kCenterRow - 1;
kVertEdgeDistBot = n - kCenterRow;
kHorizEdgeDistLeft = kCenterCol - 1;
kHorizEdgeDistRight = m - kCenterCol;



for rgb = 1:rgbArr
    for col = 1:xSize
        for row = 1:ySize
            
            %Bounds for kernel range on source image using distance
            
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
            

            
            inImgSample = inImg(rowStart:rowEnd, colStart:colEnd, rgb);
            
            %Selects random element from random row in inImgSample
            
            outImg(row, col, rgb) = datasample(datasample(inImgSample, 1), 1);
            

        end
    end
    
end
end