i=0.9;
f=@(x,y)exp(-(2*(1-i^2))^(-1)*(x.^2+y.^2-2*i*x.*y))/(2*pi*sqrt(1-i^2));
y_l = @(x) -sqrt(1-x.^2);
y_u = @(x) sqrt(1-x.^2);
I = integral2(f,-1,1,y_l,y_u)
 
I = 2.0000