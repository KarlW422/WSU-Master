clear all
DB=10;
EN=10^(DB/10);
x1=@(t)[exp(-(EN*6*(sin(pi/4))^2)./((3+sqrt(3)).*(sin(t+(pi/4))).^2))];
y1=integral(x1,0,5*pi/12);
z1=y1/(pi*2);
x2=@(t)[exp(-(EN*4*(sin(pi/3))^2)./((3+sqrt(3)).*(sin(t+(pi/3))).^2))];
y2=integral(x2,0,7*pi/12);
z2=y2/(pi*2);
x3=@(t)[exp(-(EN*(24+12*sqrt(3))*(sin(5*pi/6))^2)./((3+sqrt(3)).*(sin(t+(5*pi/6))).^2))];
y3=integral(x3,0,pi/6);
z3=y3/(pi*2);
z4=(4*z1+8*z2+4*z3)/8;