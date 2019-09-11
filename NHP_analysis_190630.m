
function NHP_analysis_190630(Val2_DIR,Val2_INDR,target)

% plot schnitz data for direct and indirect data:

% Load data from Ganguly2009/data/targetdata/Val2



% COncat the data:
Val2_all = cat(1, Val2_INDR,Val2_DIR);


Ind2plot = [ zeros(1,size(Val2_INDR,1)), ones(1,size(Val2_DIR,1))];

clear B C dat dat2 output indX
% figure();
hold on;
col = jet(47);
int1 = 1:50:301;
for i = target; % target
    for ii = 1:size(Val2_all,1); % neuron    
        Val = Val2_all{ii,i};
        for session = 1:6;       
            data = zscore(Val(:,int1(session):int1(session+1)))';;          
            dat{session}(:,:,ii) = data;
        end
    end
end
% figure();
% plot(mean(data));


% figure();
hold on;
for i = 1:6
    dat2.directed = dat{6}(:,920:1100,:); % whole time series 950:1400
    dat2.undirected = dat{i}(:,920:1100,:);
[indX,B(:,:,i),C(:,:,i), output] = CaBMI_schnitz(dat2,'smooth',20,'show',0);
end

figure();
for i = 1:6
subplot(1,7,i);
imagesc(squeeze(C(:,:,i)),[0, 3] );
colormap(hot);
end
subplot(1,7,7); % dir vs indir:
imagesc(Ind2plot(indX)')
title('white is DIR');


