clear
load('neural_data.mat') % full correlation
% subject 237 has missing data
group_f(237,:) = [];
group_s(237,:) = [];

% split into TRAIN and test
F = group_f([1:200],:);
S = group_s([1:200],:);
J = [S F]; % joining of structure and function

% out oj sample testing group
f = group_f([201:249],:);
s = group_s([201:249],:);
j = [s f];

load('cognitive_data.mat')
% scores for the first cognitive component
Y = Y(:,1);
y = y(:,1);

[J_error J_cv_mdl J_solution] = stepwise_cv(Y, J); % crossvalidation error, training and test models, pca solution
save('mdl_J_FAC1.mat')
