clear
clc
close all
%% Initialize data.
D = 0:6;                                    % Demand x.
p = [0.04,0.08,0.28,0.4,0.16,0.02,0.02]';   % Probability p(x).

nStock = 0;                                 % Initialize stock.
cost = 0;                                   % Initialize cost.
nWeek = 52;                                 % Initialize time period.
N = 100;                                    % Initialize Monte Carlo run length.
n_predict = 3;                              % Initialize prediction horizon.
order_stock = zeros(52,2);                  % Store the order number for 0~51 week and stock for 1~51 week.

% Define order space.
x_start = 1;                                
x_end   = 5;
x_state = x_start:x_end;
x_predict = gen_input(x_state,n_predict);  
% Define demand space and repsective probability.
consum_predict = gen_input(D,n_predict); 
consum_pdf1 = zeros(size(consum_predict));
consum_pdf = ones(size(consum_predict,1),1);

for i = 1:length(D)
    [x_tag,y_tag] = find(consum_predict == D(i));
    consum_pdf1(x_tag,y_tag) = p(i);
end
for i = 1:size(consum_predict,2)
    consum_pdf = consum_pdf.*consum_pdf1(:,i);
end
%% Simulation
% Monte Carlo simulation the RHC algorithm to get the confidence interval.
split_cost = zeros(1,x_end);                            % Initialize prediction cost for control horizon N_C = 1.
mc_cost = zeros(1,N);                                   % Initialize array to store cost for Monte Carlo simulation.
for nMC = 1:N
    consum_nWeek = appleConDist(D,p,nWeek,1);           % Generate nWeek apple consumption RVs.
    present_state = 0;                                  % Reset stock number.
    real_cost = cost;                                   % Reset cost.
    [m,n] = size(x_predict);
    sum_temp_cost = zeros(m,length(consum_predict));
    % Simulation the cost for the nWeek period.
    for i = 1:nWeek
        % 'if' here used to verify is the prediction horizon contanin the
        % final week. And gurantee that prediction horizon won't exceed
        % 52-week-period.
        if i <= nWeek - n_predict
            % Model Predictive Control, also known as RHC. 
            for k = 1:length(consum_predict)
                temp_cost = appleSimu(x_predict,present_state,consum_predict(k,:),0);
                sum_temp_cost(:,k) = temp_cost;
            end
            % Find the input with minimum cost.
            for q = x_start:x_end
                x_tag = find(x_predict(:,1) == q);
                split_cost(q) = sum(sum(sum_temp_cost(x_tag,:).*consum_pdf'));
            end
            temp_input = find(split_cost == min(split_cost));

            % Assign the input as real input and get cost for that week.
            [temp_real_cost,nStock] = appleSim(temp_input(1),present_state,consum_nWeek(i),0);
            real_cost = real_cost + temp_real_cost;
        elseif i <= nWeek
            x_cut = x_predict(1:length(x_state)^(nWeek-i+1),end-(nWeek-i):end);
            sum_temp_cost = zeros(length(x_state)^(nWeek-i+1),length(consum_predict));
            % Model Predictive Control
            for k = 1:length(consum_predict)
                temp_cost = appleSimu(x_cut,present_state,consum_predict(k,:),1);
                sum_temp_cost(:,k) = temp_cost;
            end
            % Find the input with minimum cost.
            for q = x_start:x_end
                x_tag = find(x_cut(:,1) == q);
                split_cost(q) = sum(sum(sum_temp_cost(x_tag,:).*consum_pdf'));
            end
            temp_input = find(split_cost == min(split_cost));
            % Assign the input as real input and get cost for that week.
            [temp_real_cost,nStock] = appleSim(temp_input(1),present_state,consum_nWeek(i),0);
            real_cost = real_cost + temp_real_cost;
        end
        present_state = nStock;
        order_stock(i,:) = [temp_input(1),nStock];
    end
    mc_cost(nMC) = real_cost;
end

%% Figure plotting.
 hist(mc_cost,25)
 xlabel('Total cost among the period','FontSize',16)
 ylabel('Number of appearance','FontSize',16)
disp(order_stock)
disp(['Mean cost among N = ',num2str(N),' simulations: ',num2str(mean(mc_cost))])
