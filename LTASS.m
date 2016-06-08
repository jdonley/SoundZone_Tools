function [ spect, frqs ] = LTASS( folder, nfft )
%LTASS Computes the Long-Term Average Speech Spectrum from a folder of speech files
% 
% Syntax:	[ spect, frqs ] = LTASS( folder, nfft )
% 
% Inputs: 
% 	folder - The path to the folder containing the speech files
%   nfft - The number of FFT points used to compute the LTASS
% 
% Outputs: 
% 	spect - The LTASS spectrum
% 	frqs - The frequency vector for the spectrum
 
% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2016
% Date: 8 July 2016
% Revision: 0.2
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Just incase this function tries to call getAllFiles within a class folder we
% should create a function handle for getAllFiles regardless
inf = dbstack('-completenames');
funcName = 'getAllFiles';
funcPath = inf.file;
classDirs = getClassDirs(funcPath);
getAllFiles_ = str2func([classDirs funcName]);

%% Start LTASS
if nargin < 2
    nfft = 1024;
end
files = getAllFiles_(folder);
speech=[];
F = length(files);
for file = 1:F
    try
        [audioSig,fs] = audioread(files{file});
        audioSig = audioSig ./ rms(audioSig(:));
    catch err
        if strcmp(err.identifier, 'MATLAB:audiovideo:audioread:FileTypeNotSupported')
            continue; % Skip unsupported files
        end
    end
    speech = [speech; audioSig];
end

win_=rectwin(nfft);
ovlap = 0;

[spect,frqs]=pwelch(speech,win_,nfft*ovlap,nfft,fs,'power');

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