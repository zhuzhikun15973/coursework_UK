function G = gaussianKernel(sigma,row,col)
    %================== Auther: Zhikun Zhu ===================%
    %================== Date: 14/Nov/2017 ====================%
    %================== E-mail: zz1u17@soton.ac.uk ===========%
    % Function: Generate Gaussian Kernels with random odd size. 
    % Example:
    % 	G = gKernelNew(3,3,5)
    %   G is a 3-by-5 Gaussian Kernel with sigma = 3;
    %   G = gKernelNew(2,3)
    %   G is a 3-by-3 Gaussian Kernel with sigma = 2;
    %   G = gKernelNew(1)
    %   G is a 9-by-9 Gaussian Kernel with sigma = 1;
    
    
    % Use 'nargin' to support different number of input.
    switch nargin
        % Full input, do nothing.
        case 3
        % Two input, square template row*row with variance = sigma.    
        case 2
            col = row;
        % One input, template size = s*s.    
        case 1            
            s = fix(8*sigma + 1);
            % Adjust s to be a odd number.
            if mod(s,2) == 0
                s = s + 1;
            end
            row = s;
            col = s;
        otherwise
            % For zero input, set output = 0.
            row = 1;
            col = 1;
    end
    wHalf = (row-1)/2;
    hHalf = (col-1)/2;
    G = zeros(row,col);
    % Calculate the denominator.
    denominator_1 = 2*pi*sigma^2;
    denominator_2 = 2*sigma^2;
    % Calculate the value of Gaussian template for each point.
    for x = -wHalf:wHalf
        for y = -hHalf:hHalf
            G((x+wHalf+1),(y+hHalf+1)) = 1/denominator_1*exp(-(x^2+y^2)/(denominator_2));
        end
    end
    % Normalize the template.
    G = 1/sum(G(:)).*G;

end
