# Reference

# Background
Structural connectivity and functional connectivity were related to each other in a sample of 249 Human Connectome Project's subjects to produce models of healthy cognitive function. Principal Component Regression method was combined with 10-fold cross-validation to generate the models. 

# Folder "scripts" contains the following:

- cognition.m contains the script used to apply Principal Component Analysis to cognitive dataset
- base.m contains the base script used to call on function stepwise_cv.m
- stepwise_cv.m is the function that conducts 1000 iterations of 10-fold cross-validation
- gen_cv_mdls.m uses outputs of base.m to produce .mat files with 200 subject model and out of sample testing
- permute_betas.m uses mdl.mat to produce brain connectome projections

