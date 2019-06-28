function [bmi_files] =   def_expt_19day()
%OUTPUT:
%bmi_files = struct('num_days', num_days, 'max_num_files', max_num_files, 'active_files', active_files, 'active_days', active_days, 'file_ids', file_ids);

%files for analysis
%071608 - 080608
%num days: (31-16)+1+(6-1)+1 = 22 days
num_days        = 19;
max_num_files   = 6;

active_files    = zeros(num_days, max_num_files);
active_days     = cell(num_days,1);

active_files(1,:)   = [0 1 1 1 1 0];
active_files(2,:)   = [0 0 1 1 1 1];
active_files(3,:)   = [0 1 1 1 0 0];
active_files(4,:)   = [0 1 1 1 0 0];
active_files(5,:)   = [0 0 1 0 1 0];
active_files(6,:)   = [0 1 1 1 0 0];
active_files(7,:)   = [1 1 0 0 0 0];
active_files(8,:)   = [0 1 1 0 0 0];
active_files(9,:)   = [0 1 0 0 0 0];
active_files(10,:)  = [1 0 0 0 0 0];
active_files(11,:)  = [0 1 0 0 0 0];
active_files(12,:)  = [0 1 0 0 0 0];
active_files(13,:)  = [1 0 0 0 0 0];
active_files(14,:)  = [1 0 0 0 0 0];
active_files(15,:)  = [0 0 1 0 0 0];
active_files(16,:)  = [1 0 0 0 0 0];
active_files(17,:)  = [1 1 0 0 0 0];
active_files(18,:)  = [1 0 0 0 0 0];
active_files(19,:)  = [0 0 1 1 0 0];

active_days{1}      = '071508';
active_days{2}      = '071608';
active_days{3}      = '071708';
active_days{4}      = '071808';
active_days{5}      = '071908';
active_days{6}      = '072008';
active_days{7}      = '072108';
active_days{8}      = '072208';
active_days{9}      = '072308';
active_days{10}     = '072408';
active_days{11}     = '072508';
active_days{12}     = '072608';
active_days{13}     = '072708';
active_days{14}     = '072808';
active_days{15}     = '072908';
active_days{16}     = '073008';
active_days{17}     = '073108';
active_days{18}     = '080108';
active_days{19}     = '080208';

file_ids{1}         = 'a';
file_ids{2}         = 'b';
file_ids{3}         = 'c';
file_ids{4}         = 'd';
file_ids{5}         = 'e';
file_ids{6}         = 'f';

num_active_files    = sum(sum(active_files));
active_file_names = cell(num_active_files,1);
idx = 1;
%List the active_files:
for i=1:num_days
    for j = 1:max_num_files
        if(active_files(i,j))
            file_name   = [active_days{i} file_ids{j}];
            disp(file_name);
            active_file_names{idx}  = file_name;
            idx = idx + 1;
        end
    end
end

%ASSIGN:
%bmi_files = struct('num_days', num_days, 'max_num_files', max_num_files, 'active_files', active_files, 'active_days', active_days, 'file_ids', file_ids);

bmi_files   = struct(...
    'num_days', num_days, ...
    'max_num_files', max_num_files, ...
    'active_files', active_files, ...
    'active_file_names', {active_file_names}, ...
    'num_active_files', num_active_files, ...
    'active_days', {active_days}, ...
    'file_ids', {file_ids});

%071508
% bcde
%
% 071608
% cdef
% 
% 071708
% bcd
% 
% 071808
% bcd
% 
% 071908
% ce
% 
% 072008
% bcd
% 
% 072108
% ab
% 
% 072208
% bc
% 
% 072308
% b
% 
% 072408
% a
% 
% 072508
% b
% 
% 072608
% b
% 
% 072708
% a
% 
% 072808
% a
% 
% 072908
% c
% 
% 073008
% a
% 
% 073108
% ab
% 
% 080108
% a
% 
% 080208
% cd
