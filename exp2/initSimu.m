% This is the initialisation of the simulation.
Rb = 1; % data rate 1 bit/s
gain = 64; % spreading gain 64
fc = 128; % carrier frequency 128Hz

M = mSeq([0,5,7,8,9,13,15]);    % Generate the m-sequence.

mt = [1 0 1 0 1 1 1 0 1 1 0 0 1 0 0];   % An arbitrary signal m(t).
mt_in = kron(mt, ones(1,gain)); % Interpolating the signal before multiplying by the pn code.
Pt = M(1:(gain*length(mt)));    % Trucating the m-sequence.
sA = mt.*Pt;
% Point A

sB = bpsk(sA, fc);
% Point B

% sC = awgn(sA, 50, 'measured');    % Adding noise.
sC = sB;                            % Ideally, no noise.

sD = 
