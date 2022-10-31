function y = If(x,z)
%Computes y = I0(x) - z 
%Called by I0inv.m to compute inverse I0 function I0^-1(x)
y = besseli(0,x) - z;
 
