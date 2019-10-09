


% Make and save NHP BMI figures for future analysis

close all; % Close all to start

mkdir('NHP_images2')
for neuron = 1:max(TargetData(1).neurons)
for  target = 1:7
[Val2{neuron,target},TargetData,MeanTL(target)] = NHP_easyWarp(TargetData_IND,target,neuron);

% Save in some local folder:
filename = ['NHP_images2/','Neuron_', num2str(neuron),'_Target ',num2str(target)];
saveas(figure(1),filename,'jpg')
close all
end
disp(['Moving to Neuron', num2str(neuron)]);
end

 % make specific figure
 
 neuron = 14;
 target = 3;
 [~,~,~] = NHP_easyWarp(TargetData_IND,target,neuron);
