function [ xyzPoints ] = computeDepth( disparity, stereoParams)
    imSize = size(disparity)
    c1 = stereoParams.CameraParameters1.PrincipalPoint;
    c2 = stereoParams.CameraParameters2.PrincipalPoint;  
    B = sqrt((c2(1) - c1(1))^2 + (c2(2) - c1(2))^2);
    f = mean(stereoParams.CameraParameters1.FocalLength);
    for row = 1:imSize(1)
        for col = 1:imSize(2)
           
            Z = (f * B)/disparity(row, col);
            xyzPoints(row, col, 1) = col;
            xyzPoints(row, col, 2) = row;
            xyzPoints(row, col, 3) = Z;
            
            
        end
        
    end
    



end