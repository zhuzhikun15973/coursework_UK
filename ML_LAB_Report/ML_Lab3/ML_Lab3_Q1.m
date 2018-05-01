% Contour two Gaussian D with means m1 m2 
% and same covariance C = C1 = C2.
numGrid = 50;
m1 = [0 2]';
m2 = [1.7 2.5]';
C1 = [2,1;1,2]';
C2 = C1;
xRange = linspace(-6,6,numGrid);
yRange = linspace(-6,6,numGrid);
P1 = zeros(numGrid,numGrid);
P2 = P1;
for i = 1:numGrid
    for j = 1:numGrid
        
        x = [yRange(j) xRange(i)]';
        P1(i,j) = mvnpdf(x',m1',C1);
        P2(i,j) = mvnpdf(x',m2',C2);
        
    end
end

Pmax = max(max([P1 P2]));
figure(1), clf,
contour(xRange,yRange,P1,[0.1*Pmax 0.5*Pmax 0.8*Pmax],'LineWidth',2);
hold on
plot(m1(1),m1(2),'b*','LineWidth',4);
contour(xRange,yRange,P2,[0.1*Pmax 0.5*Pmax 0.8*Pmax],'LineWidth',2);
plot(m2(1),m2(2),'b*','LineWidth',4);
hold off