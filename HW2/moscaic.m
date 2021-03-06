image = imread('uttower2.jpg');
image2 = imread('uttower1.jpg');

imgPoints = round([344.9219  905.8642  323.1510  456.6921;
  536.3080  780.2214  504.9886  325.1185;
  540.6909  638.5080  506.4670  178.7614;
  556.7615  638.5080  521.2505  180.2397;
  498.3230  911.7080  466.5514  450.7787;
  496.8620  935.0834  469.5081  475.9107;
  393.1337  952.6150  371.9367  495.1293;
  327.3904  930.7005  306.8891  478.8674;
  622.5048  580.0695  589.2549  110.7570;
  645.8802  778.7604  612.9085  316.2484])

imSize = size(image);
im2Size = size(image2);
rgb = imSize(3);
col = imSize(2);
row = imSize(1);
homo = computeH(imgPoints);
maxIndices1 = round(homo * [row col 1]');
maxIndices1 = maxIndices1/maxIndices1(3);
maxIndices2 = round(homo * [0 col 1]');
maxIndices2 = maxIndices2/maxIndices2(2);
maxIndices3 = round(homo * [row 0 1]');
maxIndices3 = maxIndices3/maxIndices3(3);
maxIndices4 = round(homo * [0 0 1]');
maxIndices4 = maxIndices4/maxIndices4(3);
maxCol = round(max([maxIndices1(2) maxIndices2(2) maxIndices3(2) maxIndices4(2)]));
maxRow = round(max([maxIndices1(1) maxIndices2(1) maxIndices3(1) maxIndices4(1)]));
minCol = round(min([maxIndices1(2) maxIndices2(2) maxIndices3(2) maxIndices4(2)]));
minRow = round(min([maxIndices1(1) maxIndices2(1) maxIndices3(1) maxIndices4(1)]));
%outImg = zeros([maxIndices(1), maxIndices(2), 3]);
outImg = []
invHomo = inv(homo);
track = []

%{
img1mark = [500 500 1]'
img2mark = homo * img1mark;
img2mark = round(img2mark/img2mark(3));
img1axes = [img1mark(1) img1mark(2)]
img2axes = [img2mark(2) img2mark(1)]
image1coords = insertMarker(image, img1axes);
image2coords = insertMarker(image2, img2axes);



imshow(uint8(image1coords));
imshow(uint8(image2coords));

%}





for c = minCol:maxCol
    for r = minRow:maxRow
        xlated = invHomo * [r c 1]';
        xlated = xlated/xlated(3);
        
        if xlated(1) <= 0 || xlated(2) <= 0 || xlated(1) > row || xlated(2) > col
            continue
            
        end
            
        img2Coords = homo * xlated;
        img2Coords = round(img2Coords/img2Coords(3));
        if img2Coords(1) == 1 && img2Coords(2) == 1
            img2Coords;
            topLeftImg2 = [(r + abs(minRow) + 1) (c + abs(minCol) + 1) 1];
        end
        
        
        outRow = r + abs(minRow) + 1;
        outCol = c + abs(minCol) + 1;
        outImg(outRow, outCol, :) = image(ceil(xlated(1)), ceil(xlated(2)), :);
       
    end
    
end

topLeftImg2
for col = topLeftImg2(2) + 1:topLeftImg2(2) + im2Size(2)
    for row = topLeftImg2(1) + 1:topLeftImg2(1) + im2Size(1);
        row2 = row - topLeftImg2(1);
        col2 = col - topLeftImg2(2);
        outImg(row, col, :) = image2(row2, col2, :);
        
    end
end
figure
imagesc(uint8(outImg))
