% PCA of behavioural data
clear
load('neural_data.mat', 'subs')
cog = readtable('/Users/user/Dropbox (The University of Manchester)/data/behavioural/600+_reduced2.csv');

all_HCP_subs = table2array(cog(:,2)); % subject IDs - whole dataset

beh = table2array(cog(:,[9:21])); % cognitive tests we are analysing atm
subs = cell2mat(subs); subs = str2num(subs); subs(237,:) = []; % subject 237 not part of the sample

% initially, we will do PCA on 433 subjects, then apply the solution to 249 subjects, this avoids data leakage
[tf,idx] = ismember(subs,all_HCP_subs);
beh(idx,:) = [];
%% finding a number of components that is most stable with resampling
k = 10; % number of cross validation folds

for i = 1:1000
    indices = crossvalind('Kfold', 433, k); % on each repetition creates a new index,
    for j = 1:k % for each cross validation

        test = (indices ~= j);
        current_beh = beh(test, :); % current behavioural sample
        
        X = normalize(current_beh);
        [V,D] = eig(corr(X));
        
        %// Sorting the eigenvectors/eigenvalues
        [~, ind] = sort(diag(D), 'descend');
        D = D(ind, ind);
        V = V(:, ind);
        l = sum(D>=1);
        l = sum(l, 'all');
        component_count(i, j) = l(1);
        
        for h = 1:13
            explained_cv(h) = (D(h,h)/sum(D,'all'))*100;
            
        end
        Explained_cv(i, j) = sum(explained_cv(1:l));
    end
end
%%
desired_count_components = mode(component_count, 'all'); % the most stable number of components that have eigenvalue =>1
u = unique(component_count);
each_component_count_frequency = [u,histc(component_count(:),u)]; % frequency of other component numbers

e = Explained_cv(:);

mean_explained_cv = mean(e);
sd_explained_cv = std(e);
%% SVD PCA
[Z, mean_z, standard_deviation_z] = zscore(beh); 
%[V,D] = eig(corr(Z));
[U,S,V] = svd(Z,'econ'); % Singular value decomposition (more efficient and stable than using eig)
D = S.^2./(size(Z,1)-1); 

% Computing explained variance
for i = 1:13
Explained(i) = (D(i,i)/sum(D,'all'))*100;
end

% Keeping only the first five
S = S(1:5,1:5); V = V(:,1:5); D = D(1:5,1:5);

% Computing loadings
L = V*sqrt(D); % Loadings according to SPSS. This will produced standardised scores bellow
% L = V*S; % Loadings based on singular values.

% Rotating PCA coefficients
L_rotated = rotatefactors(L);
% Rotated standardised scores
B = pinv(L_rotated)'; % Transformation matrix to be applied to new data in order to obtain rotated scores
U_rotated = Z*B; % Rotated scores are standardised, i.e. unit variace 

save('cognitive_solution.mat')

%% optional: eigenvalue based PCA
% % this section produces the same loadings as above
% % but signs change and directly correspond to outputs of SPSS
% 
% [Z, mean_z, standard_deviation_z] = zscore(beh); 
% [V,D] = eig(corr(Z));
% % [U,S,V] = svd(Z,'econ'); % Singular value decomposition (more efficient and stable than using eig)
% % [left_singular_vactors, singulat_vals, Right singular vectors]
% 
% % D = S.^2./(size(Z,1)-1); 
% 
% % Computing explained variance
% for i = 1:13
% Explained(i) = (D(i,i)/sum(D,'all'))*100;
% end
% 
% % Keeping only the first five
% % S = S(1:5,1:5); 
% V = V(:,1:5); D = D(1:5,1:5);
% 
% % Computing loadings
% L = V*sqrt(D); % Loadings according to SPSS. This will produced standardised scores bellow
% % L = V*S; % Loadings based on singular values.
% 
% % Rotating PCA coefficients
% L_rotated = rotatefactors(L);
% % Rotated standardised scores
% B = pinv(L_rotated)'; % Transformation matrix to be applied to new data in order to obtain rotated scores
% U_rotated = Z*B; % Rotated scores are standardised, i.e. unit variace 

%% illustrating the varimax rotated solution in a heatmap

% hex = ['#066a9c';'#74c5ed';'#ffffff';]; % blue
% hex = ['#ffffff';'#ed7474';'#9c0606']; % blue
% hex = ['#ede374';'#d1c434';'#6e660c';]; % yellow
% hex = ['#74ede9';'#34c7d1';'#0c696e';]; % green
% hex = ['#c174ed';'#9034d1';'#420c6e';]; % green

hex = [ '#2166ac';'#f7f7f7'; '#b2182b']; % blue to red
vec = [100; 50; 0];
raw = sscanf(hex','#%2x%2x%2x',[3,size(hex,1)]).' / 255;
N = 128;
map = interp1(vec,raw,linspace(100,0,N),'pchip');

labels = {'Episodic Memory (Picture Sequence Memory)' 'Executive Function/Cognitive Flexibility (Dimensional Change Card Sort)' ...
    'Executive Function/Inhibition (Flanker Task)' 'Fluid Intelligence (Penn Progressive Matrices)' ...
    'Language/Reading Decoding (Oral Reading Recognition)' 'Language/Vocabulary Comprehension (Picture Vocabulary)' ...
    'Processing Speed (Pattern Completion Processing Speed)' 'Self-regulation/Impulsivity (Delay Discounting - $200)' ...
    'Self-regulation/Impulsivity (Delay Discounting - $40k)' 'Spatial Orientation (Variable Short Penn Line Orientation Test)'...
    'Sustained Attention (Short Penn Continuous Performance Test)' 'Verbal Episodic Memory (Penn Word Memory Test)' ...
    'Working Memory (List Sorting)'};

heatmap(L_rotated, 'YData',labels,'Colormap',map)
ax = gca; axp = struct(ax); axp.Axes.XAxisLocation = 'top';
caxis([-1, 1]);

%% illustrating the varimax rotated solution in a series of bar graphs
figure(2)

Y = [L_rotated(:, 1)];
X = categorical({'Picture Sequence Memory' 'Dimensional Change Card Sort' ...
    'Flanker Task' 'Penn Progressive Matrices' ...
    'Oral Reading Recognition' 'Picture Vocabulary' ...
    'Pattern Completion Processing Speed' 'Delay Discounting - $200' ...
    'Delay Discounting - $40k' 'Variable Short Penn Line Orientation'...
    'Short Penn Continuous Performance ' 'Penn Word Memory Test' ...
    'List Sorting'});
X = reordercats(X,{'Picture Sequence Memory' 'Dimensional Change Card Sort' ...
    'Flanker Task' 'Penn Progressive Matrices' ...
    'Oral Reading Recognition' 'Picture Vocabulary' ...
    'Pattern Completion Processing Speed' 'Delay Discounting - $200' ...
    'Delay Discounting - $40k' 'Variable Short Penn Line Orientation'...
    'Short Penn Continuous Performance ' 'Penn Word Memory Test' ...
    'List Sorting'});
round(Y, 2)
tiledlayout(1,5,'TileSpacing','Compact','Padding','Compact');
nexttile

b = barh(X, Y, 'EdgeColor','none');
b = b([1,1]);
b(1).FaceColor = '#4daf4a';
title('Executive Function')

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])

plots=get(gca, 'Children');

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1]) 

Y = [L_rotated(:, 2)];

nexttile
b = barh(X,Y, 'EdgeColor','none');
b = b([1,1]);
title('Self-regulation')
b(1).FaceColor = '#009fff';

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])
set(gca,'Ytick',[])

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1]) 

Y = [L_rotated(:, 3)];

nexttile
b = barh(X, Y, 'EdgeColor','none');
b = b([1,1]);
title('Language')
b(1).FaceColor = '#f97421';

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])
set(gca,'Ytick',[])

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1]) 

Y = [L_rotated(:, 4)];

nexttile
b = barh(X,Y, 'EdgeColor','none');
b = b([1,1]);
title('Encoding')
b(1).FaceColor = '#ff5373';

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])
set(gca,'Ytick',[])

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1]) 

Y = [L_rotated(:, 5)];

nexttile
b = barh(X, Y, 'EdgeColor','none');
b = b([1,1]);
title('Sequence Processing')
b(1).FaceColor = '#845ec2';

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])
set(gca,'Ytick',[])

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1])

%%


train_beh = table2array(cog(idx,[9:21])); % test sample

Yfull = train_beh(1:249,:);% Fill sample
% Centre and scale using mean and std of the 433 subjects
Yfull = bsxfun(@minus,Yfull,mean_z); % Centre
Yfull = bsxfun(@rdivide,Yfull,standard_deviation_z); % Scale 
Yfull = Yfull*B; % Apply transformation

% Split into CV dataset and hold-out dataset
Y = Yfull(1:200,:);
y = Yfull(201:249,:);

