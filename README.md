# NHP4UNME
Finding similarities in mice and NHP


To process the data appropriately, load in:

```
paco_struct.mat
unique_ids.mat
```

Enter the Ganguly_2009/data folder. Then run:

```
[TargetData]= NHP_FormatForWarping(paco_struct,direct_id,indirect_allfar_id)
```

Target data generated locally already exists in .mat files:

```
../Ganguly_2009/data/TargetData/190718
```

run this basic analysis script for raster generation on cell 20 :

```
NHP_analysis_190624(TargetData_IND,20);
```
