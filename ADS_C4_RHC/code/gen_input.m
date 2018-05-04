%%%%%%%%%%%%%%%% Auther: Zhikun Zhu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Date:   30/April/2018 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Usage: This function generate the input sequence.
%%% Input Variables:
% s: input space.
% k: prediction length.
%%% Return value:
% output:  n^k-by-k matrix with all the possible input length, where n is
% the total number of input space.

function output = gen_input(s,k)
n = length(s);
output = zeros(n^k,k);

for i = 1:k
    test = repmat(repelem(s,n^(i-1)),1,n^(k-i));
    output(:,(k-i+1)) = test';
end

end