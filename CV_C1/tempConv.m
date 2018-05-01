function nImg = tempConv(image,te)
    %===================== Algorithm begins ==================%
    %===================== Auther: Zhikun Zhu ================%
    %===================== Date: 10/11/2017 ==================%
    % Function: Calculate the template convolution of input image.
    % Support both gray and colour images.
    % Note: The number of the rows and columns of the template must equals
    % zero.
    
    % Change data type for the convenience of following calculations.
    img = im2double(image);
    % State the size of new image(Same with old image).
    nImg = zeros(size(img));
    % Get template size.
    [teRow,teCol] = size(te);
    teRhalf = (teRow-1)/2;
    teChalf = (teCol-1)/2;
    % Get size after expand.
    [imRow,imCol,n] = size(img);


    %Calculate templete convolution for RGB, respectively. If the input image
    %is mono, then n = 1.
    for i = 1:n
        % Pad image to suit convolution size.
        imPad = padarray(img(:,:,i),[teRhalf teChalf],'both');
        for x = (teChalf+1):(imCol+teChalf)
            for y = (teRhalf+1):(imRow+teRhalf)
                % Get the spectific area of image to convolve with template
                part = imPad((y-teRhalf):(y+teRhalf),(x-teChalf):(x+teChalf));
                % Matrixes dot product.
                temp = te.*part;
                % Sum all elements in temp to get new pixel's value.
                nPixel = sum(temp(:));
                % Save the new pixel in new image. 
                nImg((y-teRhalf),(x-teChalf),i) = nPixel;

            end
        end
    end
end

