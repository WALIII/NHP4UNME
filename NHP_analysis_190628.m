
% NHP_analysis_190628
% plot the mean, normalized activity for all cells on all days:

% days
d = 1;
for i = 1: 47;
 
MeanActivity_1(:,i) = zscore(mean(Val2{i,d}(700:1600,1:50),2));
MeanActivity_2(:,i) = zscore(mean(Val2{i,d}(700:1600,200:250),2));

end


figure(); 
hold on;
i = 1
col = jet(7);

data = MeanActivity_2';
L = size(data,2);
se = std(data)/2;%/sqrt(length(data));
mn = mean(data)- min(mean(data(1:300))); % zero mean
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(0.5);
plot(mn,'Color',col(i,:));
set(h,'EdgeColor','None');

i = 5

data = MeanActivity_1';
L = size(data,2);
se = std(data)/2;%/sqrt(length(data));
mn = mean(data)- min(mean(data(1:300))); % zero mean
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(i,:)); alpha(0.5);
plot(mn,'Color',col(i,:));
set(h,'EdgeColor','None');


