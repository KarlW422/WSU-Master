clear all
close all

Ns=100;
no_of_bits=2^15;
window_size=2^10;

% MSK MODULATION
bits_in=round(rand(1,no_of_bits));
differential_bits=abs(diff([0, bits_in]));
bipolar_symbols=differential_bits*2-1;
symbols_oversampled=(ones(Ns,1))*bipolar_symbols;
symbols_oversampled=(1/Ns)*(symbols_oversampled(:))';
cumulative_phase=(pi/2)*cumsum(symbols_oversampled);
tx_signal1=exp(1i*cumulative_phase);

% MSK PSD
Rb=1/Ns;
[spectra,freq] = pwelch(tx_signal1,window_size);
spectra=[flipud(spectra);spectra];
freq=[-flipud(freq);freq];
plot(freq/Rb, 10*log10(spectra/max(spectra)),'g','linewidth',4);

axis([-30 30 -50 0])
legend('MSK')
xlabel('Normailzed Frequency(Hz/bits/sec)')
ylabel('Spectral Power Level(dB)')
title('Power Spectral Density')
grid on