% GLS for non - constant
% Bootstrapping    model output, data
% �̹���� ����ؼ� CI �� ���Ҽ� �ִ�. distribution�� �˾Ƴ����� mean �� standard deviation ��
% �˾Ƴ����� CI �� ���� �� �ִ�.

clc
clear all

t=0:1:149;                   % x �� 

theta=[17 0.6 0.1];          % theta0=[K r x0] K=17.5; r=0.7; x0=0.1;
trueparametervalue=[17.5 0.7 0.1];

n=length(t);                 % 150��  
m=1000;                      % 1000��
options=optimset('TolX',1.0e-4,'MaxFunEvals',10000);   % iteration number

lb= [0 0 0];              % lower bound
ub= [inf inf inf];           % upper bound

% ù��° �� setting

y(1,:)=normlogistic(trueparametervalue,t);               % y �� model
Y(1,:)=y(1,:).*(1+(1/20)*randn(1,n));              % Y �� ������ data  �� �ڿ� noise = 0.05 �� �־���
Weights(1,:) = 1./(y(1,:).^2);    % �ʱ� Weights�� y(1,:)�� -2�� 

yerrsum = @(x) sum(Weights(1,:).*(Y(1,:)-normlogistic(x,t)).^2); % �ʱ� Weights�� ����
theta1(1,:) = fminsearch(yerrsum,theta);

% plot(t,y(1,:))
% 2~1000 �� setting

for i=1:m
    y(i+1,:)=normlogistic(theta1(i,:),t);      % y �� theta�� ����
    Y(i+1,:)= y(1,:).*(1+(1/20)*randn(1,n));        % Y= y * (1 + r);   r�� residual
    Weights(i+1,:) = 1./(y(i+1,:).^2);   % Weights �� 1000�� �ݺ��� �����Ͽ� ����.
    yerrsum = @(x) sum(Weights(i+1,:).*(Y(i+1,:)-normlogistic(x,t)).^2); % �ݺ��� ������ �� ���� ���� Weights�� ���� 
    theta1(i+1,:) = fminsearch(yerrsum,theta1(i,:));
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