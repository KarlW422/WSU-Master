clear all
close all

f=0.01:0.01:10;
A=1;
Tb=1;
S_BPSK=A^2*Tb*(sin(pi*f*Tb)./(pi*f*Tb)).^2;

plot(f,10*log10(S_BPSK/max(S_BPSK)),'r','linewidth',1)

axis([0 10 -50 0])
xlabel('Frequency(Hz)')
ylabel('Spectral Power Level(dB)')
title('Power Spectral Density')
hold on
S_QPSK=2*A^2*2*Tb*(sin(2*pi*f*Tb)./(2*pi*f*Tb)).^2;
plot(f,10*log10(S_QPSK/max(S_QPSK)),'g','linewidth',1)
hold on
S_OQPSK=2*A^2*2*Tb*(sin(2*pi*f*Tb)./(2*pi*f*Tb)).^2;
plot(f,10*log10(S_OQPSK/max(S_OQPSK)),'b','linewidth',1)
hold on
S_MSK=(32*A^2*Tb^2/(pi^2))*(cos(2*pi*f*Tb)./(1-16*f.^2*Tb^2)).^2;
S_MSK(25)=2;
M_MSK=max(S_MSK);
Y_MSK=10*log10(S_MSK/M_MSK);
plot(f,Y_MSK,'m','linewidth',1)
hold on
legend('BPSK','QPSK','OQPSK','MSK')
