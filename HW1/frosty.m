function [ outImg ] = frosty( inImg, n, m)

imSize = size(inImg);
rgbArr = imSize(3);
xSize = imSize(2);
ySize = imSize(1);
kCenterCol = ceil(m/2);
kCenterRow = ceil(n/2);
kVertEdgeDistTop = kCenterRow - 1;
kVertEdgeDistBot = n - kCenterRow;
kHorizEdgeDistLeft = kCenterCol - 1;
kHorizEdgeDistRight = m - kCenterCol;



for rgb = 1:rgbArr
    for col = 1:xSize
        for row = 1:ySize
            
            rowStart = row - kVertEdgeDistTop;
            rowEnd = row + kVertEdgeDistBot;
            colStart = col - kHorizEdgeDistLeft;
            colEnd = col + kHorizEdgeDistRight;
            
            %{
            %Top left corner
            if and(row - kVertEdgeDistTop <= 0, col - kHorizEdgeDistLeft <= 0)
                rowStart = 1
                colStart = 1
           
            %Top right corner
            elseif and(row - kVertEdgeDistTop <= 0, col + kHorizEdgeDistRight > xSize)
                rowStart = 1
                colEnd = xSize
                
                
            %Bottom left corner
            elseif 
            %}
            
            %Bottom right corner
            %Top row
            %Leftmost col
            %Rightmost col
            %Bottom row
            
            
            if row - kVertEdgeDistTop <= 0
                rowStart = 1;
            end
            
            if row + kVertEdgeDistTop > ySize
                rowEnd = ySize;
            end
            
            if col - kHorizEdgeDistLeft <= 0
                colStart = 1;
            end
                
            if col + kHorizEdgeDistRight > xSize
                colEnd = xSize;
            end
            
            inImgSample = inImg(rowStart:rowEnd, colStart:colEnd, rgb);
            outImg(row, col, rgb) = datasample(datasample(inImgSample, 1), 1);
            

        end
    end
    
end
end