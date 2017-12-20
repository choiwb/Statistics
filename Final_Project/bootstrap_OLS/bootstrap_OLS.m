% OLS for constant
% Bootstrapping    model output, data
% �̹���� ����ؼ� CI �� ���Ҽ� �ִ�. distribution�� �˾Ƴ����� mean �� standard deviation ��
% �˾Ƴ����� CI �� ���� �� �ִ�.

clc
clear all

t=0:1:149;                   % x �� 

theta=[17 0.6 0.1];          % theta0=[K r x0] K=17.5; r=0.7; x0=0.1;
trueparametervalue=[17.5 0.7 0.1];

p=3;
n=length(t);                 % 150��  
m=1000;                      % 1000��
options=optimset('TolX',1.0e-4,'MaxFunEvals',10000);   % iteration number

lb= [0 0 0];              % lower bound
ub= [inf inf inf];           % upper bound

% ù��° �� setting

y(1,:)=normlogistic(trueparametervalue,t);               % y �� model
Y(1,:)=y(1,:)+(1/20)*randn(1,n);              % Y �� ������ data  �� �ڿ� noise = 0.05 �� �־���
resd(1,:)=sqrt(n/(n-p)).*(Y(1,:)-y(1,:));   % resd �� �ʱ� residual ��
r(1,:)=randsample(resd(1,:),n,'true');      % r �� random sampling �� residual  
theta1(1,:)= lsqcurvefit(@normlogistic,theta,t,Y(1,:),lb,ub,options); % theta=[K r x0]

% plot(t,y(1,:))
% 2~1000 �� setting

for i=1:m
    y(i+1,:)=normlogistic(theta1(i,:),t);      % y �� theta�� ����
    r(i+1,:)=randsample(resd(1,:),n,'true');      % residual 
    Y(i+1,:)= y(1,:) + r(i+1,:);             % Y= y + r
    theta1(i+1,:)= lsqcurvefit(@normlogistic,theta1(i,:),t,Y(i+1,:),lb,ub,options); % theta=[K r x0]  % ��Ÿ�� ����
end

figure(1)   %K
hist(theta1(:,1))
title('distribution of K')
figure(2)   %r
hist(theta1(:,2))
title('distribution of r')
figure(3)   %x0
hist(theta1(:,3))
title('distribution of x_0')
figure(4)
plot(t,Y,'*',t,y)


 