clear

load('neural_data.mat') % full correlation
load('confounds.mat') % loads variable ID = [age, education, gender];

% model construction sample
group_f(237,:) = []; % this participant had a cognitive value missing and was not part of the selected dataset
FC = group_f;

% out of sample testing group
load('cognitive_data.mat')

Y = Y(:,1);

F_cv_mdl = stepwise_cv(Y, FC, confounds); % crossvalidation error, training and test models, pca solution
save('mdl_F_FAC1.mat')