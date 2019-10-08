function NHP_PSTH(Val,target_in);

% get the timeseries for the PSTH
MakeMov =0;


col = jet(14);
counter = 1;
figure();
n = target_in; % neuron
for i = 1:20:250;
   
    for ii = 1:size(Val,1);
        
        AA(:,ii) = zscore(mean(Val{ii,n}(400:1800,1+i:50+i)')-median(mean(Val{ii,n}(400:1800,1+i:50+i)')));
        
        
    end
    counter = counter+1;
    hold on;
    adata = AA';
    L = size(adata,2);
    se = std(adata)./4;
    mn = mean(AA,2)';
    mn = mn+ii*.4;
    
    h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(counter,:)); alpha(0.5);
    set(h,'EdgeColor','none')
    plot(mn,'Color',col(counter,:));
    %counter = counter+1;
    pause(0.1);
end

% 
% 
% clear AA;
% % for all targets
% for n = 1:7;  
%     for i = 1:50:300;
%         clf
%         for ii = 1:47;
%             
%             AA(:,counter) = zscore(mean(Val{ii,n}(400:1800,1+i:50+i)')-median(mean(Val{ii,n}(400:1800,1+i:50+i)')));
%             counter = counter+1;
%         end       
%     end
% end
% 
% hold on;
% adata = AA';
% L = size(adata,2);
% se = std(adata)./4;
% mn = mean(AA,2)';
% mn = mn+ii*.4;
% 
% h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(1,:)); alpha(0.5);
% plot(mn,'Color',col(1,:));
% %counter = counter+1;
