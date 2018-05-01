% Compute and plot Fisher Linear Discriminant direction using
% means and covariance matrices of the problem.
m1 = [0 2]';
m2 = [1.7 2.5]';
C1 = [2,1;1,2]';
C2 = C1;

wF = inv(C1 + C2)*(m1 - m2);
step = 0.1;
xx = -6:step:6;
yy = xx*wF(2)/wF(1);
plot(xx,yy,'r','LineWidth',2);
