%main_Logistic.m
 
close all
clear;
clc;
 
global data 
 
k0 = 17.5;  %initial k
r0 = 0.7;  %initial r
x0 = 0.1;  %initial x
theta=[k0,r0];
 
% Generates "simulted" data.
n = 100;
 
t0 = 0;
tf = 25; 
t = 0: tf/n : tf;   
 
nl = 0.05;  %level of noise
 
[t,x] = ode45(@LogisticModel,t,x0,[],theta);
d=x(:,1);
noise = nl*randn(n+1,1); 
data = d + noise; 
 
%Generates the optimized values
theta0 = [0.01, 0.01]; 
 
[thetaHat,resnorm,residual] = lsqnonlin(@cost_function_logistic,theta0,[],[],[],t,x0);
thetaHat
 
% Generates the covariance matrix using the sensitivity equations
y0 = [x0;0;0]  %initial conditions
[ts senmatrix] = ode45(@LogisticsensEquation,t,y0,[],thetaHat);
X=[senmatrix(:,2), senmatrix(:,3)];
cov =resnorm*inv(X'*X)/(n-2)
sigma = sqrt(diag(cov))
 
%Residual analysis
[t1, modelfit] = ode45(@LogisticModel,t,x0,[],thetaHat);
figure
subplot(211)
plot(t,data,'o',t,d,'r*');ylabel('Y');xlabel('Time');
hold on
 
subplot(212)
plot(modelfit(:,1),residual,'*');
ylabel('Residual');
xlabel('Model')
