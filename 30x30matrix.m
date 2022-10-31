for i=1:30
    for j=1:30
        if i~=j
            A[i,j]=unidrnd(2)-1;
        else
            A[1,j]=0;
        end
    end
end