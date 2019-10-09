function [DIR_INDR, out] = NHP4unme_acrossDays(paco_struct, DN_index,IND_index,cell_id,DIR_INDR)
% load in data across days, for individual cells, then get raster data to
% save

% run in folder Ganguly_2009/data
% Load:

% unique_ids.mat
% paco_struct.mat

% User Inputs:

dateRange = 6:34;

[bmi_files] =   def_expt_19day();
% Get file names:
filenames = bmi_files.active_file_names;

% Convert session to day:
Ses2Day = NHP_Sessions2Days(bmi_files);

% convert struct to cell for easier indexing:
paco_cell = struct2cell(paco_struct);
counter =1;

% To Reconstruct IDs
%[DN_index IND_index] = NHP_Index(direct_id,indirect_far_id)

% ii for each cell
for ii = cell_id;
    intendedID = ii;
% go across ' 'blocks' days:
for i = dateRange%1:36%:size(bmi_files.active_file_names,1)

    if DIR_INDR == 0;
cell_ID = DN_index{ii}(i);
    elseif DIR_INDR ==1
cell_ID = IND_index{ii}(i);
    else % if you already sorted it before this function 
cell_ID = IND_index{ii}(i);% cell_id;
%disp('running with pre-sorted data.. aka you know what you want already');
    end
 

if isnan(cell_ID);
    continue
end
    

% load in block data
day = paco_cell{i};
load([filenames{i},'.mat'],'trial_data');


out{counter} = NHP4unme_trialTimes(trial_data,day,cell_ID,0);
out{counter}.session = i;
out{counter}.day = Ses2Day(i);

counter = counter+1;
% concat across the day

end

disp('combineing days');
% concat all days:
for target = 1:7;
    
    first =0;
    for ix = 1:counter-1
        if first ==0;
            try
                Xdat{target} = out{ix}.xPoints2{target};
                Ydat{target} = out{ix}.yPoints2{target};
                first = 1;
                if isempty(Ydat{target})
                    Xdat{target} = 1;
                    Ydat{target} = 1;
                end
            catch
                Xdat{target} = 1;
                Ydat{target} = 1;
                first = 1;
            end
        else
            try
                boundry{target}(ix-1) = max(Ydat{target});
                tempX = out{ix}.xPoints2{target};
                tempY = out{ix}.yPoints2{target}+max(Ydat{target});
                Xdat{target} = cat(1,Xdat{target},tempX);
                Ydat{target} = cat(1,Ydat{target},tempY);
            catch
                disp('wtf');
            end
        end
    end
end

clf;


for tgp = 1:target;
    figure(tgp);
    hold on;
    plot(Xdat{tgp},Ydat{tgp})
    if exist('boundry')% if this exists ( more than one day)
    for iix = 1:size(boundry{tgp},2)
        line([-15,20],[boundry{tgp}(iix),boundry{tgp}(iix)],'Color','r')
    end
    end
    ax = gca;
    ax.YDir = 'reverse'
    pause(1);
    title(['Target ',num2str(tgp), ' across days for cell: ',num2str(intendedID)]); 
end




%% plot waveforms:


clear Gplt
% Across days ( all days
 figure();
 hold on;
for iv = 1:counter-1;
    try
    Gplt =  cat(2,out{1, iv}.WaveSort{:}); Gplt = cat(1,Gplt{:});
    plot(mean(Gplt,1)-500*iv);
    A(:,iv) = mean(Gplt,1);
    clear Gplt
    catch
        disp('error plotting');
    end
    
end
title('Waveforms across days');

figure(); 
imagesc(A');
title(' Waveform across days');
colorbar();



end


    
    
    