function [Val,TargetData,MeanTL] = NHP_easyWarp(TargetData,target,neuron);

plotting = 1;


nn = target;
% neuron = 1;
% Warp attempt
offset = 0.4;
stopT= TargetData(nn).metadata.trial_go(:);
stopT(stopT<1) = 21;
startT = TargetData(nn).metadata.water_on(:)+10;


trialLen = stopT-startT;

MeanTL = 2.5;%mean(trialLen);
disp([' Mean trial length is set to ', num2str(MeanTL),' seconds']);

% make new vector with warped times
TargetData(nn).warped_times = TargetData(nn).times;



for trial = 1:max(TargetData(nn).trials);
% warp every trial % find spikes in range:

l1 = find(TargetData(nn).neurons==neuron & TargetData(nn).trials == trial & TargetData(nn).times>= startT(trial)+offset & TargetData(nn).times<= stopT(trial));
times2warp = TargetData(nn).times(l1)-startT(trial)+.0001;
times2warp = [0.1, times2warp,(stopT(trial)-startT(trial)+.0001)];
warped_ratio = MeanTL./(max(times2warp));
warped_times = times2warp.*warped_ratio;
warped_times2 = warped_times(2:end-1);
TargetData(nn).warped_times(l1) = warped_times2+startT(trial);

if isempty(warped_times2)
    times2warp = [0, (stopT(trial)-startT(trial)+.0001) ];
    warped_times = times2warp.*warped_ratio;
end
%figure();
%hold on;
%scatter(times2warp,ones(length(times2warp),1),'r.')
%scatter(warped_times,ones(length(warped_times),1),'bo')
%adjust the rest of the warps for this cell by the time difference in the data:
l2 = find(TargetData(nn).neurons==neuron & TargetData(nn).trials == trial & TargetData(nn).times> stopT(trial));
try

    TargetData(nn).warped_times(l2) = TargetData(nn).times(l2)+(max(warped_times)-(max(times2warp)));
catch
   disp('ERRROR');
end

% permute
    clear l1 l2 warped_times time2warp warped_ratio;
end


if plotting ==1;
% Plot the 2 in a subplot
%%%
figure();
ax1 = subplot(1,3,1);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).times(lT);
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
      hold on;
         plot(stopT,1:size(TargetData(nn).metadata.trial_go(:)));
         plot(TargetData(nn).metadata.water_on(:)+10,1:size(TargetData(nn).metadata.trial_go(:)));

    
    clear tempNeuron;
    title(['Neuron ',num2str(i),' Target ',num2str(target)]);
end
xlim([16 30]);
set(gcf,'renderer','painters');


%%
ax1 = subplot(1,3,2);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).times(lT)-TargetData(nn).metadata.trial_go(ii)+20;
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
      hold on;
         plot(40-stopT,1:size(TargetData(nn).metadata.trial_go(:)));
         plot((TargetData(nn).metadata.water_on(:)+10),1:size(TargetData(nn).metadata.trial_go(:)));
    clear tempNeuron;
    title(['Neuron ',num2str(i),' Target ',num2str(target)]);
end
%%
xlim([12 23]);

ax2 = subplot(1,3,3);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).warped_times(lT);
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
    hold on;
    plot(ones(1,length(TargetData(nn).metadata.trial_go(:)))*MeanTL+20,1:size(TargetData(nn).metadata.trial_go(:)))
    plot(TargetData(nn).metadata.water_on(:)+10,1:size(TargetData(nn).metadata.trial_go(:)))
    %
%     
    clear tempNeuron;
    title(['Neuron ',num2str(i),' Target ',num2str(target)]);
end

ax2.YDir = 'reverse';
ax1.YDir = 'reverse';

% linkaxes([ax1 ax2],'xy');
xlim([16 30]);


%% again, without the lines:
figure();
ax1 = subplot(1,3,1);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).times(lT);
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
      hold on;
        % plot(stopT,1:size(TargetData(nn).metadata.trial_go(:)));
        % plot(TargetData(nn).metadata.water_on(:)+10,1:size(TargetData(nn).metadata.trial_go(:)));

    clear tempNeuron;
    title(['Neuron ',num2str(i),' Target ',num2str(target)]);
end
xlim([16 30]);


%%
ax1 = subplot(1,3,2);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).times(lT)-TargetData(nn).metadata.trial_go(ii)+20;
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
      hold on;
         %plot(40-stopT,1:size(TargetData(nn).metadata.trial_go(:)));
         %plot((TargetData(nn).metadata.water_on(:)+10),1:size(TargetData(nn).metadata.trial_go(:)));
    clear tempNeuron;
    title(['Neuron ',num2str(i),' Target ',num2str(target)]);
end
%%
xlim([12 23]);



ax2 = subplot(1,3,3);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).warped_times(lT);
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
    hold on;
    %plot(ones(1,length(TargetData(nn).metadata.trial_go(:)))*MeanTL+20,1:size(TargetData(nn).metadata.trial_go(:)))
    %plot(TargetData(nn).metadata.water_on(:)+10,1:size(TargetData(nn).metadata.trial_go(:)))
    %
%     
    clear tempNeuron;
    title(['Neuron ',num2str(i),' Target ',num2str(target)]);
end

ax2.YDir = 'reverse';
ax1.YDir = 'reverse';

xlim([16 30]);


figure();

end

%


interval1 = 1;
edges1 = 10:.010:30;
% Make histograms
% figure(); 
for i = 1:301;
%     figure(); 
l3 = find(TargetData(nn).neurons==neuron & TargetData(nn).trials >= (i*interval1) & TargetData(nn).trials <=((i+1)*interval1));
 h = histogram([TargetData(nn).warped_times(l3)],'BinEdges',edges1);
%  h.Normalization = 'probability';
 Val(:,i) = smooth(h.Values,20);
 clear l3
end


% 
% figure();
% hold on; 
%     plot(smooth(mean(Val(:,1:50)'),20),'r');
%     plot(smooth(mean(Val(:,250:300)'),20),'b');
% 
% figure(); imagesc(Val);

if plotting ==1;
figure(); 
hold on;
int1 = 1:50:301;
col = jet(size(int1,2)-1);

for iii = 1:size(int1,2)-1;
    
data = Val(:,int1(iii):int1(iii+1))'-iii/4;

L = size(data,2);
se = std(data)/2;%sqrt(length(data));
mn = mean(data);
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(iii,:)); alpha(0.5);
plot(mn,'Color',col(iii,:));
set(h,'EdgeColor','None');
end
    title(['Neuron ',neuron,' Target ',num2str(target)]);

end


