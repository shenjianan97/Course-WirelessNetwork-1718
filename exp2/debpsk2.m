function [ output ] = debpsk2( input, f0, P )
%	Demodulates the modulated signal.
%   ///This file is based on debpsk.m in exp1.///
%   ///Additional parameter P is appended.///
%   ///P denotes the pseudonoise sequence.///

%   f0 denotes the center frequency of the BPSK modulation.
%   Note: both input and output are row vectors.

fs = 65536;         % Keep the sampling rate consistent with that in modulation.
n = fs/f0;          % Every 1 bit corresponds to n samples.
P = kron(P, ones(1,n));     % Interpolate P so that it matches the dimension of s.

s = input .* cos(2*pi*f0*(1:length(input))/fs);  % Multiply by the carrier wave.
s = s .* P;                                      % Multiply by the PN code.

wp = 3/fs;
ws = 300/fs;
[N, Wp] = ellipord(wp, ws, 1, 40);
[b, a] = ellip(N, 1, 40, Wp);                   % Deisgn a low-pass filter.
s_filtered = filter(b,a,s);

figure,
subplot(2,1,1), plot(s); title('s');
subplot(2,1,2), plot(s_filtered); title('Point D');
% --- Point D ---

% Sample and decide.
s_reshaped = reshape(s_filtered, n, []);        % So that every column vector represents one bit.
s_sampled = s_reshaped(floor(n/2), :);          % Take the median value of every colunm vector as one sample.
s_decided = (s_sampled < 0);                    % Deicide: if positive, the bit is 0; if negative, the bit is 1.

output = s_decided;

end