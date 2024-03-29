function [out] = NHP4unme_trialTimes(trial_data,day,cell,plotting);

out = [];
close all;
targets = [73 74 75 76 77 78 79 80]; %73 80
counter = 1;
pad = 10;
plotmax = 8; % how many targets to plot...

for ii = 1:plotmax; % for a sample of targets,
    
    target = targets(ii);
    for i = 1:size(trial_data,1); % for every trial, if it is 'valid' and a 'success'
        if trial_data(i).valid ==1 &&  trial_data(i).success ==1  && trial_data(i).target == target ;
            
            stT(ii,counter) = trial_data(i).start_ts-pad; % get all start-
            spT(ii,counter) = trial_data(i).stop_ts+pad;  % and stop times.
            len(ii,counter) = spT(ii,counter)-stT(ii,counter);
            ts_spk = find(day.timestamps{cell}> stT(ii,counter) &  day.timestamps{cell}<spT(ii,counter));
            try
                temp = day.timestamps{cell}(ts_spk) - stT(ii,counter);
                temp2 = day.timestamps{cell}(ts_spk) - spT(ii,counter)+pad*2;
                
                n_act_vect{counter} = temp';
                n_act_vect2{counter} = temp2';
                waveforms{counter} = day.waveforms{cell}(ts_spk,:); % get corresponding waveforms
                % Get Kin data
                % find closest start and stop
                Kin_idx = find(day.kindata_ts>stT(ii,counter)&day.kindata_ts<spT(ii,counter));
                Kin_data{counter} = day.kindata(Kin_idx,:);                
                Kin_data_ts{counter} = day.kindata_ts(Kin_idx)-stT(ii,counter);;
                
                
                clear ts_spk temp temp2 Kin_idx;
                counter = counter+1;
            catch
                disp('missing data')
                continue
            end
            
        end
    end
    if counter ==1;
        disp('missing data')
        continue
    end
    counter = 1;
    
    %
    % Sort based on length
    [x1 x2] = sort(len(ii,:));
    for i2 = 1: size(x2,2)
        n_act_vect_sort{i2} = n_act_vect{x2(i2)};
        n_act_vect2_sort{i2} = n_act_vect2{x2(i2)};
        len_sort(ii,i2) = len(ii,x2(i2));
        Wave_sort{i2} = waveforms{x2(i2)};
        Kin_data_ts_sort{i2} = Kin_data_ts{x2(i2)};
        Kin_data_sort{i2} = Kin_data{x2(i2)};  
    end
    
   
    % clear unnsorted vals
    clear n_act_vect n_act_vect2 waveforms len Kin_data_ts Kin_data
    
    % len to plot
    Tlen = size(len_sort,2);
    % align to start
    if plotting ==1;
        figure(1)
        a(ii) = subplot(plotmax,1,ii);
    end
    try
        [out.xPoints{ii}, out.yPoints{ii}] = plotSpikeRaster(n_act_vect_sort,'PlotType','vertline');
        out.WaveSort{ii} = Wave_sort;
      
    catch
        disp(' no spikes in this cell');
        break
    end
    if plotting ==1;
        hold on;
        for iii = 1:Tlen;
            plot(pad,0+iii,'.r')
            plot(len_sort(ii,iii)-pad,0+iii,'.b')
        end
        linkaxes(a(:),'x');
        if ii ==1;
            title('aligned to onset');
            xlabel('time (s)')
            ylabel('trials');
        end
    end
    
    % align to end
    if plotting ==1;
        figure(2)
        a2(ii) = subplot(plotmax,1,ii);
    end
    [out.xPoints2{ii}, out.yPoints2{ii}] = plotSpikeRaster(n_act_vect2_sort,'PlotType','vertline');
    out.timestamps{ii} = n_act_vect_sort;
    out.starts{ii} = len_sort(ii,:);%pad*3-len_sort(ii,:);
    out.ends{ii} = ones(1,size(len_sort,2))*pad;
    out.KinData{ii} = Kin_data_sort;
    out.KinDatats{ii} = Kin_data_ts_sort;
    if plotting ==1;
        hold on;
        for iii = 1:Tlen;
            plot(pad,0+iii,'.b')
            plot(pad*3-len_sort(ii,iii),0+iii,'.r')
        end
        linkaxes(a2(:),'x');
        if ii ==1;
            title('aligned to offset');
            xlabel('time (s)')
            ylabel('trials');
        end
    end
    out.len_sort = len_sort;
    % % make firing rates
    % figure(3)
    % b(ii) = subplot(5,1,ii);
    % FR = cat(2, n_act_vect{:});
    % histogram(FR,100)
    % clear FR
    %
    % linkaxes(b(:),'x');
    out.n_act_vect2_sort =  n_act_vect2_sort;
    % clear unused vars
    clear waveforms
end


