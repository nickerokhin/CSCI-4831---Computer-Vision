load('handshakeStereoParams.mat')

frameLeft = imread('frame_1L.png')
frameRight = imread('frame_1R.png')
frameLeftGray = rgb2gray(frameLeft)
frameRightGray = rgb2gray(frameRight)

%Calculate disparity using the SSD algorithm

figure;

disparityMap = disparity(frameLeftGray, frameRightGray);
disparityMapssd1 = ssdDisparity(frameLeftGray, frameRightGray, 1);
disparityMapssd5 = ssdDisparity(frameLeftGray, frameRightGray, 5);
disparityMapssd11 = ssdDisparity(frameLeftGray, frameRightGray, 11);

im1 = subplot(2,2,1)
im2 = subplot(2,2,2)

im3 = subplot(2,2,3)
im4 = subplot(2,2,4)

image(disparityMap, 'Parent', im1)
image(disparityMapssd1, 'Parent', im2)

image(disparityMapssd5, 'Parent', im3)
image(disparityMapssd11, 'Parent', im4)

colormap jet
colorbar
%Calculate disparity using the NCC algorithm


disparityMapncc3 = nccDisparity(frameLeftGray, frameRightGray, 3);
disparityMapncc5 = nccDisparity(frameLeftGray, frameRightGray, 5);
disparityMapncc7 = nccDisparity(frameLeftGray, frameRightGray, 7);


figure;

im1 = subplot(2,2,1)
im2 = subplot(2,2,2)

im3 = subplot(2,2,3)
im4 = subplot(2,2,4)


image(disparityMap, 'Parent', im1)
image(disparityMapncc3, 'Parent', im2)

image(disparityMapncc5, 'Parent', im3)
image(disparityMapncc7, 'Parent', im4)

colormap jet
colorbar

%Uniqueness constraint


disparityMapssd3Unique = ssdDisparity(frameLeftGray, frameRightGray, 1);
disparityMapncc3Unique = ssdDisparity(frameLeftGray, frameRightGray, 3);


figure;

im1 = subplot(1,2,1)
im2 = subplot(1,2,2)

image(disparityMapssd3Unique, 'Parent', im1)
image(disparityMapssd3Unique, 'Parent', im2)

colormap jet
colorbar

%Generate outliers

dlrncc = nccDisparity(frameLeftGray, frameRightGray, 3);
frameLGray2 = fliplr(frameLeftGray);
frameRGray2 = fliplr(frameRightGray);
drlncc = nccDisparity(frameRGray2, frameLGray2, 3);
drlncc = fliplr(drlncc);
outliersncc = generateOutliers(dlrncc,drlncc, 1);


dlrssd = nccDisparity(frameLeftGray, frameRightGray, 3);
drlssd = nccDisparity(frameRGray2, frameLGray2, 3);
drlssd = fliplr(drlssd);
outliersssd = generateOutliers(dlrssd,drlssd, 1);



figure;

im1 = subplot(1,2,1)
im2 = subplot(1,2,1)

image(outlierncc, 'Parent', im1)
image(outliersssd, 'Parent', im2)


%Compute depth from disparity

disparityMap = nccDisparity(frameLeftGray, frameRightGray, 11);

% Reconstruct 3-D scene.
points3D = computeDepth(disparityMap, stereoParams);
points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', frameLeftRect);
view(player3D, ptCloud);
    

figure;

errorMap = createErrorMap(disparityMap5, imread('frame_1LR.png'));
disparityDiff = makeDisparityDifferences(disparityMap5, imread('frame_1LR.png'));


%disparity map
im1 = subplot(2,2,1)
%ground truth
im2 = subplot(2,2,2)
%error map
im3 = subplot(2,2,3)
%histogram differences

image(disparityMap5, 'Parent', im1)
image(imread('frame_1LR.png'), 'Parent', im2)
image(errorMap, 'Parent', im3)

figure;

histogram(disparityDiff)

fLeftSize = size(frameLeftGray)
disparityMapDP = zeros(fLeftSize);


for row = 1:fLeftSize(1)
    
    e1 = frameLeftGray(row, :);
    e2 = frameRightGray(row, :);
    size(e1);
    size(e2);
    
    dispRow = stereoDP(e1, e2, 100, 1.01);
    dispRow = dispRow - min(dispRow);
    disparityMapDP(row, :) = dispRow(2:end);
    

end


figure;
image(disparityMapDP)
colormap jet
colorbar
