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

xp2 = [1.9 0.8 1.1 0.1 -0.1 4.4 4.6 1.6 5.5 3.4];
yp2 = [0.7 -0.1 -0.2 -1.2 -0.1 3.4 0.0 0.8 3.7 2.0];

y2 = @(b) b(1)+xp2*b(2) + xp2.^2*b(3);
y2sum = @(b) sum((y2(b) - yp2).^2);
newb2 = fminsearch(y2sum,[0 0 0]);
stxp = sort(xp);
sty2 = @(b) b(1)+stxp*b(2) + stxp.^2*b(3);
figure(3)
plot(stxp,sty2(newb2),'--r',xp2,yp2,'o');
grid on
figure(4)
plot(xp,y2(newb2)-yp2,'o')
grid on
