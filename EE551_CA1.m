clear all
close all
X=32768;
Fs=16;
NFFT=1024;

bits_in=round(rand(1,X));
differential_bits=abs(diff([0, bits_in]));
bipolar_symbols=differential_bits*2-1;
symbols_oversampled=(ones(Fs,1))*bipolar_symbols;
symbols_oversampled=(symbols_oversampled(:))'/Fs;
cumulative_phase=(pi/2)*cumsum(symbols_oversampled);
tx_signal1=exp(1i*cumulative_phase);

Rb=1/Fs;
[spectra,freq] = pwelch(tx_signal1,NFFT);
spectra=[flipud(spectra);spectra];
freq=[-flipud(freq);freq];
plot(freq/Rb, 10*log10(spectra/max(spectra)),'r','linewidth',1);

axis([-20 20 -50 0])
legend('MSK')
xlabel('Normailzed Frequency(Hz/bits/sec)')
ylabel('Spectral Power Level(dB)')
title('Power Spectral Density')
grid on