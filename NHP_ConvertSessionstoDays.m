function out = NHP_ConvertSessionstoDays(neuronsOfInterest);
% Combine sessions on the same day for subsequent analysis
% This is going to be a fucking cluge...

% WAL3
% 190717

NumNeurons = size(neuronsOfInterest,1);


NumSessions = size(neuronsOfInterest,2);

counter = 1;
for i =1:NumSessions
    
    if i ==1;
        compDay = neuronsOfInterest{i}.day;
        out{counter} = neuronsOfInterest{i};
%         out{counter}.xPoints = neuronsOfInterest{i}.xPoints;
%         out{counter}.yPoints = neuronsOfInterest{i}.yPoints;
%         out{counter}.xPoints2 = neuronsOfInterest{i}.xPoints2;
%         out{counter}.yPoints2 = neuronsOfInterest{i}.yPoints2;
%         out{counter}.timestamps = neuronsOfInterest{i}.timestamps;
%         out{counter}.starts = neuronsOfInterest{i}.starts;
%         out{counter}.ends = neuronsOfInterest{i}.ends;
%         out{counter}.len_sort = neuronsOfInterest{i}.len_sort;
%         out{counter}.n_act_vect2_sort = neuronsOfInterest{i}.n_act_vect2_sort;
        
    else
        currDay = neuronsOfInterest{i}.day;
        if currDay == compDay; % combine if the same day
            % for each target...
            for iii = 1:7
                out{counter}.xPoints{:,iii} = cat(1,out{counter}.xPoints{:,iii},neuronsOfInterest{i}.xPoints{:,iii});
                out{counter}.yPoints{:,iii} = cat(1,out{counter}.yPoints{:,iii},neuronsOfInterest{i}.yPoints{:,iii});
                out{counter}.xPoints2{:,iii} = cat(1,out{counter}.xPoints2{:,iii},neuronsOfInterest{i}.xPoints2{:,iii});
                out{counter}.yPoints2{:,iii} = cat(1,out{counter}.yPoints2{:,iii},neuronsOfInterest{i}.yPoints2{:,iii});
                
                %% TO DO% timestamps need special handeling...
           
                out{counter}.timestamps{:,iii} = cat(2,out{counter}.timestamps{:,iii},neuronsOfInterest{i}.timestamps{:,iii});
                out{counter}.starts{:,iii} = cat(2,out{counter}.starts{:,iii},neuronsOfInterest{i}.starts{:,iii});
                out{counter}.ends{:,iii} = cat(2,out{counter}.ends{:,iii},neuronsOfInterest{i}.ends{:,iii});
  
                 
                 end
            
            out{counter}.len_sort = cat(2,out{counter}.len_sort,neuronsOfInterest{i}.yPoints2);
            out{counter}.n_act_vect2_sort = cat(2,out{counter}.n_act_vect2_sort,neuronsOfInterest{i}.yPoints2);
            compDay = neuronsOfInterest{i}.day;
        else
            counter = counter+1;
            out{counter} = neuronsOfInterest{i};
            compDay = neuronsOfInterest{i}.day;   
        end
    end
end

% Finlly, re-sort!

disp('resorting data!');

for i = 1:size(out,2)
for iii = 1:7

    tms = out{i}.ends{:,iii}- out{i}.starts{:,iii};
    
    [a,b] = sort(tms);
    out{i}.ends{:,iii} = out{i}.ends{:,iii}(:,b);
    out{i}.starts{:,iii} = out{i}.starts{:,iii}(:,b);
    out{i}.timestamps{:,iii} = out{i}.timestamps{:,iii}(:,b);
end
end

               


