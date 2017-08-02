function [ res ] = pesq_mex_vec( reference_sig, degraded_sig, Fs )
% Accepts vectors for a mex compiled version of the objective Perceptual Evaluation of Speech Quality measure
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
% Copyright: Jacob Donley 2017
% Date: 16 June 2016
% Revision: 0.2
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Just incase this function tries to call within a class folder we should 
% create a function handle for this function to use instead
infun = dbstack('-completenames');
funcName = 'pesq_mex';
funcPath = infun.file;
classDirs = getClassDirs(funcPath);
pesq_mex_ = str2func([classDirs funcName]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

max_val = max(abs([reference_sig(:); degraded_sig(:)]));

tmpref = [tempname '.wav'];
tmpdeg = [tempname '.wav'];

audiowrite( tmpref, reference_sig / max_val, Fs);
audiowrite( tmpdeg, degraded_sig / max_val, Fs);

res = pesq_mex_(['+' num2str(Fs)], ...
                    '+wb', ...
                    tmpref, ...
                    tmpdeg);
                
delete( tmpref, tmpdeg );
end

function classDirs = getClassDirs(FullPath)
    classDirs = '';
    classes = strfind(FullPath,'+');
    for c = 1:length(classes)
        clas = FullPath(classes(c):end);
        stp = strfind(clas,filesep);
       classDirs = [classDirs  clas(2:stp(1)-1) '.'];
    end
end