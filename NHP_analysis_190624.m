
function NHP_analysis_190624(TargetData,neuron);
% NHP Analysis 190624

% look at warped data across targets for ones cell:

close all

% look at all targets


for  target = 1:7
[Val{target},TargetData,MeanTL(target)] = NHP_easyWarp(TargetData,target,neuron);
end

%close all;

% 
MeanTL(1:20) = 2.5;



figure()

for nn = 1:7;
ax(nn) = subplot(1,7,nn);
for i = neuron
    hold on;
    for ii = 1:max(TargetData(nn).trials);
        lT = find(TargetData(nn).neurons==i  & TargetData(nn).trials == ii);
        
        tempNeuron{ii} = TargetData(nn).warped_times(lT);
    end
    plotSpikeRaster(tempNeuron,'PlotType','vertline');
    hold on;
    %plot(ones(1,length(TargetData(nn).metadata.trial_go(:)))*MeanTL(nn)+20,1:size(TargetData(nn).metadata.trial_go(:)))
    %plot(TargetData(nn).metadata.water_on(:)+10,1:size(TargetData(nn).metadata.trial_go(:)))
    %
%     
    xlim([19 30]);
    clear tempNeuron;
    title(['Neuron ',num2str(i)]);
end


end

Val2 = Val;
clear Val



Val = Val2{2};
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



%% plot all the first trials:


figure(); 
hold on;
int1 = 1:50:301;
col = jet(7);

for i = 1:7;
    Val = Val2{i};
for iii = 1
    
data = Val(:,int1(iii):int1(iii+1))'-i/2;

L = size(data,2);
se = std(data)/2;%sqrt(length(data));
mn = mean(data);
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(0.5);
plot(mn,'Color',col(i,:));
set(h,'EdgeColor','None');
end
end
title(' All first trials');

% ax(:).YDir = 'reverse';


%% plot all the first trials:


figure(); 
hold on;
int1 = 1:50:301;
col = jet(7);

for i = 1:7;
    Val = Val2{i};
for iii = 6
    
data = Val(:,int1(iii):int1(iii+1))'-i/2;

L = size(data,2);
se = std(data)/2;%sqrt(length(data));
mn = mean(data);
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(0.5);
plot(mn,'Color',col(i,:));
set(h,'EdgeColor','None');
end
end
title(' All last trials');

