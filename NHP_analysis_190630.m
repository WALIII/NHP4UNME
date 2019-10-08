
function [out] = NHP_analysis_190630(Val2_DIR,Val2_INDR,target,outsort)

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
    if outsort==0; 
    dat2.directed = dat{6}(:,920:1100,:); % whole time series 950:1400
    else 
        dat2.directed = outsort;
    end
    dat2.undirected = dat{i}(:,920:1100,:);
    % at the ends: 
    dat3.directed = dat{6}(:,920:1100,:);
    dat3.undirected = dat{i}(:,1180:1360,:);
[indX,B(:,:,i),C(:,:,i), output] = CaBMI_schnitz(dat2,'smooth',20,'show',0);
[indX2,B2(:,:,i),C2(:,:,i), output2] = CaBMI_schnitz(dat3,'smooth',20,'show',0);

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

% 
% figure();
% for i = 1:6
% subplot(1,7,i);
% imagesc(squeeze(C2(:,:,i)),[0, 3] );
% colormap(hot);
% end
% subplot(1,7,7); % dir vs indir:
% imagesc(Ind2plot(indX2)')
% title('white is DIR, END SORTED');
out = dat{6}(:,920:1100,:);
