% EM algorithm (Expectation & Maximization)  
% �������� �ʴ� ���纯���� �����ϴ�
% Ȯ�� �𵨿��� maximum likelihood �� maximum a posterior �� ���� �Ű������� ã�� �ݺ� �˰���

clc
clear all
close all

data=[-0.39 0.12 0.94 1.67 1.76 2.44 3.72 4.28 4.92 5.53,...
        0.06 0.48 1.01 1.68 1.80 3.25 4.12 4.60 5.28 6.22];
% data=[1 2 3 4 5 6 7 8 9 10 11 12];
% data=[72 197 : 70 204 : 73 208 : 68 null() : 65 null() : null() 170]; 
    
    % �ʱ� ����
    temp=randperm(length(data));
    pie(1)=0.5;
    mu1(1)=data(temp(1)); % height �ʱ� ���
    mu2(1)=data(temp(2)); % weight �ʱ� ���
    var1(1)=var(data); % height �ʱ� �л�
    var2(1)=var(data); % weight �ʱ� �л�

    for i = 1:50 % �ִ� 50ȸ ����
        
    % E - step : �Ű������� ���� ������ log likelihood �� ��� �� ���
    Qq1=gauss_dist(data,mu1(i),var1(i));
    Qq2=gauss_dist(data,mu2(i),var2(i));
    log_likelihood(i)=sum(log(((1-pie(i))*Qq1) + (pie(i)*Qq2)));

    % responsibility : posterior distribution
    responsibilities(i,:)=(pie(i)*Qq2)./(((1-pie(i))*Qq1)+(pie(i)*Qq2));
    
    % M - step : ��� ���� �ִ�ȭ �ϴ� ���� �� ���. �� ��, ���� ���� ���� E - step �� ���� ������ ����
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