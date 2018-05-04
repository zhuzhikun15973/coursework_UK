clear
clc
close all
%% Initialize data.
D = 0:6;                                    % Demand x.
p = [0.04,0.08,0.28,0.4,0.16,0.02,0.02]';   % Probability p(x).

orderN   = 3;                               % Initialize order number.
reorderN = 1;                               % Initialize re-order stock.
nWeek    = 52;                              % Initialize time period.
N        = 500;                             % Initialize run length.
%% Generate nWeek*N RVs which follows above distribution using rejection method.
x = appleConDist(D,p,nWeek,N);
%% Simulation for my choice of (y,r) = (3,1). (Figure.2 in REPORT.)
cost = appleSim(orderN,reorderN,x);
figure(1)
hist(cost,20)
xlabel('Total cost within the 52-weeks period for y =3, r = 1','FontSize',16)
ylabel('Frequency, n','FontSize',16)
title('Simulation result of Task 2.','FontSize',16)
%% Simulation for 52 weeks for each possible order number and re-order stock pair (y,r).
nCost = zeros(length(D),length(D),N);
for i = D
    for j = D
        nCost(i+1,j+1,:) = appleSim(i,j,x);
    end
end

meanCost = mean(nCost,3);                                                   % Calculate the mean cost for each y-r pair.
varCost = var(nCost,0,3);                                                   % Calculate the variance for each y-r pair.
minMeanCost = min(meanCost(:));                                             % Get the minimum cost.
[optOrderRowN,optReorderColN] = find(meanCost == minMeanCost);              % Get the row and column number of the lowest cost.

optOrderN = D(optOrderRowN);                                                % Get the optimal order number and re-order stock
optReorderN = D(optReorderColN);
disp(['Optimized y-r pair: ',num2str(optOrderN),',',num2str(optReorderN)])
%% visualize the result of (y,r) pairs' mean cost. (Figure.3 in REPORT.)
[xAxis,yAxis] = meshgrid(0:6,0:6);
figure(2)
mesh(xAxis,yAxis,meanCost)                                                  % Mesh average cost of all pairs.
hold on

plot3(optReorderN,optOrderN,minMeanCost,'r.','MarkerSize',20)               % Plot the minimum cost point.
text(optReorderN-2,optOrderN-1,minMeanCost+300,['Optimal Order number: ',num2str(optOrderN),newline,...
    'Optimal Re-order number: ',num2str(optReorderN),newline,...
    'Average Cost: ',num2str(minMeanCost)],'FontSize',14)
xlabel('r','FontSize',16)
ylabel('y','FontSize',16)
zlabel('Mean cost','FontSize',16)
%% Plot the optimal cost.  (Figure.4 in REPORT.)
costOpt31 = appleSim(optOrderN,optReorderN,x);
figure(3)
hist(costOpt31,20)
xlabel('Total cost within the 52-weeks period for y =3, r = 1','FontSize',16)
ylabel('Frequency, n','FontSize',16)
title('Simulation for N = 500 times (20 bins)','FontSize',16)
meanOpt31 = mean(costOpt31);
varOpt31 = var(costOpt31);
%% Compare the distributions of all (y,r) pair. (Not shown in the REPORT).
figure(4)
%plot(x31,n31,'r',x32,n32,'k','LineWidth',2)
rankMin = sort(reshape(meanCost,1,[]));
for i = 1:7
    %meanRVs
for j = 1:7
    [~,~,conInterval,~] = normfit(squeeze(nCost(i,j,:)),0.001);
    t1 = conInterval(1):0.1:conInterval(2);
    %t1 = 400:0.1:2000;
    t2 = normpdf(t1,meanCost(i,j),sqrt(varCost(i,j)/N));
    if meanCost(i,j) == rankMin(1) || meanCost(i,j) == rankMin(2)
        plot(t1,t2,'k','LineWidth',2)
        plot(t1(floor(length(t1)/2)),max(t2),'r.','MarkerSize',10)               % Plot the minimum cost point.

    else
        plot(t1,t2)
    end
    hold on
end
end
hold off
title('Distributions of all (y,r) pair under confidence level 99.9%','FontSize',16)
text(1100,0.25,['The distribution with first and second',newline,...
    'minimum are plotted with thick line.',newline,...
    'Minimum Cost: ',num2str(rankMin(1)),newline,'2nd minimum Cost: ',num2str(rankMin(2))],'FontSize',14)
xlabel('cost','FontSize',16)
ylabel('Probability Density Function','FontSize',16)
%% Compare the Confidence interval between (3,1) and (3,2). (Figure.4 in REPORT.)
[mean31,stdVar31,conInterval31,~] = normfit(squeeze(nCost(4,2,:)),1-0.99999);
[mean32,stdVar32,conInterval32,~] = normfit(squeeze(nCost(4,3,:)),1-0.99999);
% Render the area inside the confidence interval of both (3,1) and (3,2).
t1 = conInterval31(1):0.1:conInterval31(2);
t2 = normpdf(t1,mean31,stdVar31/sqrt(N));
t2(1) = 0;
t2(end) = 0;
figure(5)
patch(t1,t2,'r')
hold on
t1 = conInterval32(1):0.1:conInterval32(2);
t2 = normpdf(t1,mean32,stdVar32/sqrt(N));
t2(1) = 0;
t2(end) = 0;
patch(t1,t2,'r')
% Plot the distribution of both (3,1) and (3,2).
x = 400:0.1:460;
y31 = normpdf(x,mean31,stdVar31/sqrt(N));
y32 = normpdf(x,mean32,stdVar32/sqrt(N));
plot(x,y31,'k',x,y32,'k--','LineWidth',2)
legend(['CI: [',num2str(conInterval31(1)),',',num2str(conInterval31(2)),']'],...
        ['CI: [',num2str(conInterval32(1)),',',num2str(conInterval32(2)),']'],'pdf at y=3, r=1','pdf at y=3, r=2')
xlabel('Cost. Left: (y=3,r=1), Right: (y=3,r=2)','FontSize',16);
ylabel('probability density function','FontSize',16);
hold off


