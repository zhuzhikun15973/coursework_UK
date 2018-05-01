%%% Algorithm Iterated EKF.
%%% Input variables:
%%%%% yMeasure: 1-by-k observation state.
%%%%% Q: Variance of state noise. 
%%%%% R: Variance of observation noise. 
%%% Output: 
%%%%% xEstimate: 1-by-k estimation state.
function xEstimate = iterateEKF(yMeasure,Q,R)
    % Get the total estimation time.
    k = length(yMeasure);
    x0 = 0; % Mean of the distribution of x0. x0~ N(0,1)
    P0 = 1; % Variance of x0;
    L = 1;
    M = 1;
    A = 1/2 + 25*(1-x0^2)/(1+x0^2)^2;
    C = x0/10;
    xPoster = x0;
    PPoster = P0;
    K = PPoster*C'*(M*R*M')^-1;
    xEstimate = zeros(1,k);
    for i = 1:k

        xPrior = xPoster/2 + 25*xPoster/(1+xPoster^2) + 8*cos(1.2*(i+1));
        PPrior = A*PPoster*A' + L*Q*L';

        A = 1/2 + 25*(1-xPrior^2)/(1+xPrior^2)^2;
        C = xPrior/10;
        xPoster = xPrior;
        pPoster0 = PPrior;
        for j = 1:100
            H = xPoster/10;
            K = PPrior*H'*(H*PPrior*H' + M*R*M')^-1;
            PPoster = (1 - K*H)*PPrior*(1 - K*H)' + K*R*K';
            xPoster= xPrior + K*(yMeasure(i) - xPoster^2/20 - H*(xPrior - xPoster) );
        end

        xEstimate(i) = xPoster;

    end
end