
function [TargetData3] = NHP_analysis_190627(TargetData2)


% itterate through all to make TargetData2

for neuron = 1:max(TargetData(1).neurons);
    for  target = 1:7
        [Val2{neuron,target},TargetData2,MeanTL(target)] = NHP_easyWarp(TargetData2,target,neuron);
    end
    disp(['Moving to Neuron', num2str(neuron)]);
end




clear B C dat dat2 output indX
figure();
hold on;
col = jet(47);
int1 = 1:50:301;
for i = 4; % target
    for ii = 1:47; % neuron    
        Val = Val2{ii,i};
        for session = 1:6;       
            data = zscore(Val(:,int1(session):int1(session+1)))';;          
            dat{session}(:,:,ii) = data;

        end
    end
end


figure();
hold on;
for i = 1:6
    dat2.directed = dat{6}(:,920:1100,:); % whole time series 950:1400
    dat2.undirected = dat{i}(:,920:1100,:);
[indX,B(:,:,i),C(:,:,i), output] = CaBMI_schnitz(dat2,'smooth',20);
end

figure();
for i = 1:6
subplot(1,6,i);
imagesc(squeeze(C(:,:,i)),[0, 3] );
colormap(hot);
end

TargetData3 = TargetData2;


