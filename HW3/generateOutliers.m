function [ outliers ] = generateOutliers(dlr, drl, trl)

imSize = size(dlr);
rowSize = imSize(1);
colSize = imSize(2);

for row = 1:rowSize
    for col = 1:colSize
        outliers(row, col) = (abs(dlr(row,col) - drl(row, col -  dlr(row, col))) <= trl);
      
    end
    
end


end