%%%%%%%%%%%%%%%% Auther: Zhikun Zhu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Date:   30/April/2018 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Usage: This function used to simulate the total cost for predict input.
%%% Input Variables: 
%%%% x_predict: All possible order sequences for specific prediction horizon. 
%%%% present_state: Present stock.
%%%% temp_consum: Weekly consumption, column number is the same with x_predict.
%%%% is_final: 0 or 1, verify if the horizon contains the final week.
%%% Return value: 
% output: Cost among the horizon period for all possible order sequences.
function output = appleSimu(x_predict,present_state,temp_consum,is_final)
    % Get the total weeks and times we need to simulate.
    [n_simulate,N] = size(x_predict);
    output = zeros(n_simulate,1);
    r = 1;
    for k = 1:n_simulate
        nStock = present_state;
        nCost = 0;
        for n = 1:N
            % Place an order if stock less or equals to r.
            if nStock <= r
                nStock = nStock + x_predict(k,n);
            end
            % At the end of each week, we update our stock.
            if nStock >= temp_consum(n)
                nStock = nStock - temp_consum(n);
                nCost = nCost + nStock*5;
            else
                nStock = 0;
                nCost = nCost + 20 ;
            end
        end
        if is_final
            nCost = nCost + 5*nStock;
        end
        output(k) = nCost;
    end

    
end