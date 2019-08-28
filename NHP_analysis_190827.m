function NHP_analysis_190827(Val2_DIR,Val2_INDR,target);
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

figure(); 
n = 7; % neuron
for i = 1:250; 
       clf
   for ii = 1: 35;
        subplot(1,2,2)
       hold on;
    plot(mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)')-median(mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)'))+ii*.2); 
    ylim([-0.1 12]);
    AA(:,ii) = mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)')-median(mean(Val2_INDR{ii,n}(400:1800,1+i:50+i)'));
      hold off;

   end
   subplot(1,2,1)
   plot(zscore(mean(AA')),'LineWidth',3)
   %ylim([-0.1 12]);
  pause(0.01); 
end
end

