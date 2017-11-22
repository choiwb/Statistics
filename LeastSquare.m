xp = [1.9 0.8 2.2 0.2 -0.2 4.4 4.6 1.6 5.5 3.4];
yp = [0.7 -0.1 -0.2 -1.2 -0.1 3.4 0.0 0.8 3.7 2.0];

y = @(b) b(1)+xp*b(2);
ysum = @(b) sum((y(b)-yp).^2);
newb = fminsearch(ysum, [0 0]);
plot(xp, yp, 'o')
grid on, hold on
plot(xp, y(newb))
figure(2)
plot(xp, y(newb)-yp, 'o');grid on

% First need to sort a otherwise when we go to plot it, it will look like a mess!
[xp, sortOrder] = sort(xp, 'ascend');
yp = yp(sortOrder); % Need to sort b the same way.
% First compute the linear fit.
linearCoeffs = polyfit(xp, yp, 1);
Slope = linearCoeffs(2)
Intercept = linearCoeffs(1)
% Plot training data and fitted data.
subplot(2, 1, 1);
xpFitted = xp; % Evalutate the fit as the same x coordinates.
ypFitted = polyval(linearCoeffs, xpFitted);
plot(xp, yp, 'rd', 'MarkerSize', 10);
hold on;
plot(xpFitted, ypFitted, 'yp-', 'LineWidth', 2);
grid on;
xlabel('xp', 'FontSize', 20);
ylabel('yp', 'FontSize', 20);
% Plot residuals as lines from actual data to fitted line.
for k = 1 : length(xp)
	yActual = yp(k);
	yFit = ypFitted(k);
	x = xp(k);
	line([x, x], [yFit, yActual], 'Color', 'm');
end
% Do the same for a quadratic fit.
quadraticCoeffs = polyfit(xp, yp, 2);
% Plot training data and fitted data.
subplot(2, 1, 2);
xpFitted = xp; % Evalutate the fit as the same x coordinates.
ypFitted = polyval(quadraticCoeffs, xpFitted);
plot(xp, yp, 'rd', 'MarkerSize', 10);
hold on;
plot(xpFitted, ypFitted, 'yp-', 'LineWidth', 2);
grid on;
xlabel('xp', 'FontSize', 20);
ylabel('yp', 'FontSize', 20);
% Plot residuals as lines from actual data to fitted line.
for k = 1 : length(xp)
	yActual = yp(k);
	yFit = ypFitted(k);
	x = xp(k);
	line([x, x], [yFit, yActual], 'Color', 'm');
end