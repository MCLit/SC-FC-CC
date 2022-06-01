%% generate critical values

disp('preparing environment')
% prepare the workspace
clear
n_perm = 5000; % number of permutations
alpha_level = 0.05; % out desired probability by chance

load('S_ID.mat', 'S_SEQ', 'group_s') % variables: SWR model, SC data prior to standardisation and PCA
cog = 5;% names of the output files
fname_mat = sprintf('testS%d_b.mat', cog); % output of permutations
fname_csv1 =  sprintf('S%d.csv', cog); % output of masking

fname_csvp =  sprintf('S%dp.csv', cog); % output in 7-network space
fname_csvn =  sprintf('S%dn.csv', cog);

mdl = S_SEQ;
Y = table2array(mdl.Variables(:,end)); % response variable

% standardise scores
[Z,MU,SIGMA] = zscore(group_s); 
Z(isinf(Z)) = 0; Z(isnan(Z)) = 0;

[COEFF, SCORE, ~, ~, ~, ~] = pca(Z);

PREDS = mdl.Formula.PredictorNames;
PREDS = str2double(extractAfter(PREDS, "x"));
COEFF = COEFF(:,PREDS); % PCA coefficients that have been selected by SWR

% project model betas to winning components - i.e betas in pca coefficient space
b = mdl.Coefficients.Estimate; % model betas
b_constant = b(1); b_rest = b(2:end); 

b_original_space = (COEFF*b_rest);
b_original_space = b_original_space./SIGMA';
mdl_pca = [b_constant - MU*b_original_space; b_original_space]; % this is the model in space of connectivity, and we will be testing which of its values are not random
mdl_pca(isnan(mdl_pca)|isinf(mdl_pca)) = 0;
mdl_pca = mdl_pca';

% PCA transform the X data, these are the predictors
X = group_s;
X = bsxfun(@minus,X,MU);
X = bsxfun(@rdivide,X,SIGMA);
X(isnan(X)) = 0; X(isinf(X)) = 0;

X = X*COEFF;

% build a null distribution of beta values in connectome space

null_dist_mlds = zeros(n_perm,length(mdl_pca)); 
disp('generating null disctribution of betas')

for i = 1:n_perm
    % disp(i) % for tracking if desired
    % suffle Y
    y_rand = Y(randperm(length(Y))); 
    
    % fit model
    perm_mdl = fitlm(X, y_rand); 
    perm_b = perm_mdl.Coefficients.Estimate;
    % now project these betas back in conn space
    perm_constant = perm_b(1); perm_b_rest = perm_b(2:end); 

    perm_b_original_space = (COEFF*perm_b_rest);
    perm_b_original_space = perm_b_original_space./SIGMA';
	
    perm_mdl_pca = [perm_constant - MU*perm_b_original_space; perm_b_original_space]; 
    
    perm_mdl_pca(isnan(perm_mdl_pca)|isinf(perm_mdl_pca)) = 0; perm_mdl_pca = perm_mdl_pca'; % tidying up
    
    null_dist_mlds(i,:) = perm_mdl_pca; % this is the output of our comparison points
end

disp('calculating critical values')

perm_conn = null_dist_mlds(:,2:end); % Throw away the intercept of all models of the permutated responses
obs_conn = mdl_pca(2:end); % Throw away the intercept of the model of the true observed (unpermuted) response

n_conn = size(perm_conn,2); % Extract number of variables/connections 
[mx_b,id] = max(abs(perm_conn),[],2); % Vector (distribution) of extreme values for two-tailed test

% Extract the sign of the extreme values and add them back
Ind = (1:n_perm)';
linear_indices = sub2ind([n_conn,n_perm],id,Ind);
conn_temp = perm_conn';
mx_b = mx_b.*sign(conn_temp(linear_indices));
clear conn_temp;

% p-values for 2-tailed test if desired
% pval = zeros(n_conn,1);
% id_positive = obs_conn > 0; % Identify observed positive slopes (positive betas)
% id_negative = obs_conn < 0; % Identify observed negative slopes (negative betas)
% pval(id_positive) = 2*mean(bsxfun(@gt,mx_b, obs_conn(id_positive))); % Compute p-values for the positive slopes in a single step
% pval(id_negative) = 2*mean(bsxfun(@lt,mx_b, obs_conn(id_negative))); % Compute p-values for the negative slopes in a single step

% Compute critical scores for specified alpha level for the two-tailed test
crit_b(1) = prctile(mx_b,100*alpha_level/2); 
crit_b(2) = prctile(mx_b,100-100*alpha_level/2); 
est_alpha = mean(mx_b>=crit_b(2)) + mean(mx_b<=crit_b(1)); 

save(fname_mat, 'mdl_pca', 'crit_b', 'est_alpha')
%% critical-value based masking and scaling of connections
disp('masking observed betas using critical values')

n_mdl_pca=mdl_pca;
n_crit = crit_b(1);

n_mdl_pca = n_mdl_pca<=n_crit;
sum(n_mdl_pca) % report of number of connections, for monitoring purposes only

p_mdl_pca=mdl_pca;
p_crit = crit_b(2);

p_mdl_pca = p_mdl_pca>=p_crit;
sum(p_mdl_pca) % report of number of connections

tmp_mdl_pca = mdl_pca;
pn_mdl_pca = p_mdl_pca+n_mdl_pca;

tmp_mdl_pca = rescale(tmp_mdl_pca, -1, 1); % after finding those connections that meet crit val, we rescale all of them prior to masking

tmp_mdl_pca(pn_mdl_pca~=1) = 0;
S = tmp_mdl_pca(2:38504);

% perform hauffe transformation

Y_predicted = mdl.Fitted;
Betas_Hauffe = Z.' * Y_predicted;
% scaled_Betas_Hauffe =  rescale(Betas_Hauffe, -1, 1)';

Betas_Hauffe = Betas_Hauffe';
Betas_Hauffe(pn_mdl_pca~=1) = 0;
Betas_Hauffe(1) = [];
% restore squarefrom

n = 278; M = zeros(n,n); l = tril(M,-1); ind = find(tril(ones(n,n),-1));
M(ind) = Betas_Hauffe'; K = M';

th_mdl_brainspace = M+K; % full matrix

csvwrite(fname_csv1, th_mdl_brainspace) % save result as csv file
%writematrix(out, fname_e, 'FileType', 'text', 'Delimiter','tab'); % save
%output as .edge file for Brainet if desired

% BrainNet_MapCfg('/Users/user/BrainMesh_Ch2withCerebellum.nv','test.node' ...
%      ,fname_e ...
%      , 'option.mat'...
%      , imgname); % if glassbrain is desired

disp('COMPLETE')