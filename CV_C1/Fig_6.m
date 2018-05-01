% Auther: Zhikun Zhu; Date: 15/Nov/2017.
% Function: Generate a texture to shade characters in the long distance,
% which is shown in Fig.6 of the report.
clear
% Import data.
words = im2double(imread('data/uos.png'));
cover = im2double(imread('data/test.jpg'));
% Reset the image size of characters to have same length of columns with
% texture.
words = imresize(words, 0.4);
% Save the resized characters image in a temporary variable for future
% comparsion.
temp = words;
% Repeat the characters image two times.
words = cat(1,words,words);
[row,col,vol] = size(words);
% Shape the cover to have same size with 'words'.
cover = cover(40:row+39,1:col,:);

% Generate two Gaussian templates and filter two images.
lpf_1 = gaussianKernel(1);
lpf_2 = gaussianKernel(11,13,13);
words_l = tempConv(words,lpf_1);
cover_l = tempConv(cover,lpf_2);

words_h = words-words_l+0.5;
result = cover_l+words_h-0.5;
result = cat(1,temp,result);

imshow(result)
% Export image.
imwrite(result,'Fig_6.png')