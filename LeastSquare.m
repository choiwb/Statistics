xp = [1.9 0.8 2.2 0.2 -0.2 4.4 4.6 1.6 5.5 3.4];
yp = [0.7 -0.1 -0.2 -1.2 -0.1 3.4 0.0 0.8 3.7 2.0];

y = @(b) b(1)+xp*b(2);
ysum = @(b) sum((y(b)-yp).^2);
newb = fminsearch(ysum, [0 0]);

figure(1)
plot(xp, yp, 'o')
grid on, hold on
plot(xp, y(newb))

figure(2)
plot(xp, y(newb)-yp, 'o')
grid on, hold off
disp('newb')
disp(newb)

y2 = @(b) b(1)+xp*b(2) + xp.^2*b(3);
y2sum = @(b) sum((y2(b) - yp).^2);
newb2 = fminsearch(y2sum,[0 0 0]);
stxp = sort(xp);
sty2 = @(b) b(1)+stxp*b(2) + stxp.^2*b(3);

figure(3)
plot(stxp,sty2(newb2),'--r',xp,yp,'o');
grid on , hold off

figure(4)
plot(xp,y2(newb2)-yp,'o')
grid on, hold off
disp('newb2')
disp(newb2)

x1 = [1.9 0.8 1.1 0.1 -0.1 4.4 4.6 1.6 5.5 3.4];
x2 = [66 62 64 61 63 70 68 62 68 66];
yp2 = [0.7 -1.0 -0.2 -1.2 -0.1 3.4 0.0 0.8 3.7 2.0];

plot3(x1, x2, yp2, '.')
grid on, hold on
x11 = linspace(0.1 , 5.5);
x22 = linspace(61, 70);

for i = 1:100
    for j = 1:100
        y_hat(i,j) = -11.4527 + 0.4503*x11(i) + 0.1725*x22(j);
    end
end

mesh(x11 , x22, y_hat)
grid on, hold off

y_hat2 = @(b) b(1)+x1*b(2) + x2.^2*b(3);
y3sum = @(b) sum((y_hat2(b) - yp2).^2);
newb3 = fminsearch(y3sum, [0 0 0]);

stxp2 = sort(x1);
stxp3 = sort(x2);
sty3 = @(b) b(1)+stxp2*b(2) + stxp3.^2*b(3);

figure(5)
plot3(stxp2, stxp3, sty3(newb3),'--r',x1,x2, yp2,'o');
grid on , hold off

figure(6)
plot3(x1, x2, y_hat2(newb3)-yp2,'o')
grid on , hold off
disp('newb3')
disp(newb3)