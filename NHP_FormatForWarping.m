function [TargetData]= NHP_FormatForWarping(paco_struct,direct_id,indirect_allfar_id,D_or_IND)
%  NHP_FormatForWarping.m
%  WAL3


% Format data for dynamic time warping

%% find index of neurons that can be consistantly tracked:
[DN_index, IND_index, out] = NHP_Index(direct_id,indirect_allfar_id);

%% For Direct or Indirect units:
if D_or_IND == 1;
% Direct
IdX = out.idx_stable_direct;
else
% Indirect
IdX = out.idx_stable_indirect;
end
%% Sanity check ( waveforms) with manual exclusion
% remove outliers


%% extract these cells on these days:
counter = 1;
for i = 1:size(IdX,1)
    if D_or_IND == 1;
    cell2use = out.idx_stable_direct(i);
    else
    cell2use = out.idx_stable_indirect(i);
    end

    [~, neuronsOfInterest{counter}] = NHP4unme_acrossDays(paco_struct, DN_index,IND_index,cell2use,D_or_IND);
    neuronsOfInterest{counter} = NHP_ConvertSessionstoDays(neuronsOfInterest{counter});

counter = counter+1;
end
%% Format for TimeWarping:
disp('pausing for warping');

[TargetData]  = NHP_formatSpikes(neuronsOfInterest);





% plot data
figure();
for i = 1:max(TargetData(1).neurons(:))
l1 = find(TargetData(1).neurons==i);
 plot(TargetData(1).times(l1),TargetData(1).trials(l1),'.');
 title(['Neuron ',num2str(i)]);

prompt = 'Do you want to keep this one? y/n [y]: ';
str = input(prompt,'s');
if str == 'n';
    disp('removing bad neuron');
    TargetData(1).neurons(l1) = [];
    TargetData(1).times(l1) = [];
    TargetData(1).trials(l1) = [];
if isempty(str)
    str = 'Y';
end
end
%h = histogram([TargetData(1).times(l1)],1000)
%Val(:,i) = h.Values;
end
disp(['Found',num2str(max(TargetData(1).neurons(:))),'neurons'])

%figure(); hold on; for i = 1 plot(zscore(smooth(Val(:,i),10))+i*3); end


%% Save data

mkdir('python_files');
% For all detected 'targets' save a seperate file for each:
curr_time =datenum(now); 
for ii = 1: size(TargetData,2);
%% Format data in .h5 format
filename = ['python_files/',num2str(round(curr_time*10000)),'_Target_',num2str(ii),'.h5'];
trials = TargetData(ii).trials;
times = TargetData(ii).times;
neurons = TargetData(ii).neurons;
    h5create(filename,'/trials',[size(trials,2)],'Datatype','int64')
    h5create(filename,'/times', [size(times,2)],'Datatype','int64')
    h5create(filename,'/neurons',[size(neurons,2)],'Datatype','int64')
    
    h5write(filename,'/trials',(trials))
    h5write(filename,'/times',(times*1000))
    h5write(filename,'/neurons',(neurons))
    
    clear trials times neurons filename
    
end
