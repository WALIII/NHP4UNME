function [DN_index, IND_index, out] = NHP_Index(direct_id,indirect_far_id)
% get the true ID of each cell based on a convoluted indexing scheme...
% For all cells

% max number of unique direct cells
h = cat(1,direct_id{:});
unique_ID = unique(h);
first_day = 5;
last_day = 34;

%% For stable, continuous direct units:


% for each unique Direct cell, loop though all days and make a channel
% reference for that day ( if there is one).
for i = unique_ID'
    for day = 1:size(direct_id,1);
        try
            DN_index{i}(day) = find(direct_id{day}==i);
        catch
            DN_index{i}(day) = NaN;
        end
    end
end

% % Plot stable Direct units:
% GG = cat(1,DN_index{:}); GG(GG>0) =10;
% figure(); imagesc(GG);
% title('Stability of Direct Units');
% ylabel('putative unique unts');
% xlabel('Days');
% 

% Plot stable Inirect units:
GG = cat(1,DN_index{:});
GG(GG>0) =10;
GG(isnan(GG))=0;

figure(); imagesc(GG);
title('Stability of Direct Units');
ylabel('putative unique unts');
xlabel('Days');

% sort by the most stable units:
GGsum = sum(GG');
[a,b] = sort(GGsum,'descend');
figure(); imagesc(GG(b,:));

figure(); histogram(GGsum/10);
title('Distribution of stable Direct units');
xlabel('Days of continuous stability')
ylabel('Number of putative unique units');

% find all units that are stable from day 5 to day 34;
idx_stable_direct = find(GG(:,first_day) ==10 & GG(:,last_day) ==10);
DirectStableCells = GG(idx_stable_direct,:);
figure();
imagesc(DirectStableCells);

out.idx_stable_direct = idx_stable_direct;
out.DirectStableCells = DirectStableCells;

clear GG GGsum a b h 



%% Indirect Far Neurons
h = cat(1,indirect_far_id{:});
unique_ID = unique(h);

% for each unique Direct cell, loop though all days and make a channel
% reference for that day ( if there is one).
for i = unique_ID'
    for day = 1:size(indirect_far_id,1);
        try
            IND_index{i}(day) = find(indirect_far_id{day}==i)+15;
        catch
            IND_index{i}(day) = NaN;
        end
    end
end


% Plot stable Inirect units:
GG = cat(1,IND_index{:});
GG(GG>0) =10;
GG(isnan(GG))=0;

figure(); imagesc(GG);
title('Stability of Indirect Units');
ylabel('putative unique unts');
xlabel('Days');

% sort by the most stable units:
GGsum = sum(GG');
[a,b] = sort(GGsum,'descend');
figure(); imagesc(GG(b,:));

figure(); histogram(GGsum/10);
title('Distribution of stable cells');
xlabel('Days of continuous stability')
ylabel('Number of putative unique units');

% find all units that are stable from day 5 to day 34;
idx_stable_indirect = find(GG(:,first_day) ==10 & GG(:,last_day) ==10);
IndirectStableCells = GG(idx_stable_indirect,:);
figure();
imagesc(IndirectStableCells);

out.idx_stable_indirect = idx_stable_indirect;
out.IndirectStableCells = IndirectStableCells;





% need to account fot the  '-1's we will put away...





