function [TargetData]  = NHP_formatSpikes(neuronsOfInterest);


Save_Dat =0;


num_cells = size(neuronsOfInterest,2);  % number of cells
num_targets = size(neuronsOfInterest{1}{1}.timestamps,2);


counter = 1;
curr_cell = 1;
% Seperate by target first

for ixi = 1:num_targets % targets
    
    
for ix = 1:num_cells;  % cells
    out = neuronsOfInterest{ix};
    curr_neuron = ix;
    % Concat cells here
    for iix = 1: size(out,2); %days
        try
            num_trials = size(out{1, iix}.timestamps{1, ixi},2); % number of trials
        catch
            
            disp('pp');
        end
        

        for i = 1:num_trials; % for all trials
            try
            num_ts = size(out{1, iix}.timestamps{1, ixi}{i},2); % number of timestamps
            catch
            end
            if iix ==1 && ix ==1;
                curr_trial = i;
            end
            
            for ii = 1:num_ts % for all timestamps
              %  try
                neurons(counter) = curr_neuron; % each 'neuron' will be a target here.
                trials(counter) = curr_trial;
                times(counter) = out{1, iix}.timestamps{1, ixi}{i}(ii);
                counter = counter+1;
                water_on(curr_trial) = out{1, iix}.ends{ixi}(i);
                trial_go(curr_trial) = out{1, iix}.starts{ixi}(i);
                %catch
                %end
            end
            curr_trial = curr_trial+1;
        end  
    end
    curr_trial = 1;
end

%% Going to go to a new target, so package the data here:

% cut out the bounds
offset = 10;
hit = 10+offset;
times = times+offset; % the pad... 
y = find(times<(hit-8));
neurons(y) = [];
trials(y) = [];
times(y) = [];
clear y
y = find(times>(hit+15));
neurons(y) = [];
trials(y) = [];
times(y) = [];

metadata.water_on = water_on;
metadata.trial_go = trial_go;

TargetData(ixi).neurons = neurons;
TargetData(ixi).trials = trials;
TargetData(ixi).times = times;
TargetData(ixi).metadata = metadata;

% Clear workspace for the next loop:
clear y neurons trials times metadata


end


