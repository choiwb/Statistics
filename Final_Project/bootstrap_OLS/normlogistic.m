function y=normlogistic(theta,t)

y=theta(1)./(1+((theta(1)./theta(3))-1)*exp(-theta(2)*t));
