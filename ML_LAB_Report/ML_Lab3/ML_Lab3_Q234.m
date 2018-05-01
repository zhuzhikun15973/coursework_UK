% Draw N samples of Bivariate Gaussian D same with Q1 on top of contours.
clear
N = 200;
m1 = [0 2]';
m2 = [1.7 2.5]';
C1 = [2,1;1,2]';
C2 = C1;

X1 = mvnrnd(m1,C1,N);
X2 = mvnrnd(m2,C2,N);
plot(X1(:,1),X1(:,2),'bx',X2(:,1),X2(:,2),'ro');
grid on 

% Q3
% Compute and plot Fisher Linear Discriminant direction using
% means and covariance matrices of the problem.

wF = inv(C1 + C2)*(m1 - m2);
step = 0.1;
xx = -6:step:6;
yy = xx*wF(2)/wF(1);
plot(xx,yy,'r','LineWidth',2);
