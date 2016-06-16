function [ res ] = pesq_mex_vec( reference_sig, degraded_sig, Fs )
%PESQ_MEX_VEC Accepts vectors for a mex compiled version of the objective Perceptual Evaluation of Speech Quality measure
% 
% Syntax:	[ res ] = pesq_mex_vec( reference_sig, degraded_sig, Fs )
% 
% Inputs: 
% 	reference_sig - Reference (clean, talker, sender) speech signal
% 	degraded_sig - Degraded (noisy, listener, receiver) speech signal
% 	Fs - Sampling Frequency
% 
% Outputs: 
% 	res - MOS-LQO result for wideband
% 
% See also: pesq2mos.m

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2016
% Date: 16 June 2016
% Revision: 0.2
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

max_val = max(abs([reference_sig(:); degraded_sig(:)]));

tmpref = [tempname '.wav'];
tmpdeg = [tempname '.wav'];

audiowrite( tmpref, reference_sig / max_val, Fs);
audiowrite( tmpdeg, degraded_sig / max_val, Fs);

res = Tools.pesq_mex(['+' num2str(Fs)], ...
                    '+wb', ...
                    tmpref, ...
                    tmpdeg);
                
delete( tmpref, tmpdeg );
end

