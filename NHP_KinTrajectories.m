
function NHP_KinTrajectories(out,session);

% session = 15;
% Plot the kin data;
col = {'r','g','b','y','m','c','g'};
figure();
for ii = 1:100; 
for target = [1:7]; 
toP = out{session}.KinData{target};
bound = 50; 
hold on; 
for i = 1:size(out{session}.KinData{target},2)
    % find start
    timeVect = out{session}.KinDatats{target}{i};
    
 diffG = out{session}.starts{target}(i)-(out{session}.ends{target}(i)+10);
 [b1 b2] = min(abs(timeVect-9));
 [b1 b3] = min(abs(timeVect-(9.9+diffG)));
 
  % Get all speeds:
TarSpeed{target}(:,i) = diffG;
 
 if (b2+1+ii)<b3
plot(toP{i}((b2+ii:b2+1+ii),1),toP{i}((b2+ii:b2+1+ii),2),'Color',col{target})
plot(toP{i}((b2+1+ii),1),toP{i}((b2+1+ii),2),'*','Color',col{target})
 else
plot(toP{i}((b3),1),toP{i}((b3),2),'o','Color',col{target})
 end

xlim([-2 3]);
ylim([1.5 6]);
end
end
title(['time to start ', num2str(-1 + ii*.1)]);
pause(0.0001);
clf
end






% Plot the fastest kin data;
nFast = 10;

col = {'r','g','b','y','m','c','g'};
figure();
for target = [1:7]; 
    clear FastestTimes
    [ts,FastestTimes] = sort(TarSpeed{target});
toP = out{session}.KinData{target};
bound = 50; 
hold on; 
for ii = 1:nFast%size(out{session}.KinData{target},2)
    % find start
    i = FastestTimes(ii);
    timeVect = out{session}.KinDatats{target}{i};
    
 diffG = out{session}.starts{target}(i)-(out{session}.ends{target}(i)+10);
 [b1 b2] = min(abs(timeVect-10));
 [b1 b3] = min(abs(timeVect-(10+diffG)));


plot(toP{i}((b2:b3),1),toP{i}((b2:b3),2),'Color',col{target})
plot(toP{i}((b3),1),toP{i}((b3),2),'o','Color',col{target})


xlim([-2 3]);
ylim([1.5 6]);
end
end





% 
% % color line:
% figure();
% for target = [5]; 
% toP = out{session}.KinData{target};
% bound = 50; 
% hold on; 
% for i = 1:size(out{session}.KinData{target},2)
%     % find start
%     timeVect = out{session}.KinDatats{target}{i};
%     
%  diffG = out{session}.starts{target}(i)-(out{session}.ends{target}(i)+10);
%  [b1 b2] = min(abs(timeVect-9.9));
%  [b1 b3] = min(abs(timeVect-(9.9+diffG)));
% 
%  if b2>b3; 
%      disp('out of bounds..');
%  continue;
%  end % bad example...
% p = plot(toP{i}((b2:b3),1),toP{i}((b2:b3),2));
% %// modified jet-colormap
% cd = [uint8(jet(length(b2:b3))*255) uint8(ones(length(b2:b3),1))].'; %'
% 
% drawnow
% set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd);
% 
% plot(toP{i}((b3),1),toP{i}((b3),2),'o','Color',col{target})
% 
% 
% xlim([-2 5]);
% ylim([1.5 6]);
% end
% end
% 
% 
% 
% % Plot fastest trace:


