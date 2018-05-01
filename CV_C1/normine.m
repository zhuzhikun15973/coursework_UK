function n = normine(data)
    %================== Auther: Zhikun Zhu ===================%
    %================== Date: 15/Nov/2017 ====================%
    %================== E-mail: zz1u17@soton.ac.uk ===========%
    % Function: Normalize the value of input image array to fit
    % all colour space between [0 1].

    max_data = max(data(:));
    min_data = min(data(:));
    n = (data-min_data)./(max_data-min_data);
    
end