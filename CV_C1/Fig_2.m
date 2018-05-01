clear
% Auther: Zhikun Zhu; Date: 15/Nov/2017.
% Function: This file is used to generate Fig.2 in the report.
% Import images.
img1 = imread('data/fish.bmp');
img2 = imread('data/submarine.bmp');
[~,n] = size(img1);

% Generate two GAUSSIAN Templates for separate processing.
lpf_1 = gaussianKernel(4);
lpf_2 = gaussianKernel(5);

% Filtered the images wit LPF.
img1_l = tempConv(img1,lpf_1);
img2_l = tempConv(img2,lpf_2);

% Get images_2's high frequency conponents
img2_hpf = (im2double(img2)-img2_l)+0.5;
% Hybrid two images together.
hybrid = img1_l+img2_hpf-0.5;
% Generate step shrink images for demonstration.
joint = stepShrink(hybrid,3);
imshow(joint)
title('Hybrid fish (LPF) and submarine (HPF)','FontSize',16)
% Export step shrink image.
imwrite(joint,'Fig_2.png');