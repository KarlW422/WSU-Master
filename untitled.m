t=0:10^-11:10^-8;
a=[1,1,0,0,1,1,0,0,1,0];
x=cos(2*pi*10^8*t).*sin(2*pi*(10^8+10^(-8)/4)*t);
y=-cos(2*pi*10^8*t).*sin(2*pi*(10^8+10^(-8)/4)*t);
tt=floor(t*10^8);
for c=1:1:10^3+1
    if a(tt(c)+1)==1
        s(c)=x(c);
    else
        s(c)=y(c);
    end
end
plot(t,s)