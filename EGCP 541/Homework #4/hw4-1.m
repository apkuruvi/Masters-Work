samplesig = [1,zeros(1,9)];            % used for mass sampling
extendsig = [samplesig, samplesig, samplesig, samplesig, samplesig, samplesig, samplesig, samplesig, samplesig, samplesig,samplesig];
time = 0:109;                                         % enough time to show whole signal
sig1 = cos(time.*2*pi*1/11)+ 3;      % assuming some input signal, + 3 so we don't have to graph zeros                 
fullsig = sig1.*extendsig;                % complete sampled signal
figure(1)                                 
hold on 
stem(time, fullsig)                       % plot individual points with stem
plot(time, sig1)                          % plot the graph
axis([0,109,1.9,4.2])        % set x axis 0- 109, and y to 1.9 to 4.2 which cuts off unwanted zero plots
xlabel('Time')
ylabel('Amplitude')
title('Time domain plot with impulse samples')
hold off
alisig2 = cos(time.*2*pi*1/110)+ 3;       % signal after sampled
figure(2)                                                      %Graph on new window
hold on
plot(time, sig1)                                       %plot the graph
stem(time, fullsig)                                 %plot individual points
plot(time, alisig2, 'b:')                           %plot the new graph in blue
axis([0,109,1.9,4.2])       % set x axis 0- 109, and y to 1.9 to 4.2 which cuts off unwanted zero plots
xlabel('Time')
ylabel('Amplitude') 
title('Time domain plot with alias')
hold off
