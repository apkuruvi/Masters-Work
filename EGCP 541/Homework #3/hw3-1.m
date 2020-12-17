N = 2^11;                                                                                % Signal length
% FFT 
nfft = 2.^nextpow2(N); % Next power of 2
 X = fft(x,nfft);                                                                        % signal x given to us in file

% Magnitude
 f = linspace(0,fs/2,N/2);                                                      % fs given to us in file as 1000
mag_fft = abs(X(1:N/2));

% Plot Magnitude 
figure(); 
plot(f,mag_fft); 

 title('FFT'); 
ylabel('Mag');                                                                % give names to axis and title of graph
xlabel('Frequency (Hz)');
 legend('FFT');
