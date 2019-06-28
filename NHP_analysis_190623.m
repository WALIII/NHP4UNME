
function [out] =  NHP_analysis_190623(Val);

% How different are the time series across targets?
% How consistannt do the time-series become over learning? 

% output:
%  out.AcrossTargets; how similar is timeseries across targets, over time?
%  out.SimilarityToLast; how correlated is timeseries to the last timebin?


% First run: 
%       for i = 1:7; Val(:,:,i) = NHP_easyWarp(TargetData,i,1); end
%       [TargetData] = NHP_FormatForWarping(paco_struct,direct_id,indirect_allfar_id)

[timepoints, bins2use, targets] = size(Val);
    

figure(); 
   clear H2 H1 GG1 GG2 g 
for ii = 1:bins2use;% bin in trial
for i = 1: targets; % target
    hold on;
    H1(:,i,ii) = smooth(squeeze(Val(800:1300,ii,i)),50);
 
end
GG1 = corr(squeeze(H1(:,:,ii)));
g(:,:,ii) = GG1;
GG1(GG1 ==1) = [];
GG2(:,ii) = GG1(:);
end

out.AcrossTargets = GG2;

B = median(GG2);
e1 = std(GG2)/2;
figure();
hold on;
errorbar(1:length(B),B,e1)
title('temporal correlation across targets for one neuron '); 
xlabel('days 5-35 (groups of 50 trials, successful target reaches)');
ylabel(' time series correlation');




% Time series consistancy over time ( single cells);
figure(); 
   clear H2 H1 GG1 GG2 g 

for i = 1: targets; % target
for ii = 1:bins2use;% bin in trial

    hold on;
    H1(:,ii,i) = smooth(squeeze(Val(900:1300,ii,i)),50);
 
end
GG1 = corr(squeeze(H1(:,:,i)));
GG2(:,i) = GG1(:,bins2use);
end
GG2 = GG2';
B = mean(GG2);
e1 = std(GG2)/2;
figure();
hold on;
errorbar(1:length(B),B,e1)
title('temporal correlation across targets for one neuron '); 
xlabel('days 5-35 (groups of 50 trials, successful target reaches)');
ylabel(' time series correlation');


out.SimilarityToLast = GG2;

