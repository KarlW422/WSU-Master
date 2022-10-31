n=10;
A=[];
for i=1:n
    for j=1:i
        if i~=j
            A(i,j)=unidrnd(2)-1;
            A(j,i)=A(i,j);
        else
            A(i,j)=0;
        end
    end
end
B=[];
for i=1:n
    for j=1:i
        if i~=j
            B(i,j)=unidrnd(10);
            B(j,i)=B(i,j);
        else
            B(i,j)=0;
        end
    end
end
C=A.*B