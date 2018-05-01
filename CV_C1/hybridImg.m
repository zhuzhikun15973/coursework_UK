function nImg = hybridImg(img_1,img_2,sigma_1,sigma_2)
    %===================== Algorithm begins ==================%
    %===================== Auther: Zhikun Zhu ================%
    %===================== Date: 10/11/2017 ==================%
    % Function: Filtered two input images with two LPF. Support different
    % size of two input images. Hybrid the first image's low frequency
    % conponents with second image's high frequency conponents. Pad zeros
    % to the small size image if two images have different size.
    
    % Note: It is suggested that the two input images have the same size
    % and same colour type. If not, the algorithm will pad zeros to the
    % small size image.
    
    [row_1,col_1,v_1] = size(img_1);
    [row_2,col_2,v_2] = size(img_2);
    % Verify if two image are both colour or mono, change both to gray if not.
    if v_1 ~= v_2
        img_1 = rgb2gray(img_1);
        img_2 = rgb2gray(img_2);
    end
    % Verify if two image have same length of row, pad it if not.
    if row_1 ~= row_2
        num = abs(row_1-row_2);
        if row_1 > row_2
            % Pad zeros before the first row and after the last row. The
            % paded size in this two areas are equal if 'num' is even. Pad
            % one more row to the bottom area if 'num' is odd.
            img_2 = padarray(img_2,[fix(num/2) 0],'pre');
            img_2 = padarray(img_2,[(fix(num/2)+mod(num,2)) 0],'post');
        else
            img_1 = padarray(img_1,[fix(num/2) 0],'pre');
            img_1 = padarray(img_1,[(fix(num/2)+mod(num,2)) 0],'post');
        end   
    end
    % Verify if two image have same length of column, pad it if not.
    if col_1 ~= col_2
        num = abs(col_1-col_2);
        if col_1 > col_2
            img_2 = padarray(img_2,[0 fix(num/2)],'pre');
            img_2 = padarray(img_2,[0 (fix(num/2)+mod(num,2))],'post');
        else
            img_1 = padarray(img_1,[0 fix(num/2)],'pre');
            img_1 = padarray(img_1,[0 (fix(num/2)+mod(num,2))],'post');
        end   
    end
    % Generate template and do template convolution and bybrid.
    tep_1 = gaussianKernel(sigma_1);
    tep_2 = gaussianKernel(sigma_2);
    img_1l = tempConv(img_1,tep_1);
    img_2l = tempConv(img_2,tep_2);
    img_2h = im2double(img_2) - img_2l;
    nImg = img_1l + img_2h;
end