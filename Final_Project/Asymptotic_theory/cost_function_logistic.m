%Costfunction

function cost = cost_function_logistic(theta,t,x0)
 
global data
 
[time,x] = ode45(@LogisticModel,t,x0,[],theta);
d_model = x(:,1);
cost = data - d_model; 
