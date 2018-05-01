function nimg = convm(image,te)
    %================= Algorithm begins ==============
    % Change data type for the convenience of following calculations.
    img = im2double(image);
    % State the size of new image(Same with old image).
    nimg = zeros(size(img));
    % Get template size.
    [terow,tecol] = size(te);
    terhalf = (terow-1)/2;
    techalf = (tecol-1)/2;
    % Get size after expand.
    [imrow,imcol,n] = size(img);


    %====================== Convolution Start ========================%
    %Calculate templete convolution for RGB, respectively. If the input image
    %is mono, then n = 1.
    for i = 1:n
        % Pad image to suit convolution size.
        impad = padarray(img(:,:,i),[terhalf techalf],'both');
        for x = (techalf+1):(imcol+techalf)
            for y = (terhalf+1):(imrow+terhalf)
                % Get the spectific area of image to convolve with template
                test = impad((y-terhalf):(y+terhalf),(x-techalf):(x+techalf));
                % Matrixes dot product.
                temp = te.*test;
                % Sum all elements in temp to get new pixel's value.
                npixel = sum(temp(:));
                % Save the new pixel in new image. 
                nimg((y-terhalf),(x-techalf),i) = npixel;

            end
        end
    end
end

