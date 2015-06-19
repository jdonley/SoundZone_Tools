function [ res, cmd_out ] = Dropbox( action )
%DROPBOX Function to start and kill dropbox

switch action
    case 'start'
        [res, cmd_out] = dos('start "" "%APPDATA%\Dropbox\bin\Dropbox.exe" & exit');
        disp('... Started Dropbox');
        
    case 'kill'
        [res, cmd_out] = dos('taskkill /F /IM Dropbox.exe');
        if res==0, disp('Terminated Dropbox ...'); end
        
    otherwise
        error('Dropbox action not supported...');
end

end

