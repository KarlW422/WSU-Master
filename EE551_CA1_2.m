clear all
close all

X=32768;
Fs=16;
NFFT=1024;
A=1;
Tb=1;

bits_in=round(rand(1,X));
y=mskmod(bits_in,Fs);

[spectra,f] = pwelch(y,hanning(NFFT),[],NFFT,Fs);
plot(f, 10*log10(spectra/max(spectra)),'r','linewidth',1);

axis([0 8 -100 0])
hold on
[spectra1,f] = pwelch(y,boxcar(NFFT),[],NFFT,Fs);
plot(f, 10*log10(spectra1/max(spectra1)),'b','linewidth',1);
hold on
S_MSK=(16*A^2*Tb^2/(pi^2))*(cos(2*pi*f*Tb)./(1-16*f.^2*Tb^2)).^2;
S_MSK(17)=1;
M_MSK=max(S_MSK);
Y_MSK=10*log10(S_MSK/M_MSK);
plot(f, 10*log10(S_MSK/M_MSK),'g','linewidth',1);
legend('E-MSK(hanning)','E-MSK(boxcar)','T-MSK')
xlabel('Frequency(Hz)')
ylabel('Spectral Power Level(dB)')
title('Power Spectral Density')
grid on