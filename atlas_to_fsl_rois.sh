#!/bin/bash --login
#$ -cwd

module load apps/binapps/fsl/6.0.3 

cd /mnt/bmh01-rds/Anna_Woollams/HCP_1_50/atlas/Yeo/7

for i in {1..51}
do
fslmaths Yeo2011_7Networks.nii -thr $i -uthr $i -bin Yeo7_rois_$i
done
