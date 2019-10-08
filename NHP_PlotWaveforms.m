function NHP_PlotWaveforms(neuronsOfInterest);

tod = 17;
close all
col = hsv(tod);
neuron = 1;
figure(); 
hold on;
for day = 1:tod

    waves = cat(1, neuronsOfInterest{1, 1}{1, day}.WaveSort{neuron}{:});
     plot(waves(1:50,:)'-1800*day,'color',col(day,:));

end


% compare first to last
firstD = 2;
target = 1;
lastD = 17;
col = {'r','k'};
figure(); 
for neuron = 1:5;
    subplot(1,5,neuron);
   
hold on;
counter = 1;
for day = [firstD lastD]
    waves = cat(1, neuronsOfInterest{1, neuron}{1, day}.WaveSort{:});
     waves = cat(1, waves{:});
     plot(waves(1:200,:)'+1500*counter,'color',col{counter});
counter = counter+1;
end
end




