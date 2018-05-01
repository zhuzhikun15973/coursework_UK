function nImg = stepShrink(img,n)
    %================== Auther: Zhikun Zhu ===================%
    %================== Date: 14/Nov/2017 ====================%
    %================== E-mail: zz1u17@soton.ac.uk ===========%
    % Function: Shrink the size of input img exponentially in n 
    % step, and save original and all intermediate images in a 
    % new image.
    % Example: nImg = stepShrink(img,3) generate three reduced 
    % sized form of original image and joint them together with
    % the original image into a new image.
    
    [row,~,~] = size(img);
    nImg = img;
    for i = 1:n
        % Shink the previous image by a factor of 0.5 each time.
        n = 0.5^i;
        % Pad the row of the new image with white colour.
        temp = padarray(imresize(img, n),[fix(row*(1-n)),0],255,'pre');
        % Joint two images which have same length of rows.
        nImg = cat(2,nImg,temp);
    end
end