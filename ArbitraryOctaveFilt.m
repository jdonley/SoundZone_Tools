function y = ArbitraryOctaveFilt(x, SPECT, FREQS, N, fs, octBandwidth)
%ARBITRARYOCTAVEFILT Filters a signal with any arbitrary spectrum smoothed with any fractional octave band average
% 
% Syntax:	[OUTPUTARGS] = ARBITRARYOCTAVEFILT(INPUTARGS) Explain usage here
% 
% Inputs: 
% 	input1 - Description
% 	input2 - Description
% 	input3 - Description
% 
% Outputs: 
% 	output1 - Description
% 	output2 - Description
% 
% Example: 
% 	Line 1 of example
% 	Line 2 of example
% 	Line 3 of example
% 
% See also: List related files here

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2016
% Date: 06 June 2016 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 6
    octBandwidth = 1/6;    
end

% Find nth-octave averages
[MAG,f]=Tools.octaveBandMean(SPECT,FREQS,octBandwidth);

% Force even length filter
if isempty(N), if mod(length(SPECT),2), N=length(SPECT)-1; else N=length(SPECT); end; end;
% Design arbitrary magnitude (linear-phase) filter
b = fir2(N,f/(fs/2),MAG);
% Apply filter
y = filter(b,1,x);


end