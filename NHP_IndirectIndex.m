function IDnear = NHP_IndirectIndex(day,cell_id)
% get the true ID of each cell based on a convoluted indexing scheme...

% type = 1 direct
% type = 2 indirect on same channel
% type = 3 indirect on different channel

counter = 1;

for i = 1:size(day.direct,2)
    if day.direct(i) ==0 && day.direct_channel(i) ==0 
        if cell_id ==counter
            IDnear = i;
            break
        else
counter = counter+1;
        end
    end
end

% make a unique ID for each cell
% ID(day,cell_index)
