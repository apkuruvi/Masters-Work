function ans(x,K)
% Inputs: x - Input Signal
%         K - Padding
% 
% Output: Plots input signal and zero padded signal on the same figure, plots magnitude response for 
% input and zero padded signal on same figure
% 

% first part prints out normal graph with no padding
L = length(x);
L1 = L - 1;
t = 0;
K1 = K - 1;
subplot(2,1,1);
hold on
for z = 0:1:L1
  y = x(z + 1);                       % index starts at 1, not 0
  t = z;
   %set color and size for marker, set color for stem
  stem(t,y,'-o', 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor',[0 0 1], 'Color',[0 0 1]) 
end
hold off
title('All Points with no Zero-Padding')
xlabel('n,t/Ts')
ylabel('x[nTs]')

% second part prints out zero padded graph
subplot(2,1,2);
hold on
t= 0;
signal = zeros(1,K*length(x));
counter = 1;
for z = 0:1:L1
  y = x(z + 1);                       % index starts at 1, not 0
  signal(counter) = y;
  %set color and size for marker, set color for stem, graph signal part
  stem(t,y,'-o', 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor',[0 0 1], 'Color',[0 0 1])  
  for j = 1:1:K1                      % iterate K - 1 times ex: K = 4 = pad with 3 zeroes
  y = 0;           
  counter = counter + 1;
  signal(counter) = y;
  t = t + 1;
  %set color and size for marker, set color for stem, graph zeros
  stem(t,y,'-o', 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor',[0 0 1], 'Color',[0 0 1])  
  end
   t = t + 1;
   counter = counter + 1;
end
hold off

title('All Points with no Zero-Padding')
xlabel('i,Kt/Ts')
ylabel('y[i*Ts/K]')
y = signal;                               % y now has zero padded signal



figure();   % used to make a different graphing window
N = length(x);                                   % Signal length
fs = 1000;  % assuming some frequency, using same fs as previous assignment
% FFT 
nfft = 2.^nextpow2(N); % Next power of 2
 X = fft(x,nfft);                       % signal x given to us from hw

% Magnitude
 f = linspace(0,fs/2,N/2);      % fs being assumed as 1000
mag_fft = abs(X(1:N/2));

% Plot Magnitude 
subplot(2,1,1);             % used to make one graph on top
plot(f,mag_fft); 

 title('FFT'); 
ylabel('Mag');                   % give names to axis and title of graph
xlabel('Frequency (Hz)');
 legend('FFT');


N = length(y);                  % Signal length of zero padded signal
% FFT 
nfft = 2.^nextpow2(N); % Next power of 2
 X = fft(y,nfft);                         % signal y calculated above

% Magnitude
 f = linspace(0,fs/2,N/2);          % fs assumed as 1000
mag_fft = abs(X(1:N/2));

% Plot Magnitude 
subplot(2,1,2);     % graph on bottom
plot(f,mag_fft); 

 title('FFT'); 
ylabel('Mag');                   % give names to axis and title of graph
xlabel('Frequency (Hz)');
 legend('FFT');


end
