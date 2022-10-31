clear all
close all

f=0.01:0.01:10;
A=1;
Tb=1;
S_BPSK=A^2*Tb*(sin(pi*f*Tb)./(pi*f*Tb)).^2;

plot(f,10*log10(S_BPSK/max(S_BPSK)),'r','linewidth',1)

axis([0 10 -100 10])
xlabel('Frequency(Hz)')
ylabel('Spectral Power Level(dB)')
title('Power Spectral Density')
hold on
S_QPSK=2*A^2*2*Tb*(sin(2*pi*f*Tb)./(2*pi*f*Tb)).^2;
plot(f,10*log10(S_QPSK/max(S_BPSK)),'g','linewidth',1)
hold on
S_OQPSK=2*A^2*2*Tb*(sin(2*pi*f*Tb)./(2*pi*f*Tb)).^2;
plot(f,10*log10(S_OQPSK/max(S_BPSK)),'b','linewidth',1)
hold on
S_MSK=(16*A^2*Tb^2/(pi^2))*(cos(2*pi*f*Tb)./(1-16*f.^2*Tb^2)).^2;
M_MSK=max(S_BPSK);
Y_MSK=10*log10(S_MSK/M_MSK);
plot(f,Y_MSK,'m','linewidth',1)
hold on
legend('BPSK','QPSK(same as OQPSK)','OQPSK','MSK')
