clear ;
clc;
nbus=14;
nbranch=20;
norm=0.001;  
B1=[        1            2        0.01938+0.05917i      0.0264*2i      1                       
            2            3        0.04699+0.19797i      0.0219*2i      1                
            2            4        0.05811+0.17632i      0.01870*2i     1               
            1            5        0.05403+0.22304i      0.02460*2i     1
            2            5        0.05695+0.17388i      0.01700*2i     1                
            3            4        0.06701+0.17103i      0.01730*2i     1     
            4            5        0.01335+0.04211i      0.00640*2i     1         
            7            8        0.17615i                 0           1      
            7            9        0.11001i                 0           1       
            9            10       0.03181+0.08450i         0           1         
            6            11       0.09498+0.19890i         0           1      
            6            12       0.12291+0.15581i         0           1 
            6            13       0.06615+0.13027i         0           1 
            9            14       0.12711+0.27038i         0           1 
            10           11       0.08205+0.19207i         0           1 
            12           13       0.22092+0.19988i         0           1 
            13           14       0.17093+0.34802i         0           1 
            4            7        0.20912i                 0          0.978 
            4            9        0.55618i                 0          0.969
            5            6        0.25202i                 0          0.932 ];       
B2=[      1       0              0                 1.0600    0      1
          2       0.4+0.4904i    0.2170+0.1270i    1.0450    0      3
          3       0.2744i        0.9420+0.1900i    1.0100    0      3
          4       0              0.4780-0.0390i    1         0      2
          5       0              0.0760+0.0160i    1         0      2
          6       0.2960i        0.1120+0.0750i    1.0700    0      3
          7       0              0                 1         0      2
          8       0.3092i        0                 1.0900    0      3
          9       0              0.2950+0.1660i    1         0.19   2
          10      0              0.0900+0.0580i    1         0      2
          11      0              0.0350+0.0180i    1         0      2
          12      0              0.0610+0.0160i    1         0      2
          13      0              0.1350+0.0580i    1         0      2
          14      0              0.1490+0.0500i    1         0      2     ];
Y=zeros(nbus,nbus);
V=zeros(nbus,1);
Vth=zeros(nbus,1);
S=zeros(nbus,1);
dP=zeros(nbus,1);
dQ=zeros(nbus,1);
dV=zeros(nbus,1);
dVth=zeros(nbus,1);
H=zeros(nbus-1,nbus-1);
N=zeros(nbus-1,nbus-1);
M=zeros(nbus-1,nbus-1);
L=zeros(nbus-1,nbus-1);
for i=1:nbranch
   p=B1(i,1);q=B1(i,2);  
   Y(p,q)=-1/(B1(i,3)*B1(i,5));
   Y(q,p)= Y(p,q); 
   Y(p,p)=Y(p,p)+1/(B1(i,3)*B1(i,5)^2)+B1(i,4)/2;
   Y(q,q)=Y(q,q)+1/B1(i,3)+B1(i,4)/2;
end
G=real(Y);
B=imag(Y);
for i=1:nbus
   V(i)=B2(i,4);
   Vth(i)=angle(V(i));
   S(i)=B2(i,2)-B2(i,3);
   B(i,i)=B(i,i)+B2(i,5);
   P=real(S);
   Q=imag(S);
end
CT=0;
while 1,
 tic;
 CT=CT+1;   
P1=zeros(nbus,1);
Q1=zeros(nbus,1);
for  i=1:nbus
      for j=1:nbus
       P1(i)=P1(i)+V(i)*V(j)*(G(i,j)*cos(Vth(i)-Vth(j))+B(i,j)*sin(Vth(i)-Vth(j)));
       Q1(i)=Q1(i)+V(i)*V(j)*(G(i,j)*sin(Vth(i)-Vth(j))-B(i,j)*cos(Vth(i)-Vth(j)));
      end
      dP(i)=P(i)-P1(i);
      dQ(i)=Q(i)-Q1(i);
end
  dP(1)=[];
  dQ(1)=[];
  for i=2:nbus 
      for j=2:nbus
          if i~=j
              H(i-1,j-1)=V(i)*V(j)*(G(i,j)*sin(Vth(i)-Vth(j))-B(i,j)*cos(Vth(i)-Vth(j)));
              M(i-1,j-1) =-V(i)*V(j)*(G(i,j)*cos(Vth(i)-Vth(j))+B(i,j)*sin(Vth(i)-Vth(j)));
              N(i-1,j-1)=V(i)*V(j)*(G(i,j)*cos(Vth(i)-Vth(j))+B(i,j)*sin(Vth(i)-Vth(j)));
              L(i-1,j-1) =V(i)*V(j)*(G(i,j)*sin(Vth(i)-Vth(j))-B(i,j)*cos(Vth(i)-Vth(j)));
          else
              H(i-1,i-1)=-(Q1(i)+B(i,i)*V(i)^2);
              M(i-1,i-1)=P1(i)-G(i,i)*V(i)^2;
              N(i-1,i-1)=P1(i)+G(i,i)*V(i)^2;
              L(i-1,i-1)=Q1(i)-B(i,i)*V(i)^2;
          end
      end
  end
  J=[H,N;M,L];
  r=0;
  for i=2:nbus
      if B2(i,6)==3
          J(nbus-1+i-1-r,:)=[];
          J(:,nbus-1+i-1-r)=[];
          dQ(i-1-r)=[];
          r=r+1;
      end
  end
  dv=J^-1*[dP;dQ];
  r=0;
  for i=2:nbus
          dVth(i)=dv(i-1);
      if B2(i,6)==3 
       r=r+1;
      else
          dV(i)=dv(nbus-1+i-1-r)*V(i);
      end
  end
 V=V+dV;
 Vth=Vth+dVth;
if max(abs(dP))<norm&&max(abs(dQ))<norm&&max(abs(dV))<norm&&max(abs(dVth))<norm
    break;
end
end
S=P1+Q1*1i;
S(1)=0;
 for j=1:nbus
     S(1)=S(1)+(V(1)*cos(Vth(1))+V(1)*sin(Vth(1)*1i))*conj(Y(1,j))*(V(j)*cos(Vth(j))-V(j)*sin(Vth(j)*1i));
 end

