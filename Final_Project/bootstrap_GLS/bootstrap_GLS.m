% GLS for non - constant
% Bootstrapping    model output, data
% 이방법을 사용해서 CI 를 구할수 있다. distribution을 알아냈으니 mean 과 standard deviation 을
% 알아냈으니 CI 를 구할 수 있다.

clc
clear all

t=0:1:149;                   % x 축 

theta=[17 0.6 0.1];          % theta0=[K r x0] K=17.5; r=0.7; x0=0.1;
trueparametervalue=[17.5 0.7 0.1];

n=length(t);                 % 150개  
m=1000;                      % 1000번
options=optimset('TolX',1.0e-4,'MaxFunEvals',10000);   % iteration number

lb= [0 0 0];              % lower bound
ub= [inf inf inf];           % upper bound

% 첫번째 열 setting

y(1,:)=normlogistic(trueparametervalue,t);               % y 는 model
Y(1,:)=y(1,:).*(1+(1/20)*randn(1,n));              % Y 는 생성된 data  논문 뒤에 noise = 0.05 로 주어짐
Weights(1,:) = 1./(y(1,:).^2);    % 초기 Weights는 y(1,:)의 -2승 

yerrsum = @(x) sum(Weights(1,:).*(Y(1,:)-normlogistic(x,t)).^2); % 초기 Weights를 곱함
theta1(1,:) = fminsearch(yerrsum,theta);

% plot(t,y(1,:))
% 2~1000 열 setting

for i=1:m
    y(i+1,:)=normlogistic(theta1(i,:),t);      % y 는 theta에 의존
    Y(i+1,:)= y(1,:).*(1+(1/20)*randn(1,n));        % Y= y * (1 + r);   r은 residual
    Weights(i+1,:) = 1./(y(i+1,:).^2);   % Weights 를 1000번 반복문 실행하여 조정.
    yerrsum = @(x) sum(Weights(i+1,:).*(Y(i+1,:)-normlogistic(x,t)).^2); % 반복문 실행할 때 마다 생긴 Weights를 곱함 
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