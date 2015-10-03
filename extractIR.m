function [irLin, irNonLin] = extractIR(sweep_response, invsweepfft)
% EXTRACTIR Extract impulse response from swept-sine response.
%   [irLin, irNonLin] = extractIR(sweep_response, invsweepfft) 
%   Extracts the impulse response from the swept-sine response.  Use
%   synthSweep.m first to create the stimulus; then pass it through the
%   device under test; finally, take the response and process it with the
%   inverse swept-sine to produce the linear impulse response and
%   non-linear simplified Volterra diagonals.  The location of each
%   non-linear order can be calculated with the sweepRate - this will be
%   implemented as a future revision.
%   
%   Developed at Oygo Sound LLC
%
%   Equations from Muller and Massarani, "Transfer Function Measurement
%   with Sweeps."

if(size(sweep_response,1) > 1)
    sweep_response = sweep_response';
end

N = length(invsweepfft);
sweepfft = fft(sweep_response,N);

%%% convolve sweep with inverse sweep (freq domain multiply)

ir = real(ifft(invsweepfft.*sweepfft));

ir = circshift(ir', length(ir)/2); 

irLin = ir(end/2+1:end);
irNonLin = ir(1:end/2);
