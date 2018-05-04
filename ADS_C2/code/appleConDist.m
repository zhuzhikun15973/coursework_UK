function x = appleConDist(D,p,nWeek,N)
%%%%%%%%%%%%%%%% Auther: Zhikun Zhu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Date:   28/Feb/2018 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Usage: This function utilize Rejection method to generate random
%%% variables of specific discrete distribution.
%%% Input Variables: 
% D:      All incidents.
% p:      Probability of incidents with respect to element in D.
% nWeek:  Total week period of simulation.
% N:      Run length of simulation.
%%% Output Variables:
% x:      nWeek-by-N matrix contains RV of the discrete distribution.

    %% Calculalte probability of discrete uniform distribution U(0:9).
    pUni = (1/length(D));
    a = max(p)/pUni;
    x = zeros(nWeek,N);
    % Use rejection method to generate N samples which follows distribution p.
    for k = 1:N
        n = 0;
        while n < nWeek
            y = unidrnd(length(D))-1;
            uniRV = rand(1);
            if uniRV <= p(y+1)/(a*pUni)
                x(n+1,k) = y;   
                n = n + 1;
            end 
        end
    end
end