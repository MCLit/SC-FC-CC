% note that here de-normalization of beta values in connectome was not conducted, because structure and function have different scales
% for unimodal data, users may wish to replace line 28 script in line 3 and 4, and then remove % from line 60:
% >> b_original_space = b_original_space./solution.std';
% >> mdl_pca = [b_constant - solution.mus*b_original_space; b_original_space]; % this is the model in space of connectivity, 

clear
n_perm = 10000; % number of permutations
alpha_level = 0.05; % out desired probability by chance

% load winning cross-validation model
load('J_FAC1.mat', 'J_solution', 'J_mdl') % variables: structure with PCA transformation parameters, 200 subjects' regression model
solution = J_solution; mdl = J_mdl;

% load the input data 
load('mdl_J_FAC1.mat', 'Y', 'J') % Y is the cognitive factor scores, S is each subject's connectome prior to PCA
X = J;
fname = 'J1_b.mat';
fname_e = 'J1.edge';
fname_c = 'J1.csv';

% project model betas to winning components - i.e betas in pca coefficient space
b = mdl.Coefficients.Estimate; % model betas
b_constant = b(1); b_rest = b(2:end); 
PCA_coeff = solution.coeff; % PCA coefficients selected during crossvalidation

b_original_space = (PCA_coeff*b_rest);

mdl_pca = [b_constant; b_original_space]; % this is the model in space of connectivity, 
%                                                                           and we will be testing which of its values are not random
mdl_pca(isnan(mdl_pca)|isinf(mdl_pca)) = 0;
mdl_pca = mdl_pca';

% PCA transform the X data 

mu = solution.mus; st_dev = solution.std;

X = bsxfun(@minus,X,mu);
X = bsxfun(@rdivide,X,st_dev);
X(isnan(X)) = 0; X(isinf(X)) = 0;

X = X*PCA_coeff;

% build a null distribution of beta values in connectome space

null_dist_mlds = zeros(n_perm,length(mdl_pca)); 

for i = 1:n_perm
    disp(i)
    % suffle Y
    y_rand = Y(randperm(length(Y))); 
    
    perm_mdl = fitlm(X, y_rand); 
    perm_b = perm_mdl.Coefficients.Estimate;
%     perm_b(:, i) = perm_mdl.Coefficients.Estimate;
    
    % now project these betas back in conn space
    perm_constant = perm_b(1); perm_b_rest = perm_b(2:end); 

    perm_b_original_space = (PCA_coeff*perm_b_rest);
%     perm_b_original_space = perm_b_original_space./solution.std';
	

    perm_mdl_pca = [perm_constant ; perm_b_original_space]; % this is the model in space of connectivity, 
%                                                                           and we will be testing which of its values are not random
    perm_mdl_pca(isnan(perm_mdl_pca)|isinf(perm_mdl_pca)) = 0; perm_mdl_pca = perm_mdl_pca'; % tidying up
    null_dist_mlds(i,:) = perm_mdl_pca; % this is the output of our comparison points
	
end


perm_conn = null_dist_mlds(:,2:end); % Through away the intercept of all models of the permutated responses
obs_conn = mdl_pca(2:end); % Through away the intercept of the model of the true observed (unpermuted) response

n_conn = size(perm_conn,2); % Extract number of variables/connections 
[mx_b,id] = max(abs(perm_conn),[],2); % Vector (distribution) of extreme values for two-tailed test

% Extract the sign of the extreme values and add them back
Ind = (1:n_perm)';
linear_indices = sub2ind([n_conn,n_perm],id,Ind);
conn_temp = perm_conn';

mx_b = mx_b.*sign(conn_temp(linear_indices));
clear conn_temp;


% Compute p-values for 2-tailed test
pval = zeros(n_conn,1);
id_positive = obs_conn > 0; % Identify observed positive slopes (positive betas)
id_negative = obs_conn < 0; % Identify observed negative slopes (negative betas)
pval(id_positive) = 2*mean(bsxfun(@gt,mx_b, obs_conn(id_positive))); % Compute p-values for the positive slopes in a single step
pval(id_negative) = 2*mean(bsxfun(@lt,mx_b, obs_conn(id_negative))); % Compute p-values for the negative slopes in a single step

% Compute critical scores for specified alpha level for the two-tailed test
crit_b(1) = prctile(mx_b,100*alpha_level/2);
crit_b(2) = prctile(mx_b,100-100*alpha_level/2); 
est_alpha = mean(mx_b>=crit_b(2)) + mean(mx_b<=crit_b(1)); 

    fprintf('Desired family-wise alpha level: %f\n',alpha_level);
    fprintf('Estimated actual family-wise alpha level for returned values of crit_corr: %f\n',est_alpha);

save(fname, 'mdl_pca', 'crit_b', 'est_alpha', 'pval')
