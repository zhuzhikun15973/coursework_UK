% Auther: Zhikun Zhu; Date: 15/Nov/2017.
% Function: Plot the amplitude spectrum of filtered images as well as space
% images, which is shown in Fig.4 in report.
clear
clear
% Import images.
Cat = im2double(imread('data/dog.bmp'));
C = Cat;
[row,col,v] = size(C);
Dog = im2double(imread('data/cat.bmp'));
D = Dog;

% Define Gaussian template (size = 25*25, sigma = 2) and do template convolution;
lpf = gKernelNew(4,25);
C_l = tempConv(C,lpf);
D_l = tempConv(D,lpf);
% Get high frequency conponents of second image.
D_h = D - D_l+0.5;
% Get amplitude spectrum of each images by 'fft2' and shift the low
% frequency to the centre of the spectrum by 'fftshift'. The amplitude
% spectrum are scaled by log, since the value in the centre are too high.
% Then the histgorm of each image is normalized.
C_f = fft2(C_l);
s_C_f = normine(log(1 + abs(fftshift(C_f))));
D_f = fft2(D_h-0.5);
s_D_f = normine(log(1 + abs(fftshift(D_f))));

% Joint four images togher into one image, and set a border between each
% image.
edge = 10;
joint1 = cat(2,s_C_f,ones(row,edge,3),C_l);
joint2 = cat(2,s_D_f,ones(row,edge,3),D_h);
joint = cat(1,joint1,ones(edge,(col*2+edge),3),joint2);
imshow(joint);
imwrite(joint,'Fig_4.png')




