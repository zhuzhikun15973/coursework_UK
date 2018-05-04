%%%%%%%%%%%%%%%% Auther: Zhikun Zhu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Date:   28/Feb/2018 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Modified: 2/May/2018 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Usage: This function simulate the total cost for one week.
%%% Input Variables:
% y:        Order number.
% nStock:   Stock at the end of previous week.
% x:        Apple consumption
% is_final: 0 or 1, verify if this is the final week.
%%% Return value:
% costCal:  Cost for one week.
% nStock:   Stock at the end of the week.
function [costCal,nStock] = appleSim(y,nStock,x,is_final)
nCost = 0;
r = 1;
% Place an order if stock less or equals to r.
if nStock <= r
    nStock = nStock + y;
end
% At the end of each week, we update our stock.
if nStock >= x
    nStock = nStock - x;
    nCost = nCost + nStock*5;
else
    nStock = 0;
    nCost = nCost + 20 ;
end

% At the end of 52th week, we need to return the remaind apple.
% Here only 5 coins is charged per unit, becasued the previous
% algorithm already charged 5 coints for storage, which is needless
% for the final week.
if is_final
    nCost = nCost + nStock*5;
end
costCal = nCost;

end