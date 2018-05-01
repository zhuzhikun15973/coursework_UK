%%% Algorithm EKF.
%%% Input variables:
%%%%% yMeasure: 1-by-k observation state.
%%%%% Q: Variance of state noise. 
%%%%% R: Variance of observation noise. 
%%% Output: 
%%%%% xEstimate: 1-by-k estimation state.
function xEstimate = extendKF(yMeasure,Q,R)
    
    % Get the total estimation time.
    k = length(yMeasure);
    x0 = 0; % Mean of the distribution of x0. x0~ N(0,1)
    P0 = 1; % Variance of x0;
    L = 1;
    M = 1;
    A = 1/2 + 25*(1-x0^2)/(1+x0^2)^2;
    C = x0/10;
    xPosterior = x0;
    PPosterior = P0;
    tempK = PPosterior*C'*(M*R*M')^-1;
    xEstimate = zeros(1,k);
    for i = 1:k

        xPrior = xPosterior/2 + 25*xPosterior/(1+xPosterior^2) + 8*cos(1.2*(i+1));
        PPrior = A*PPosterior*A' + L*Q*L';

        A = 1/2 + 25*(1-xPrior^2)/(1+xPrior^2)^2;
        C = xPrior/10;

        xPosterior = xPrior + tempK*(yMeasure(i) - xPrior^2/20);
        xEstimate(i) = xPosterior;

        tempK = PPrior*C'*(C*PPrior*C' + M*R*M')^-1;
        PPosterior = (1 - tempK*C)*PPrior*(1 - tempK*C)' + tempK*R*tempK';

    end
end