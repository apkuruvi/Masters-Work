a = 0:0.01:16
x = 0.5*cos(a);
y = 1*sin(a);
z = 0.5*cos(a) + 1*sin(a);
plot(a,x)
hold on                                             % allows us to graph more than one graph on same plot
plot(a,y)                                               
plot(a,z)
hold off
title('All Plots')
xlabel('Time')
ylabel('Amplitude')
legend('0.5cos(x)','sin(x)',' 0.5cos(a) + sin(a)') 
