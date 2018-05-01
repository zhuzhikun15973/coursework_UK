%%%% Main program for the coursework. Inspect function files for detailed implementation.
%% Task 1: Monte Carlo simulation
Q = 10;
%x0 = mvnrnd(0,1);
N = 5000;
k = [1,50,100];

for i = 1:length(k)
    x0 = mvnrnd(0,1);
    result = spdfe(k(i),N,Q);
    disp(mean(mean(result)))
    
    %plot(result(:,end))
    subplot(3,1,i)
    hist(result(:,end),50)
    title(['Monte Carlo simulation for k = ',num2str(k(i))],'fontsize',16)
end
%% Task 2 & 3 & 4: Three nonlinear estimation approach and iterated EKF of optimization.
% Initialize the real state and observation.
clear
clc
Q = 10;
R = 1;
x0 = mvnrnd(0,1);
k = 100;
% Calculate the real state and measurement with noise.
xReal = spdfe(k,1,Q);
yMeasure = xReal.^2/20 + randn(R,k);

%% Particle filter.
N_particle = 500;
xEstimatePF = particleF(yMeasure,N_particle,Q,R);
figure
plot(xEstimatePF,'k','LineWidth',1.5)
hold on
plot(xReal,'r-.','LineWidth',1.5)
legend('Estimated state','Real state')
title('Particle filter estimation result','FontSize',16)

%% Grid-based filter
nGrid = 500;
[xEstimateGBF,xPosterPdf] = gridBF(yMeasure,nGrid,Q,R);
% Plot the estimation results.
figure
plot(xEstimateGBF,'k','LineWidth',1)
hold on
plot(xReal,'r--','LineWidth',1)
axis([0,100,-25,25])
xlabel('Discrete time k','FontSize',16)
ylabel('State','FontSize',16)
legend('Estimated state','Real state')
title('Grid-based filter estimation result','FontSize',16)
figure
[X,Y] = meshgrid(linspace(-25,25,nGrid),1:100);
mesh(X,Y,xPosterPdf)
xlabel('PDF of state','FontSize',16)
ylabel('Discrete time k','FontSize',16)
zlabel('Probability','FontSize',16)
title('Posterior PDF for k using grid-based filter','FontSize',16)
%% EKF and iterated EKF.

[xEstimateEKF] = extendKF(yMeasure,Q,R);
[xEstimateIEKF] = iterateEKF(yMeasure,Q,R);
figure
plot(xEstimateEKF,'k','LineWidth',1.5)
hold on
plot(xEstimateIEKF,'b--','LineWidth',1.5)
plot(xReal,'r-.','LineWidth',1.5)
legend('EKF estimation','Iterated EKF estimation','Real state')
%axis([0,100,-25,25])
xlabel('Discrete time k','FontSize',16)
ylabel('State','FontSize',16)
title('EKF and IEKF estimation result','FontSize',16)
%% Compare the RMSE
xEstimate = [xEstimatePF;xEstimateGBF;xEstimateEKF;xEstimateIEKF];
xDiff = xEstimate - repmat(xReal,[4,1]);
figure
imgDiff = plot(1:100,xDiff,'LineWidth',1.5);
imgDiff(2,1).LineStyle = '--';
imgDiff(3,1).LineStyle = ':';
imgDiff(3,1).Color = 'k';
imgDiff(4,1).LineStyle = '-.';
axis([1,100,-50,50])
leg = legend('Particle filter','Grid-based filter','EKF','Iterated EKF');
leg.FontSize = 14;
xlabel('Discrete time k','FontSize',16)
ylabel('x_{Estimate} - x_{Real}','FontSize',16)
title('Estimation performance comparision','FontSize',16)
% Calculate the RMS error for these filters.
RMSE = sum(xDiff.*xDiff./k,2).^0.5;
disp(RMSE)
