%%% Algorithm particle filter.
%%% Input variables:
%%%%% yMeasure: 1-by-k observation state.
%%%%% N_particle: Number of particles.
%%%%% Q: Variance of state noise. 
%%%%% R: Variance of observation noise. 
%%% Output: 
%%%%% xEstimate: 1-by-k estimation state.
function xEstimate = particleF(yMeasure,N_particle,Q,R)
    % Get the estimation length.
    k = length(yMeasure);
    % Random generate N initial state x0 according to its distribution.
    x0_rand = randn(1,N_particle);
    % Used to store the relative likelihoods.
    q = zeros(1,N_particle);
    xState = x0_rand;
    xEstimate = zeros(1,k);
    for i = 1:k
        % Calculate the a priori of x_k for all random initial state.
        for nTemp = 1:N_particle
            xState(nTemp) = xState(nTemp)/2 + 25*xState(nTemp)/(1+xState(nTemp)^2) + 8*cos(1.2*i) + mvnrnd(0,Q);
        end
        % Get the measurement at time i.
        for nTemp = 1:N_particle
            q(nTemp) = normpdf((yMeasure(i)-xState(nTemp)^2/20),0,R);
        end
        % Normalization and resampling of the relative likelihoods.
        qCDF = cumsum(q./sum(q));
        %plot(qCDF)
        tempOriginalP = xState;
        for nRe = 1:N_particle
            r = rand(1);
            c = find(qCDF >= r);
            xState(nRe) = tempOriginalP(c(1));
        end
        %hist(temp,25)
        xEstimate(i) = mean(xState);
        %xEstimate(i) = temp*q'/sum(q);
        %disp(mean(temp));
    end
end