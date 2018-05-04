function costCal = appleSim(y,r,x)
%%%%%%%%%%%%%%%% Auther: Zhikun Zhu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Date:   28/Feb/2018 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Usage: This function utilize Monte Carlo method to simulate the total
%%% cost within the 'nWeek' periods. 
%%% Input Variables: 
% y:        Order number defined in the coursework.
% r:        Re-order stock level.
% x:        Random variables which follows the apple consumption distribution,
%           which row number is period length and column number is run length.
%%% Return value: 
% costCal:  N-by-1 matrix of simulation results for each run.
    %% Simulation for 'nWeek' weeks.
    % Get the total weeks and times we need to simulate.
    [nWeek,N] = size(x);
    costCal = zeros(N,1);
    for k = 1:N  
        nStock = 0;
        nCost = 0;
        for n = 1:nWeek
            % Place an order if stock less or equals to r.
            if nStock <= r
                nStock = nStock + y;
            end
            % At the end of each week, we update our stock.
            if nStock >= x(n,k)
                nStock = nStock - x(n,k);
                nCost = nCost + nStock*5;
            else
                nStock = 0;
                nCost = nCost + 20 ;
            end
        end
        % At the end of 52th week, we need to return the remaind apple.
        nCost = nCost + nStock*10;
        costCal(k) = nCost;
    end
end