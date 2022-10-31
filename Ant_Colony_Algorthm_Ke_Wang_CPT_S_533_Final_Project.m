clear all;
close all;
clc;
n=10;%numbers of vertices
ants=30;%numbers of ants
Alpha=1;%constants for ACA
Beta=5;%constants for ACA
Rho=0.1;%constants for ACA
ConterM=400;%Maximum iteration time
Q=1;%constants for ACA
A=[1,5,12,24,26,12,8,23,10,36];%x coordinate for each vertex
B=[1,2,17,17,9,23,13,9,27,4];%y coordinate for each vertex
C=[A;B];
C=C';%coordinate for each vertex
plot(A,B,'r*') %ploting for each vertex
D=zeros(n,n);%distance of adjacency matrix
for i=1:n
    for j=1:n
        if i==j
            D(i,j)=eps;
        else
            D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)+C(j,2))^2)^0.5;
            D(j,i)=D(i,j);
        end
    end
end
Wt=1./D;
PHE=ones(n,n);%matrix for pheromone
Path=zeros(ants,n);%path memory 
Conter=1;%iteration counter
PB=zeros(ConterM,n);%best path in each iteration
LB=inf.*ones(ConterM,1);%length of PB
LA=zeros(ConterM,1);%average length of each iteration
while Conter<=ConterM
    R=[];
    k=(ceil(ants/n));
    for i=1:k;
        R=[R,randperm(n)];
    end
    Path(:,1)=(R(1,1:ants))';%put ants to different vertices randomly
    for j=2:n
        for i=1:ants;
            v=Path(i,1:(j-1));%visited vertices
            nv=zeros(1,(n-j+1));%un-visited vertices
            P=nv;
            vc=1;
            for l=1:n
                if length(find(v==l))==0
                    nv(vc)=l;
                    vc=vc+1;%visited city number plus 1
                end
            end
            for l=1:length(nv)
                P(l)=(PHE(v(end),nv(l))^Alpha)*(Wt(v(end),nv(l))^Beta);%probability of next step
            end
            P=P/(sum(P));
            Pcum=cumsum(P);
            Choose=find(Pcum>=rand);%choosing the next step
            tv=nv(Choose(1));
            Path(i,j)=tv;
        end
    end
    if Conter>=2
        Path(1,:)=PB(Conter-1,:);
    end
%finding the best path in each iteration
    L=zeros(ants,1);
    for i=1:ants
        S=Path(i,:);
        for j=1:(n-1)
            L(i)=L(i)+D(S(j),S(j+1));
        end
        L(i)=L(i)+D(S(1),S(n));%total distance in this path
    end
    LB(Conter)=min(L);%find the shortest path
    ps=find(L==LB(Conter));
    PB(Conter,:)=Path(ps(1),:);%best path in this iteration
    LA(Conter)=mean(L);%average distance in this iteration
    Conter=Conter+1;%next iteration

%pheromone renew
    B_PHE=zeros(n,n);
    for i=1:ants 
        for j=1:(n-1)
            B_PHE(Path(i,j),Path(i,j+1))=B_PHE(Path(i,j),Path(i,j+1))+Q/L(i);
        end
            B_PHE(Path(i,n),Path(i,1))=B_PHE(Path(i,n),Path(i,1))+Q/L(i);
    end
    PHE=(1-Rho).*PHE+B_PHE;%pheromone matrix for next iteration
    Path=zeros(ants,n);%clean the path matrix
end
Ps=find(LB==min(LB));%find best path
SP=PB(Ps(1),:);%find best path
SL=LB(Ps(1));%length of best path
%plotting
subplot(1,2,1);
N=length(S);
scatter(C(:,1),C(:,2));
hold on
plot([C(S(1),1),C(S(N),1)],[C(S(1),2),C(S(N),2)],'g')
hold on
for ii=2:N
    plot([C(S(ii-1),1),C(S(ii),1)],[C(S(ii-1),2),C(S(ii),2)],'g')
    hold on
end
title('Best Path')
subplot(1,2,2);
plot(LB);
hold on
plot(LA,'r');
title('average distance and shortest distance')

