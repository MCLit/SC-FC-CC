function p = BBC_CV_sig(obs, predicted) % I deleted the input variable obs_loss, which will be computed inside now

 

obs_loss = est_loss(obs,predicted(:)); % Computes the loss on the un-randomised data.

predictedv = predicted(:); % This is just you don't have to do this vectorisation 10000 times inside the loop, it will save time.

 

for b = 1:10000

    rand_obs = obs(randperm(length(obs)));

    rand_loss(b) = est_loss(rand_obs,predictedv);

end

 

p = (sum(rand_loss>=obs_loss))/length(rand_loss(:));

 
end

 

function out = est_loss(y_test,ests)    

%%% coef of determination

SStot = sum((y_test - mean(y_test)).^2);

SSres = sum((y_test - ests).^2);

out = 1 - SSres./SStot;

%%% pearson's correlation
% out = corr(y_test, ests);

%%% root mean squared error
% out = sqrt(mean((y_test - ests).^2));


end 
