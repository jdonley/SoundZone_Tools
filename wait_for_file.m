function wait_for_file( file_string )
fid = fopen(file_string,'r');
while fid==-1
    fid = fopen(file_string,'r');
end
fseek(fid,0,'eof');
char_pos(1) = -1;
char_pos(2) = ftell(fid);
pause(0.5);
while char_pos(1) ~= char_pos(2)
    char_pos(1) = char_pos(2);
    fseek(fid,0,'eof');
    char_pos(2) = ftell(fid);
    pause(0.5);
end
fclose(fid);
end

