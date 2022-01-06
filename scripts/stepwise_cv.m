    function [cv_min_error, cv_mdl, cv_pca_solution] = stepwise_cv(y, x)
% OUTPUT: the minimum error of test model, the corresponding training and test models, and
% the pca transformation - coefficients, x_test mean, and what connections
% were = 0 for entire dataset

nReps = 1000; % number of cross validation iterations
k = 10; % number of cross validation folds
nSubs = length(y); % number of subjects
all_error = zeros(nReps, 1);
all_mdl = cell(nReps,1);
all_pca_solution = cell(nReps,2);

for i = 1:nReps
    disp(i)
    indices = crossvalind('Kfold', nSubs, k); % on each repetition creates a new index,

    for j = 1:k % for each cross validation

        %%% divide dataset
        test = (indices == j); 
        train = ~test;

        x_train = x(train,:);
        y_train = y(train,:);

        x_test = x(test,:);
        y_test = y(test,:);
		[x_train, mean_x_train, standard_deviation_x_train] = zscore(x_train);
        x_train(isinf(x_train)) = 0; x_train(isnan(x_train)) = 0;

        [COEFF, SCORE, ~, ~, EXPLAINED, ~] = pca(x_train);

        %%% grab factors that account for 80% explained variance
        idx = find(cumsum(EXPLAINED)>=80,1);
        x_train = SCORE(:,[1:idx]);

        %%% perform stepwise regression
        mdl_train = stepwiselm(x_train, y_train, 'constant', 'upper', 'linear', 'criterion', 'aic', 'penter', -2, 'Verbose', 0); % Nelson: I forgot to discuss the choice of AIC = 2 for "penter". Think about justifying this choice. Also think about justifying why you are keeping the default AIC=0.01 for "premove" 
        
        %%% apply pca_coeffs to xtest (only have to use the coeffs selected
        %%% by stepwise regression)

            % select the coeffs from stepwise regression
            PREDS = mdl_train.Formula.PredictorNames;
            PREDS = str2double(extractAfter(PREDS, "x"));
            COEF_SELECTED = COEFF(:,PREDS); % select factor of interest

            if isempty(COEF_SELECTED) % if we had an empty model with no predictors, we skip to the next loop
                continue
            end

                x_test = bsxfun(@minus,x_test,mean_x_train);
				x_test = bsxfun(@rdivide,x_test,standard_deviation_x_train);
				x_test(isnan(x_test)) = 0; x_test(isinf(x_test)) = 0;
                
				x_test_transformed = x_test*COEF_SELECTED;

                % THIS SCRIPT ESTIMATES THE BETA VALUES OF THE MODEL

                b = mdl_train.Coefficients.Estimate;
                
                ests = [ones(size(x_test_transformed,1),1) x_test_transformed]*b;

				cv_error = sqrt(sum((y_test - ests).^2));
				
				err_10(1,j) = cv_error;
                % save each repertition's minimum error and respective model
                % and pca solution
				
                if j == 1 % on the first iteration we set minimum error 
                    min_error = cv_error; 
                    mdl{1} = mdl_train;
                    mdl{2} = ests;
                    pca_solution.coeff = COEF_SELECTED;
                    pca_solution.mus = mean_x_train;
                    pca_solution.std = standard_deviation_x_train;
                else % on next iterations check if that model has to be replaced
                     if cv_error < min_error % if the current error is smaller than on previous interation(s)
                        %                      then update the outputs
                        clear pca_solution
                        min_error = cv_error; 
                        mdl{1} = mdl_train;
                        mdl{2} = ests;
                        pca_solution.coeff = COEF_SELECTED;
                        pca_solution.mus = mean_x_train;
                        pca_solution.std = standard_deviation_x_train;
                     end % comparing error end
                end % if j == 1 end
    end % 10-fold end
    
    if i == 1 % on first repetition of k-fold crossvalidation
        cv_min_error = min_error;
        cv_mdl = mdl;
        cv_pca_solution = pca_solution;        
        cv_pca_solution.all_err(j,:) = err_10;
    else % on next repetitions
        if min_error < cv_min_error
        cv_min_error = min_error;
        cv_mdl = mdl;
        cv_pca_solution = pca_solution;
        cv_pca_solution.all_err(j,:) = err_10;
        end
    end % variable writing end
end % iteration end
end % function end
