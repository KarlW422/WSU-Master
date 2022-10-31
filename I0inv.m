function y = Iinv(z)
%function y = Iinv(z)
%input argument z must be a row or column vector, or a scalar  

y = zeros(1,length(z));
for k = 1:length(z)
  y(k) = abs(fzero('If',2,[],z(k)));
end;


