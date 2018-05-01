%%%%% Algorithm to generate state sequence with length k and perform Monte Carlo simulation. 
%%%%% Input:
% x0: Initial state.
% k: Number of time slots.
% N: Number of runs for Monte Carlo algorithm.
% Q: Variance of state noise v_k.
%%%%% Output:
% result: N-by-k matrix contains states for k times and N simulation runs.
function result = spdfe(k,N,Q)

    % Store simulation results.
    result = zeros(N,k);
    for i = 1:N
        %temp = x0;
        temp = mvnrnd(0,1);
        for j = 1:k
            temp = temp/2 + 25*temp/(1+temp^2) + 8*cos(1.2*j) + sqrt(Q)*randn(1);
            result(i,j) = temp;
        end
        
    end
end