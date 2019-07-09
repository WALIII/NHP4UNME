function NHP_analysis_190706(Val2_DIR, tot);
% Plot the across learning seperability of trajectories, and increase in
% stereotopy of temporal profiles

% neuron 
counter = 1;
for neuron = 1:tot;
clear Val temp;


% group data into bins:
Bins = 1:30:301;

for ii = 1:7;
for i = 1: size(Bins,2)-1;
    
        Bins2use = Bins(i):Bins(i+1);
        temp = mean(Val2_DIR{neuron,ii}(:,Bins2use),2);
        Val(:,i,ii) = temp;

end
end

if counter ==1;
[A2,B2] =  NHP_analysis_190623(Val);
else
    [Atemp Btemp] =  NHP_analysis_190623(Val);
    A2 = cat(1,A2,Atemp);
    B2 = cat(1,B2,Btemp);
end

counter = counter+1;
end

close all;

% plot thte data:
B = mean(A2);
e1 = std(A2)/sqrt(length(B));;
figure();
hold on;
errorbar(1:length(B),B,e1)
title('Correlation Across targets'); 
xlabel('days 5-35 (groups of 50 trials, successful target reaches)');
ylabel(' time series correlation');

clear B

% plot thte data:
B = mean(B2);
e1 = std(B2)/sqrt(length(B));;
figure();
hold on;
errorbar(1:length(B),B,e1)
title('Reach correlation to last bin'); 
xlabel('days 5-35 (groups of 50 trials, successful target reaches)');
ylabel(' time series correlation');

