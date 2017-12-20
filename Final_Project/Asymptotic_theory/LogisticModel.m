%LogisticModel
 
function LM=LogisticModel(t,x0,theta)
% thetavalue(1) == k
% thetavalue(2) == r
 
LM = (theta(2)*x0*(1-x0/theta(1)));
