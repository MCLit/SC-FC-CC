
function cv_mdl = stepwise_cv(y, x, confounds)

nReps = 100; % number of cross validation iterations
k = 5; % number of cross validation folds
nSubs = length(y); % number of subjects
all_error = zeros(nReps, 1);
all_mdl = cell(nReps,1);
all_pca_solution = cell(nReps,2);

for i = 1:nReps
    disp(i)
    
    indices = crossvalind('Kfold', nSubs, k); % on each repetition creates a new index,

    for j = 1:k % for each cross validation
        
        % divide dataset
        test = (indices == j); 
        train = ~test;
        
        x_train = x(train,:);
        y_train = y(train,:);
        confounds_train = confounds(train,:);
        
        x_test = x(test,:);
        y_test = y(test,:);
        confounds_test = confounds(test,:);

        % regress individual differences from train sample
        confounds_mdl = fitlm(confounds_train, y_train); 
        y_train = table2array(confounds_mdl.Residuals(:,1)); % response data after consideration of individual differences 
        confounds_b = confounds_mdl.Coefficients.Estimate; % model betas
        
        % regress the individual differences out of y_test
        confounds_ests = [ones(size(confounds_test,1),1) confounds_test]*confounds_b;
        y_test = y_test - confounds_ests;
        
        % processing of neural data - normalise it
        [Z, mean_x_train, standard_deviation_x_train] = zscore(x_train);
        % in the presence of 0-connections obtained due to thresholding
         x_test (isinf(Z)) =[];
         x_test (isnan(Z)) =[];
         Z(isinf(Z)) =[];
         Z(isnan(Z)) =[];
        
        % PCA orthogonalisation
        [COEFF, SCORE, ~, ~, EXPLAINED, ~] = pca(Z);
        Z = SCORE;
        
        % fit stepwise regression
        mdl_train = stepwiselm(Z, y_train, 'constant', 'upper', 'linear', 'criterion', 'bic', 'Verbose', 0); 
        
        % report the statistics of training fold
        results.stats.train.R2(i,j) = mdl_train.Rsquared.Ordinary;
        results.stats.train.BIC(i,j) = mdl_train.ModelCriterion.BIC;
%        results.stats.train.RMSE(i,j) = mdl_train.RMSE;
        
        results.y.train.fitted{i,j} = mdl_train.Fitted;
        results.y.train.observed{i,j} = y_train;
        results.y.train.indices{i,j} = train;

        % select the coeffs from stepwise regression 
        PREDS = mdl_train.Formula.PredictorNames;
        PREDS = str2double(extractAfter(PREDS, "x"));
        COEF_SELECTED = COEFF(:,PREDS); % select factor of interest
        
        % save them if desired
%         results.stats.train.pca_coefs{i,j} = COEFF;
%         results.stats.train.mdl_predictorNames{i,j} = PREDS;
%         results.stats.train.mdl_betas{i,j} = mdl_train.Coefficients.Estimate;
        
        if isempty(COEF_SELECTED) % if we had an empty model with no predictors, we skip to the next loop
            continue
        end
	
        % apply scaling of X data from training to test sample
        x_test = bsxfun(@minus,x_test,mean_x_train); 
        x_test = bsxfun(@rdivide,x_test,standard_deviation_x_train); 
        
        % apply model to transformed test
        b = mdl_train.Coefficients.Estimate;
        b_constant = b(1); b_rest = b(2:end);
        
        % project betas in original space
        b_original_space = COEF_SELECTED*b_rest;
        
        % processing for nan and infinity values associated with
        % connectivity
        s = sum(x_test); % checking for nans and infs
        n = isnan(s);
        b_original_space(n == 1) = []; % dropping these betas, as they are just not available in the test set

        x_test(:,n == 1) = []; 
        
        s = sum(x_test); % checking for nans and infs
        f = isinf(s);

        b_original_space(f == 1) = []; % dropping these betas, as they are just not available in the test set

        x_test(:,f == 1) = []; 
        
        % producing out of sample estimates
        b_original_space = [b_constant; b_original_space];
        ests = [ones(size(x_test,1),1) x_test]*b_original_space;
        
        % saving all estimates and true responses
        results.y.test.fitted{i,j} = ests;
        results.y.test.observed{i,j} = y_test;
        results.y.test.indices{i,j} = test;
        % calculating estimates of prediction error
        RMSE = sqrt(mean((y_test - ests).^2));        
        SStot = sum((y_test - mean(y_test)).^2);
        SSres = sum((y_test - ests).^2);
        CoD = 1 - SSres./SStot;
        c = corr(y_test, ests);
        
        % saving estimates of prediction error
        results.y.test.RMSE(i,j) = RMSE;
        results.y.test.CoD(i,j) = CoD;
        results.y.test.Pearsons(i,j) = c;
        
    end % 5-fold end
end % iteration end

cv_mdl.results = results;
end % function end
