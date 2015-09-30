function [ res, cmd_out ] = MiKTeX_FNDB_Refresh( )
%MiKTeX_FNDB_Refresh Function to refresh the File Name DataBase in MiKTeX

        [res, cmd_out] = system('initexmf --admin --update-fndb');
        disp('Refreshed MiKTeX FNDB');

end

