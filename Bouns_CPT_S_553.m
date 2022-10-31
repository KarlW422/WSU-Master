max=100000;
x=1;
xp=0;
u=2;
for i=1:max
    x=x*i;
    while x>=2;
        x=x/2;
        xp=xp+1;
    end
    y=log2(x)+xp;
    z=1-log2(x);
    if z<=u
        u=z;
        t=i;
        c=2/x;
        k=xp;
    else
    end
end
k=k+1;
t
k
c