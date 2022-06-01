clear
tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');

nexttile

n = 1;
fname = sprintf('/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/mdl_S_FAC%d.mat', n);
load(fname)
mdl = S_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[S_EF, p(1,n)] = BBC_CV(o, f, i);
%%

fname = sprintf('mdl_F_FAC%d.mat', n);
load(fname)
mdl = F_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[F_EF, p(2,n)] = BBC_CV(o, f, i);


fname = sprintf('mdl_J_FAC%d.mat', n);
load(fname)
mdl = J_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[J_EF, p(3,n)] = BBC_CV(o, f, i);


R2 = [S_EF(:) F_EF(:) J_EF(:)];

%
colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250]; 
boxplot(R2,'Colors',colors)
title('Executive Fuction')
ylabel("Root Mean Squared Error")

%%
% hLegend = legend(findall(gca,'Tag','Box'), {'Combined Connectivity','Functional Connectivity','Structural Connectivity'});
nexttile

n = 2;
fname = sprintf('mdl_S_FAC%d.mat', n);
load(fname)
mdl = S_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[S_SR, p(1,n)] = BBC_CV(o, f, i);


fname = sprintf('mdl_F_FAC%d.mat', n);
load(fname)
mdl = F_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[F_SR, p(2,n)] = BBC_CV(o, f, i);


fname = sprintf('mdl_J_FAC%d.mat', n);
load(fname)
mdl = J_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[J_SR, p(3,n)] = BBC_CV(o, f, i);


R2 = [S_SR(:) F_SR(:) J_SR(:)];
mean(R2)
colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250]; 

boxplot(R2,'Colors',colors)
title('Self-regulation')

%%
nexttile
%
n = 3;
fname = sprintf('mdl_S_FAC%d.mat', n);
load(fname)
mdl = S_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[S_L, p(1,n)] = BBC_CV(o, f, i);


%
fname = sprintf('mdl_F_FAC%d.mat', n);
load(fname)
mdl = F_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[F_L, p(2,n)] = BBC_CV(o, f, i);

%
fname = sprintf('mdl_J_FAC%d.mat', n);
load(fname)
mdl = J_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[J_L, p(3,n)] = BBC_CV(o, f, i);

%% significance testing SC vs FC vs CC

R2 = [S_L(:) F_L(:) J_SR(:)];
[P,H,STATS] = ranksum(Scss(:),Jcss(:)) 
%%
mean(R2)
std(R2)

colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250]; 

boxplot(R2,'Colors',colors)
hold on
yt = get(gca, 'YTick');
axis([xlim    0.8  max(yt)*1.6])
xt = get(gca, 'XTick');
%plot(xt([1 2]), [1 1]*max(yt)*1.1, '-k',  mean(xt([1 2])), max(yt)*1.15, '*k')

% plot(xt([1 3]), [1 1]*max(yt)*1.4, '-k',  mean(xt([1 3]))-0.03, max(yt)*1.45, '*k')
plot(xt([1 3]), [1 1]*max(yt)*1.4, '-k',  mean(xt([1 3]))+0.03, max(yt)*1.45, '*k')

hold off

title('Language')

%%
nexttile

n = 4;
fname = sprintf('mdl_S_FAC%d.mat', n);
load(fname)
mdl = S_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[Scss, p(1,n)] = BBC_CV(o, f, i);



fname = sprintf('mdl_F_FAC%d.mat', n);
load(fname)
mdl = F_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[Fcss, p(2,n)] = BBC_CV(o, f, i);


fname = sprintf('mdl_J_FAC%d.mat', n);
load(fname)
mdl = J_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[Jcss, p(3,n)] = BBC_CV(o, f, i);


R2 = [Scss(:) Fcss(:) Jcss(:)];
mean(R2)
colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250]; 

boxplot(R2,'Colors',colors)
title('Encoding')

%%
nexttile

n = 5;
fname = sprintf('mdl_S_FAC%d.mat', n);
load(fname)
mdl = S_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[Scss, p(1,n)] = BBC_CV(o, f, i);



fname = sprintf('mdl_F_FAC%d.mat', n);
load(fname)
mdl = F_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[Fcss, p(2,n)] = BBC_CV(o, f, i);


fname = sprintf('mdl_J_FAC%d.mat', n);
load(fname)
mdl = J_cv_mdl;
o = mdl.results.y.test.observed;
f = mdl.results.y.test.fitted;
i = mdl.results.y.test.indices;

[Jcss, p(3,n)] = BBC_CV(o, f, i);

R2 = [Scss(:) Fcss(:) Jcss(:)];
mean(R2)
colors = [0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250]; 

boxplot(R2,'Colors',colors)
title('Sequence Processing')
%%

%// Get all of the box plot objects
boxes = findobj(gca, 'Tag', 'Box');
legend(boxes([end 2 1]), 'Structural Connectivity', 'Functional Connectivity', 'Combined Connectivity','location', 'northeastoutside')
% %%
% hLegend = legend(findall(gca,'Tag','Box'), {'Combined Connectivity','Functional Connectivity','Structural Connectivity'}, 'location', 'northeastoutside');
% In 2015a this is blue, red, yellow
%% FDR correction of p-value

[h, crit_p, adj_ci_cvrg, adj_p]=fdr_bh(p,0.05)