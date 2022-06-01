
function [obs_loss p CI] = BBC_CV(o, f, i)
% clear
% load('mdl_J_FAC5.mat')
% mdl = J_cv_mdl;
% o = mdl.results.y.test.observed;
% f = mdl.results.y.test.fitted;
% 
% i = mdl.results.y.test.indices;

% take data out of separate cells and place them back into a 
% repetition by subject matrix

for rep = 1:100
    for k = 1:5

        current_i = i{rep,k}; % i = indices of cv partition

        for val_subs = 1:length(i{rep,k}) % why was it sum?

            out_v(current_i == 1 ) = f{rep,k};
            out_f{rep,1} = out_v;
            out_v2(current_i == 1 ) = o{rep,k};
            out_o{rep,1} = out_v2;

        end % sub
    end % k
end % rep

FF = cell2mat(out_f)';
FO = cell2mat(out_o)'; % I have checked that indeed aaaaaaall the columns of observed variable are the same

FF = mean(FF,2); FO = FO(:,1);

% % creating indices 
% s = [1:249]; % indices to sample
% n_boot_reps = 1000; 
% [~,bootsam] = bootstrp(n_boot_reps, [], s);

k = 249;
B = 10000;
subs = 1:249;

for b = 1:B
    % Alrogithm 5 from https://link.springer.com/article/10.1007/s10994-018-5714-4
    % line 4:
    idx_b = randi(249,[249 1]); % randomly sampling subject indexes with replacement
    preds_b = FF(idx_b, :); % bootstrapped sample
    obs_b = FO(idx_b, :);
    % line 5
%     idx_not_b = ismember(subs, idx_b); % sample not selected by the bootstrap
%     preds_not_b = FF(~idx_not_b,:);
%     obs_not_b = FO(~idx_not_b, :);
    
    % line 7
    % if we were doing configuration selection we would use F_css, but we
    % are bootstrap sampling to overcome CV bias instead, so F_css is still
    % used
    obs_loss(b) = est_loss(obs_b(:),preds_b(:));
    % line 9
    %F_L(b) = est_loss(obs_not_b(:),preds_not_b(:)); %
     
end

s = sort(obs_loss );

ci_L = s(250);
ci_U = s(9750);
CI = [ci_L ci_U];

p = BBC_CV_sig(FF, FO);

function CD = est_loss(y_test,ests)
    % comment out the undesired metrics  below
    
    
%     coef of determination
%    SStot = sum((y_test - mean(y_test)).^2);
%     SSres = sum((y_test - ests).^2);
%     CD = 1 - SSres./SStot;
%     % pearson's correlation
      %CD = corr(y_test, ests);
%     % root mean squared error
     CD = sqrt(mean((y_test - ests).^2));
%     
%     % output:
%     out = CD;
end
end