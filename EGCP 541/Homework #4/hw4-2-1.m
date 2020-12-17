function y = zero_pad(x,K)
% function y = zero_pad(x,K)
% 
% Inputs: x - Input Signal
%         K - Padding
% 
% Output: y - Zero Padded Signal
% 


%get length of signal, # of zeros
L = length(x);               
L1 = L - 1;
K1 = K - 1;

% first part prints out zero padded graph

hold on
% create array to hold  new zero padded signal, K * signal length
signal = zeros(1,K*length(x));         
counter = 1;
t= 0;
for z = 0:1:L1               % index starts at 1, not 0
  y = x(z + 1);                      
  signal(counter) = y;
   %set color and size for marker, set color for stem, graph value
  stem(t,y,'-o', 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor',[0 0 1], 'Color',[0 0 1]) 
  for j = 1:1:K1                    % iterate K - 1 times ex: K = 4 = pad with 3 zeroes                                                                      
  y = 0;                                  % pad zero, add into signal
  counter = counter + 1;
  signal(counter) = y;
  t = t + 1;
    %set color and size for marker, set color for stem, graph zero
  stem(t,y,'-o', 'MarkerSize',10,'MarkerEdgeColor','blue','MarkerFaceColor',[0 0 1], 'Color',[0 0 1])
  end
   t = t + 1;
   counter = counter + 1;
end
hold off

title('All Points with no Zero-Padding')
xlabel('i,Kt/Ts')
ylabel('y[i*Ts/K]')
y = signal;

end

