function NHP4unme_dispatch(paco_struct, direct_id,indirect_far_id)


% make folders
mkdir('Direct_figs');
mkdir('Direct_jpg');

mkdir('Indirect_figs');
mkdir('Indirect_jpg');



% Direct Neurons
[DN_index IND_index] = NHP_Index(direct_id,indirect_far_id);

for cell_id = 1;
    try
[DIR_INDR] = NHP4unme_acrossDays(paco_struct, DN_index,IND_index,cell_id,0);

if DIR_INDR ==1;
    fold =  'Direct';
else
    fold = 'Indirect';
end


for targets = 1:7
saveas(figure(targets),[fold,'_figs/', 'Cell ', num2str(cell_id),'_Target_',num2str(targets)]);
saveas(figure(targets),[fold,'_jpg/','Cell ', num2str(cell_id),'_Target_',num2str(targets),'.jpg']);
end

saveas(figure(targets+1),[fold, '_figs/', 'Cell ',num2str(cell_id),'Waveforms1']);
saveas(figure(targets+1),[fold, '_jpg/','Cell ',num2str(cell_id),'Waveforms1','.jpg']);
saveas(figure(targets+2),[fold, '_figs/', 'Cell ',num2str(cell_id),'Waveforms2']);
saveas(figure(targets+2),[fold, '_jpg/','Cell ',num2str(cell_id),'Waveforms2','.jpg']);

close all

catch
    end
    
end
