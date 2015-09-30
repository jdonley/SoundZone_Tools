function [ h ] = ImpResp( original, degraded, fs )
%IMPRESP Summary of this function goes here
% 
% Syntax:	[OUTPUTARGS] = IMPRESP(INPUTARGS) Explain usage here
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
% Copyright: Jacob Donley 2015
% Date: 30 September 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


x = original;
y = degraded;

N = length(original); %Number of samples
T = N*fs; %Length of signal in seconds



% [b,a]=butter(1,1/2,'high');
% y_ = filter(b,a/2,y);


Ly=size(x,1)+size(y,1)-1;  % 
Ly2=pow2(nextpow2(Ly));    % Find smallest power of 2 that is > Ly
    
X=fft(x, Ly2);             % Fast Fourier transform
Y=fft(y, Ly2);	           % Fast Fourier transform


FS=16000;
f1 = 10;
f2 = 7900;
T = 3;
%%% number of samples / frequency bins
N = real(round(T*FS));

%%% make sure start frequency fits in the first fft bin
f1 = ceil( max(f1, FS/(2*N)) );
%%% Create band pass magnitude to start and stop at desired frequencies
[B1 A1] = butter(2,f1/(FS/2),'high' );  %%% HP at f1
[B2 A2] = butter(2,f2/(FS/2));          %%% LP at f2

 %%% start with the true inverse of the sweep fft
%%% this includes the band-pass filtering, whos inverse could go to
%%% infinity!!!
invirfft = 1./X;
%%% so we need to re-apply the band pass here to get rid of that
[H1 W1] = freqz(B1,A1,length(X),FS,'whole');
[H2 W2] = freqz(B2,A2,length(X),FS,'whole');

%%% apply band pass filter to inverse magnitude
invirfftmag  = abs(invirfft).*abs(H1).*abs(H2);

%%% get inverse phase
invirfftphase = angle(invirfft);

%%% re-synthesis inverse fft in polar form
F2 = invirfftmag.*exp(sqrt(-1)*invirfftphase);
Y2_ = Y.*F2;

F = 1 ./ (abs(X).^2);
Y_=Y.*F;        	           % 

y=real(ifft(Y2_, Ly2));      % Inverse fast Fourier transform
y=y(1:1:Ly,:);               % Take just the first N elements


% t_ = 1:320;
% y(t_) = y(t_) .* linspace(0,1,length(t_))';
% 
% t_ = (size(x)-16000):size(x)-1;
% y(t_) = y(t_) .* linspace(1,0,length(t_))';
% y(size(x):end)=0;

% X = fft(x);
% Y = fft(y); 
% freq = (0:(length(y)/2 - 1)) * 16000/length(y); 
% 
% H =  1./(freq.^(1/1)+1);
% H = 1 ./ (abs(X(1:end/2)').^2+1);
% H = [H, zeros(1, length(y) - length(H))]';
% 
% Y_ = Y .* H;
% y = real(ifft(Y_) *2 * pi);

% X = fft( x );
% Y = fft( y );
% 
% Y_ = Y ./ (abs(X).^2);
% 
% y = ifft(Y_);

h = Tools.fconv(x,y);





% H = fft(h);
% C = conj(H) ./ ( conj(H) .* H + e);


end

% cnoise - generate colored noise with power spectrum approximately 1/f^c
% function arguments:
% nsamp = number of output samples
% color = spectrum exponent c 
% sr = samplerate (use nsamp if unknown)
% q = normalization constant to avoid divisions by zero (q=1 seems to work fine) 

% function y = cnoise (nsamp, color, sr, q = 1)
% 
% X = fft(y); 
% freq = length(x) * (0:(length(x)/2 - 1)) / length(x); 
% 
% H = q ./ (freq.^(color/2) + q);
% H = [H, zeros(1, length(x) - length(H))];
% 
% Y = X .* H;
% y = real(ifft(Y) * 2 * pi);
% end