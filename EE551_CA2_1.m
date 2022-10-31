clear
close
Eb_N0_dB = [0 1 2 3 4 5 6 7 8 9 10];
Eb=10.^(Eb_N0_dB/10);
z=1;
z=exp(double(2.*Eb));
t=I0inv(z);
Tr=(2*(Eb).^0.5).^(-1).*t;
plot(Eb_N0_dB,Tr);
xlabel('EbN0(dB)')
ylabel('Tr')
