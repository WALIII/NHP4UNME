function out = NHP_Sessions2Days(bmi_files);

counter = 1;
for i = 1:size(bmi_files.active_file_names,1);
    
    if i ==1;
    compFile = str2num(bmi_files.active_file_names{i}(1:end-1))
    else
        curFile = str2num(bmi_files.active_file_names{i}(1:end-1));
        if curFile ==compFile
        else
            counter = counter+1;
        end
        compFile = curFile;
    end
    
         out(i) = counter;

end