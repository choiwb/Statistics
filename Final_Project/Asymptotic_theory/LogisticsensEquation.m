%Sensitivity Equation

function dx=LogisticsensEquation(t,x0,theta)
% theta(1) == k
% theta(2) == r
 
dx = [(theta(2)*x0(1)*(1-x0(1)/theta(1)));
        theta(2)*(1-2*x0(1)/theta(1))*x0(2) + x0(1)*(1-x0(1)/theta(1));
        theta(2)*(1-2*x0(1)/theta(1))*x0(3) + theta(2)*x0(1)^2/theta(1)^2];
