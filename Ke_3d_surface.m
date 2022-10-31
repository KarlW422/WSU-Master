[x,y] = meshgrid(-3:0.2:3,-3:0.2:3);
z=-y+x-x.^3;
surf(x,y,z);
xlabel('x')
ylabel('y')
zlabel('z')