clear
close
N0=1;
Eb_N0_dB = [0 1 2 3 4 5 6 7 8 9 10];
Eb=10.^(Eb_N0_dB/10);
EbN0=Eb/N0;
Pb_B=[2.5845e-01 2.2043e-01 1.8128e-01 1.4252e-01 1.0598e-01 7.3544e-02 4.6812e-02 2.6747e-02 1.3350e-02 5.6242e-03 1.9150e-03];
z=exp(double(2.*Eb));
t=I0inv(z);
Q1=[1 1 1 1 1 1 1 1 1 1 1];
Tr=(2*N0*(Eb).^0.5).^(-1).*t;
for c1=1:11
Q1(c1)=marcumq(2*sqrt(Eb(c1)),Tr(c1)/sqrt(N0),1);
end
P1=[1 1 1 1 1 1 1 1 1 1 1]-Q1;
P1dB=log10(P1);
hold on
semilogy(Eb_N0_dB,P1dB,'b');
xlabel('EbN0(dB)')
ylabel('P(dB)')
P0=[1 1 1 1 1 1 1 1 1 1 1];
for c0=1:11
    P0(c0)=exp(-(Tr(c0))^2/(2*N0));
end
P0dB=log10(P0);
semilogy(Eb_N0_dB,P0dB,'y');
Pav=(P1+P0)/2;
PavdB=log10(Pav);
Pb_BdB=log10(Pb_B);
semilogy(Eb_N0_dB,PavdB,'r');
semilogy(Eb_N0_dB,Pb_BdB,'k');
legend('P(H1|H0)','P(H0|H1)','P(OOK)','P(Blahut)');
P_difference=Pb_B-Pav;
