function [ output ] = dealaw( input, nor )
%	Decode the demodulated signal.
%   nor denotes the normalisation scale in A-law companding.

octave = reshape(input, 8, []);     % Put every 8 digit as a column vector.
decoded = bin2dec(strcat(num2str(octave)'))';   % Convert every column (binary) to decimal numbers.
decoded = decoded/128*nor;
expanded = compand(decoded, 87.6, nor, 'a/expander');    % Reverse the A-law convertion.
output = decoded;

end

