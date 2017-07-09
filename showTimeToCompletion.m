function [ num_curr_char, history_ ] = showTimeToCompletion( percent_complete, num_prev_char, history_ )
%SHOWTIMETOCOMPLETION Prints the time to completion and expected finish of a looped simulation based on linear extrapolation.
% 
% Syntax:	[ num_curr_char ] = showTimeToCompletion( percent_complete, num_prev_char )
%   Note that before using this function in a loop the in-built MATLAB
%   function tic should be called.
% 
% Inputs: 
% 	percent_complete - A decimal number between 0 and 1 representing the
% 	percentage completion.
% 	num_prev_char - Number of previous characters printed to the screen
% 	(Usually ok to begin with 0 and then reuse num_curr_char)
% 
% Outputs: 
% 	num_curr_char - Number of characters printed to the screen. Usually
% 	feed this number back into this function on the next iteration or
% 	increment appropriately if other characters have been printed between
% 	function calls.
%
% Example: 
%       fprintf('\t Completion: ');
%       n=0; tic;
%       len=1e2;
%       for i = 1:len
%           pause(1);
%           n = showTimeToCompletion( i/len, n);
%       end
% 
% See also: tic, toc

% Author: Jacob Donley
% University of Wollongong
% Email: jrd089@uowmail.edu.au
% Copyright: Jacob Donley 2017
% Date: 25 August 2015 
% Revision: 0.1
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
tElapsed = toc;
ratio = percent_complete;

if nargin >=3
    history_ = [history_; tElapsed, ratio];
    if size(history_,1) > 10 && ratio < 0.5
        t=0:0.001:1;
        tTot__ = abs(interp1( ...
            smooth(history_(:,2),size(history_,1),'rloess'), ...
            smooth(history_(:,1),size(history_,1),'rloess'), ...
            t, 'pchirp', 'extrap'));
        
        I2 = find(t < ratio*2,1,'last');
        I1 = find(t > ratio,1,'first');
        tTot_ = abs(interp1( ...
            t([I1,I2]), ...
            tTot__([I1,I2]), ...
            t, 'linear', 'extrap'));
            
        tRem = tTot_(end) - tElapsed;
    elseif size(history_,1) > 10
        t=0:0.001:1;
        tTot_ = abs(interp1( ...
            smooth(history_(:,2),size(history_,1),'rloess'), ...
            smooth(history_(:,1),size(history_,1),'rloess'), ...
            t, 'linear', 'extrap'));
        
        tRem = tTot_(end) - tElapsed;
    else
        tRem = (1-ratio) / ratio * tElapsed;
    end
else
    tRem = (1-ratio) / ratio * tElapsed;
end

tTot = tElapsed + tRem;

% Begin plot prediction
if nargin >=3
    t_vec = (history_(:,1)-history_(end,1))/86400 + datenum(datetime);
    plot(history_(:,2), t_vec,'ok');hold on;
    if size(history_,1) > 10 && ratio < 0.5
        plot(t,(tTot__-history_(end,1))/86400 + datenum(datetime) ,'g');
    end
    if size(history_,1) > 10
        tvec = (tTot_-history_(end,1))/86400 + datenum(datetime);
        plot(t,tvec,'r');
        ylim([min(tvec) max(tvec)]);
    end
    hold off;
    title('Progress','FontSize',14);
    XTick = linspace(0,1.0,11); XTickLabel = linspace(0,100,11);
    set(gca, 'XTick', XTick); set(gca, 'XTickLabel', XTickLabel);
    xlabel('Completion (%)');
    Y = get(gca,'YLim');
       YTick = linspace(Y(1),Y(2),10);
       set(gca, 'YTick', YTick);
    datetick('y', 'dd-mmm HH:MM:SS PM');
    ylabel('Date / Time');
    grid on; xlim([0 1.0]); drawnow;
end
% End plot prediction

fprintf(repmat('\b',1,num_prev_char));
num_curr_char=fprintf( ...
    ['%.2f%%\n' ...
    '      Remaining: %s\n' ...
    '          Total: %s\n' ...
    'Expected Finish: %s\n'], ...
    ratio * 100, ...
    datestr(seconds(tRem),'hh:MM:SS'), ... floor(tRem/60), ...    rem(tRem,60), ...
    datestr(seconds(tTot),'hh:MM:SS'), ... floor(tTot/60), ...    rem(tTot,60), ...
    [strrep(datestr(datetime + seconds(tRem),'hh:MM:SS AM'),' ',''),'  ', ...
     datestr(datetime + seconds(tRem),'dd-mmm-yyyy')]);

end

