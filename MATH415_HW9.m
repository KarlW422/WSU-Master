clear all
close all
figure(1)
hold on 
for xx=-5:0.5:5
    for yy=-5:0.5:5
    [t,x]=ode45(@dxdt1,[0 5],[xx;yy]);
    plot(x(:,1),x(:,2))
    end
end
axis([-5 5 -5 5])
xlabel('x')
ylabel('y')