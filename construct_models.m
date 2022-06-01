clear
load('/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/neural_data.mat', 'subs')

data = readtable('/Users/user/Dropbox (The University of Manchester)/RESTRICTED_lczime_5_16_2022_5_50_39.csv');

all_HCP_subs = table2array(data(:,1)); % subject IDs - whole dataset


age = table2array(data(:,2));
education = table2array(data(:,15));

data = readtable('/Users/user/Dropbox (The University of Manchester)/data/behavioural/600+_reduced2.csv');
gender = table2array(data(:,5));

categoricalGender = categorical(gender);
gender = dummyvar(categoricalGender);

individual_differences = [age, education, gender];

subs = cell2mat(subs); subs = str2num(subs); subs(237,:) = []; % subject 237 not part of the sample

[tf,idx] = ismember(subs,all_HCP_subs);

confounds = individual_differences(idx,:);

%
load('/Users/user/Dropbox (The University of Manchester)/stacked-PLS/cognitive_data.mat')
%  load('neural_data.mat')
Y = [Y;y];
confounds(:,4) = [];
EF = fitlm(confounds(:,:),Y(:,1));



SR = fitlm(confounds,Y(:,2));
L = fitlm(confounds,Y(:,3));
E =  fitlm(confounds,Y(:,4));
SEQ =  fitlm(confounds,Y(:,5));

load('neural_data.mat')
group_f(237,:) = [];

[Z, mean_x_train, standard_deviation_x_train] = zscore(group_f); 
        Z(isinf(Z)) = [];
        Z(isnan(Z)) = [];

        [COEFF, SCORE, ~, ~, EXPLAINED, ~] = pca(Z);
x = SCORE;
EF = table2array(EF.Residuals(:,1));
E = table2array(E.Residuals(:,1));
L = table2array(L.Residuals(:,1));
SEQ = table2array(SEQ.Residuals(:,1));
SR = table2array(SR.Residuals(:,1));

F_EF = stepwiselm(x, EF, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
F_E = stepwiselm(x, E, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
F_L = stepwiselm(x, L, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
F_SEQ = stepwiselm(x, SEQ, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
F_SR = stepwiselm(x, SR, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 

save('F_ID.mat')

%%


load('neural_data.mat')
group_s(237,:) = [];

[Z, mean_x_train, standard_deviation_x_train] = zscore(group_s); 
        Z(isinf(Z)) = [];
        Z(isnan(Z)) = [];

        [COEFF, SCORE, ~, ~, EXPLAINED, ~] = pca(Z);
         x = SCORE;

S_EF = stepwiselm(x, EF, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
S_E = stepwiselm(x, E, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
S_L = stepwiselm(x, L, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
S_SEQ = stepwiselm(x, SEQ, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
S_SR = stepwiselm(x, SR, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 

save('S_ID.mat')
%%

load('neural_data.mat')
group_s(237,:) = [];

group_f(237,:) = [];
J = [group_s, group_f];
[Z, mean_x_train, standard_deviation_x_train] = zscore(J); 
        Z(isinf(Z)) = [];
        Z(isnan(Z)) = [];

        [COEFF, SCORE, ~, ~, EXPLAINED, ~] = pca(Z);
         x = SCORE;

J_EF = stepwiselm(x, EF, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
J_E = stepwiselm(x, E, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
J_L = stepwiselm(x, L, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
J_SEQ = stepwiselm(x, SEQ, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 
J_SR = stepwiselm(x, SR, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 1); 

save('J_ID.mat')
