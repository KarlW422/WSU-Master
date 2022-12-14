echo on
T=1;
M=2;
Es=T/2;
fc=6/T;
N=100;
dT=T/(N-1);
t=0:dT:T;
Fs=1000;
u0=sqrt(2*Es/T)*cos(2*pi*fc*t);
u1=sqrt(2*Es/T)*cos(2*pi*fc*t+2*pi/M);
subplot(2,1,1);
plot(t,u0);
title('BPSK Constant Envelope Signal Waveforms');
xlabel('time,t(s)-->');
ylabel('u0(t)-->');
subplot(2,1,2);
plot(t,u1);
xlabel('time,t(s)-->');
ylabel('u1(t)-->');
figure(2);
h = spectrum.welch;
Hpsd= psd(h,u0,'Fs',Fs);
plot(Hpsd);
title('POWER SPECTRAL DENSITY USING WELCH');
xlabel('frequency,f(hz)-->');
ylabel('u0(f) (db/hz)-->');
figure(3);
y=psd(u0);
plot(y);
title('POWER SPECTRAL DENSITY');
xlabel('frequency,f(hz)-->');
ylabel('u0(f) (watts/hz)-->');