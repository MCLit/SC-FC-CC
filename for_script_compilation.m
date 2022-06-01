qrsh -l short
cd /mnt/iusers01/sw01/mbrx4ml4/scratch/mnt/bmh01-rds/Anna_Woollams/HCP_1_50/var90/var100/individ

module load apps/binapps/matlab/R2018a

mcc -R -singleCompThread -m csf_core.m

qsub sub_CV.sh
