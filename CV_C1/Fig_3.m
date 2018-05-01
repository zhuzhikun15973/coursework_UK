
% Auther: Zhikun Zhu; Date: 15/Nov/2017.
% Function: Hybrid four pair of images. Generate Fig.3 in the report.
clear
img1 = imread('data/bird.bmp');
img2 = imread('data/plane.bmp');
% Hybrid images with sigma_1=3 and sigma_2=3, respectively.
hybrid = hybridImg(img1,img2,3,3);
% Save image data into 'fig'.
fig = figure;
subplot(2,2,1);
imshow(hybrid)
xlabel('Plane (high f) & Bird (low f)','FontSize',16)

img1 = imread('data/dog.bmp');
img2 = imread('data/cat.bmp');
% Hybrid images with sigma_1=4 and sigma_2=5, respectively.
hybrid = hybridImg(img1,img2,4,5);
subplot(2,2,2)
imshow(hybrid)
xlabel('Dog & Bird','FontSize',16)

img1 = imread('data/bicycle.bmp');
img2 = imread('data/motorcycle.bmp');
% Hybrid images with sigma_1=4 and sigma_2=5, respectively.
hybrid = hybridImg(img1,img2,4,5);
subplot(2,2,3)
imshow(hybrid)
xlabel('Bicycle & Motorcycle','FontSize',16)

img1 = imread('data/fish.bmp');
img2 = imread('data/submarine.bmp');
% Hybrid images with sigma_1=4 and sigma_2=4.5, respectively.
hybrid = hybridImg(img1,img2,4,4.5);
subplot(2,2,4)
imshow(hybrid)
xlabel('Fish & Submarine','FontSize',16)
% Export images.
saveas(fig,'Fig_3.png');