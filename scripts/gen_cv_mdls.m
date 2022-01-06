clear;
% load and place essential information
load('mdl_J_FAC1.mat')
labels = J_cv_mdl{1,1}.PredictorNames;
labels{end+1, 1} = 'Exec';
coeffs = J_solution.coeff;
mu = J_solution.mus; st_dev = J_solution.std;

% transform data
J = bsxfun(@minus,J,mu);
J = bsxfun(@rdivide,J,st_dev);
J(isnan(J)) = 0; J(isinf(J)) = 0;

J_transformed = J*coeffs;
% fit linear model, this is the main model of the project
J_mdl = fitlm(J_transformed, Y, 'VarNames', labels);

% estimate Mean Absolute Error
Y_ests = J_mdl.Residuals.Raw;
J_err = mean(abs(Y - Y_ests));

%% perform out oj sample testing

% transform data
j = bsxfun(@minus,j,mu); 
j = bsxfun(@rdivide,j,st_dev);
j(isnan(j)) = 0; j(isinf(j)) = 0;

j_transformed = j*coeffs;

% fit model to out-of-sample dataset
b = J_mdl.Coefficients.Estimate; % obtain model beta values
ests = [ones(size(j_transformed,1),1) j_transformed]*b;

% test its prediction error as MAE
j_err = mean(abs(y - ests));

save('J_FAC1.mat', 'J_solution', 'J_cv_mdl', 'J_err', 'J_transformed' , 'J_mdl', 'j_transformed', 'ests', 'j_err')
