% EM algorithm (Expectation & Maximization)  
% 관측되지 않는 잠재변수에 의존하는
% 확률 모델에서 maximum likelihood 나 maximum a posterior 을 갖는 매개변수를 찾는 반복 알고리즘

clc
clear all
close all

data=[-0.39 0.12 0.94 1.67 1.76 2.44 3.72 4.28 4.92 5.53,...
        0.06 0.48 1.01 1.68 1.80 3.25 4.12 4.60 5.28 6.22];
% data=[1 2 3 4 5 6 7 8 9 10 11 12];
% data=[72 197 : 70 204 : 73 208 : 68 null() : 65 null() : null() 170]; 
    
    % 초기 추측
    temp=randperm(length(data));
    pie(1)=0.5;
    mu1(1)=data(temp(1)); % height 초기 평균
    mu2(1)=data(temp(2)); % weight 초기 평균
    var1(1)=var(data); % height 초기 분산
    var2(1)=var(data); % weight 초기 분산

    for i = 1:50 % 최대 50회 연산
        
    % E - step : 매개변수의 추정 값으로 log likelihood 의 기대 값 계산
    Qq1=gauss_dist(data,mu1(i),var1(i));
    Qq2=gauss_dist(data,mu2(i),var2(i));
    log_likelihood(i)=sum(log(((1-pie(i))*Qq1) + (pie(i)*Qq2)));

    % responsibility : posterior distribution
    responsibilities(i,:)=(pie(i)*Qq2)./(((1-pie(i))*Qq1)+(pie(i)*Qq2));
    
    % M - step : 기대 값을 최대화 하는 변수 값 계산. 이 때, 변수 값은 다음 E - step 의 추정 값으로 쓰임
    mu1(i+1)=sum((1-responsibilities(i,:)).*data)/sum(1-responsibilities(i,:));
    mu2(i+1)=sum((responsibilities(i,:)).*data)/sum(responsibilities(i,:));
    
    var1(i+1)=sum((1-responsibilities(i,:)).*((data-mu1(i)).^2))/sum(1-responsibilities(i,:));
    var2(i+1)=sum((responsibilities(i,:)).*((data-mu2(i)).^2))/sum(responsibilities(i,:));
    
    pie(i+1)=sum(responsibilities(i,:))/length(data);
    
    end
    
    figure
    plot(log_likelihood)
    xlabel('Iteration');
    ylabel('Observed Data Log-likelihood');
    grid minor
    
    disp(log_likelihood)