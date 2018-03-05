% This script creates a menu driven application

%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% your information
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc;

% Display a menu and get a choice
choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter','Gauss Filter', 'Frosty', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous me');  % as you develop functions, add buttons for them here
 
% Choice 1 is to exit the program
while choice ~= 1
   switch choice
       case 0
           disp('Error - please choose one of the options.')
           % Display a menu and get a choice
           choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gauss Filter', 'Frosty', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous me');  % as you develop functions, add buttons for them here
        case 2
           % Load an image
           image_choice = menu('Choose an image', 'lena1', 'mandril1', 'sully', 'yoda', 'shrek');
           switch image_choice
               case 1
                   filename = 'lena1.jpg';
               case 2
                   filename = 'mandrill1.jpg';
               case 3
                   filename = 'sully.bmp';
               case 4
                   filename = 'yoda.bmp';
               % fill in cases for all the images you plan to use
           end
           current_img = imread(filename);
       case 3
           % Display image
           figure
           imagesc(current_img);
           if size(current_img,3) == 1
               colormap gray
           end
           
       case 4
           % Mean Filter
           
           % 1. Ask the user for size of kernel
           k_size = input('Choose your kernel size (Any value you want): ')
           % 2. Call the appropriate function
           newImage = meanFilter(current_img, k_size); % create your own function for the mean filter
           
           % 3. Display the old and the new image using subplot
           % ....
           im1 = subplot(1,2,1)
           im2 = subplot(1,2,2)
           image(current_img, 'Parent', im1)
           image(uint8(newImage), 'Parent', im2)
           newImgName = strcat('meanfilter', 'k', num2str(k_size), filename)
           imwrite(uint8(newImage), newImgName)
           
           % 4. Save the newImage to a file
           
              
       case 5
           k_size = input('Choose sigma for Gauss filter')
           newImage = gaussFilter(current_img, k_size);
           im1 = subplot(1,2,1)
           im2 = subplot(1,2,2)
           image(current_img, 'Parent', im1)
           image(uint8(newImage), 'Parent', im2)
           newImgName = strcat('gauss filter', 'k', num2str(k_size), filename)
           imwrite(uint8(newImage), newImgName)
           
           
       case 6
           n_size = input('Choose a value for n: ')
           m_size = input('Choose a value for m: ')
           newImage = frosty(current_img, n_size, m_size);
           im1 = subplot(1,2,1)
           im2 = subplot(1,2,2)
           image(current_img, 'Parent', im1)
           image(uint8(newImage), 'Parent', im2)
           newImgName = strcat('frosty', 'n', num2str(n_size), 'm', num2str(m_size), filename)
           imwrite(uint8(newImage), newImgName)
           
       case 7
           factor = input('Choose a value for the scaling factor: ')
           newImage = scaleNearest(current_img, factor);
           im1 = subplot(1,2,1)
           im2 = subplot(1,2,2)
           image(current_img, 'Parent', im1)
           image(uint8(newImage), 'Parent', im2)
           newImgName = strcat('scalenearest', 'f', num2str(factor), filename)
           imwrite(uint8(newImage), newImgName)
           
       case 8
           factor = input('Choose a value for the scaling factor: ')
           newImage = scaleBilinear(current_img, factor);
           im1 = subplot(1,2,1)
           im2 = subplot(1,2,2)
           image(current_img, 'Parent', im1)
           image(uint8(newImage), 'Parent', im2)
           newImgName = strcat('scalebilinear', 'f', num2str(factor), filename)
           imwrite(uint8(newImage), newImgName)
           
       case 9
           factor = input('Choose a value for swirl factor: ')
           ox = input('Choose x coordinate for swirl origin: ')
           oy = input('Choose y coordinate for swirl origin: ')
           newImage = swirlFilter(current_img, factor, ox, oy);
           im1 = subplot(1,2,1)
           im2 = subplot(1,2,2)
           image(current_img, 'Parent', im1)
           image(uint8(newImage), 'Parent', im2)
           
           
       case 10
           ox = input('Choose row # for upper left of paste box')
           oy = input('Choose colum # for upper left of paste box')
           newImage = famousMe(current_img, imread('nick.jpg'), ox , oy);
           im1 = subplot(1,3,1)
           im2 = subplot(1,3,2)
           im3 = subplot(1,3,3)
           image(current_img, 'Parent', im1)
           image(imread('nick.jpg'), 'Parent', im2)
           image(newImage, 'Parent', im3)
           newImgName = strcat('famousme', 'nick', 'ox', num2str(ox), 'oy', num2str(oy),filename)
           imwrite(uint8(newImage), newImgName)
           
           
       %....
   end
   % Display menu again and get user's choice
   choice = menu('Choose an option', 'Exit Program', 'Load Image', ...
    'Display Image', 'Mean Filter', 'Gauss Filter', 'Frosty', 'Scale Nearest', 'Scale Bilinear', 'Swirl Filter', 'Famous me');  % as you develop functions, add buttons for them here
end
