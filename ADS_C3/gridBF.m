%%% Algorithm Grid-based filter.
%%% Input variables:
%%%%% yMeasure: 1-by-k observation state.
%%%%% nGrid: Number of grid ponits.
%%%%% Q: Variance of state noise. 
%%%%% R: Variance of observation noise. 
%%% Output: 
%%%%% xEstimate: 1-by-k estimation state.
%%%%% finalPdf: Posterior PDF of the state for each k.
function [xEstimate,finalPdf] = gridBF(yMeasure,nGrid,Q,R)
    % Get the total estimation time.
    k = length(yMeasure);
    % Discrete the state space.
    x_start = -25;
    x_end = 25; 
    x_axis = linspace(x_start,x_end,(nGrid+1));
    % Get the posterior state of x0.
    x0_CDF = normcdf(x_axis,0,1);
    x0_GBF = x0_CDF(2:end) - x0_CDF(1:end-1);
    x_axis = x_axis(1:end-1);
    % Initialize the prior and poster state estimate.
    xPrior = zeros(1,length(x_axis));
    xPoster = x0_GBF;
    % Decare the size of variables.
    temp_z = zeros(1,length(x_axis));
    xEstimate = zeros(1,k);
    finalPdf = zeros(k,length(x_axis));

    for k = 1:100 
        % Predication: Get prior state at k.
        for i = 1:length(x_axis)
            for j = 1:length(x_axis)
                x_state = x_axis(j)/2 + 25*x_axis(j)/(1+x_axis(j)^2) + 8*cos(1.2*k);
                temp_x = x_axis(i) - x_state;
                xPrior(i) = xPrior(i) + normpdf(temp_x,0,sqrt(Q))*xPoster(j);
            end
        end
        % Update: Get posterior state at k.
        for i = 1:length(x_axis)
            y_state = yMeasure(k)- x_axis(i).^2/20;
            temp_z(i) = normpdf(y_state,0,sqrt(R)); 
            xPoster(i) = xPrior(i)*temp_z(i); 
        end
        xPoster = xPrior.*temp_z/(xPrior*temp_z');
        % Store the posterior PDF for each k.
        finalPdf(k,:) = xPoster;
        % Estimate the state by expection.
        xEstimate(k) =  x_axis*xPoster';
        % Reset prior.
        xPrior = zeros(1,length(x_axis));
    end
end