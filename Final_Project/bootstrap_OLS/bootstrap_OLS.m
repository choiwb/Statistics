% OLS for constant
% Bootstrapping    model output, data
% 이방법을 사용해서 CI 를 구할수 있다. distribution을 알아냈으니 mean 과 standard deviation 을
% 알아냈으니 CI 를 구할 수 있다.

clc
clear all

t=0:1:149;                   % x 축 

theta=[17 0.6 0.1];          % theta0=[K r x0] K=17.5; r=0.7; x0=0.1;
trueparametervalue=[17.5 0.7 0.1];

p=3;
n=length(t);                 % 150개  
m=1000;                      % 1000번
options=optimset('TolX',1.0e-4,'MaxFunEvals',10000);   % iteration number

lb= [0 0 0];              % lower bound
ub= [inf inf inf];           % upper bound

% 첫번째 열 setting

y(1,:)=normlogistic(trueparametervalue,t);               % y 는 model
Y(1,:)=y(1,:)+(1/20)*randn(1,n);              % Y 는 생성된 data  논문 뒤에 noise = 0.05 로 주어짐
resd(1,:)=sqrt(n/(n-p)).*(Y(1,:)-y(1,:));   % resd 는 초기 residual 값
r(1,:)=randsample(resd(1,:),n,'true');      % r 은 random sampling 한 residual  
theta1(1,:)= lsqcurvefit(@normlogistic,theta,t,Y(1,:),lb,ub,options); % theta=[K r x0]

% plot(t,y(1,:))
% 2~1000 열 setting

for i=1:m
    y(i+1,:)=normlogistic(theta1(i,:),t);      % y 는 theta에 의존
    r(i+1,:)=randsample(resd(1,:),n,'true');      % residual 
    Y(i+1,:)= y(1,:) + r(i+1,:);             % Y= y + r
    theta1(i+1,:)= lsqcurvefit(@normlogistic,theta1(i,:),t,Y(i+1,:),lb,ub,options); % theta=[K r x0]  % 세타가 나옴
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


 