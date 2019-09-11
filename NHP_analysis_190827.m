function NHP_analysis_190827(Val2_DIR,Val2_INDR,target_in);
% Data:
% Ganguly2009/data/targetdata/Val2


% 1. Run through the Schnitz plots for each target
% 2. movie of evolution of temporal structure

% TO DO:
% Calculate prefered direction...
% - Roseplot of prefered direction



for target = 1:7;
NHP_analysis_190630(Val2_DIR,Val2_INDR,target)
end


pause();
close all

col = lines(100);



figure(); 
n = target_in; % neuron
for i = 1:25:250; 
       clf
   for ii = 1: 35;
        subplot(1,2,2)
       hold on;

       adata = Val2_INDR{ii,n}(400:1800,1+i:50+i)' - median(Val2_INDR{ii,n}(400:1800,1+i:50+i)');
    ylim([-0.1 12]);
    
    %%
    adata = adata;
    L = size(adata,2);
se = std(adata)/4;
mn = mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)')-median(mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)'));
mn = mn+ii*.4;
 
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(ii,:)); alpha(0.5);
plot(mn,'Color',col(ii,:));
%counter = counter+1;
    
    
    %%
    
    AA(:,ii) = mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)')-median(mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)'));
      hold off;

   end
   subplot(1,2,1)
   plot(zscore(mean(AA')),'LineWidth',3)
   ylim([-3 12]);
   xlim([0 1500]);
  pause(0.01); 
end
end

