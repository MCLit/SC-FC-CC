%% selecting training data
clear
load('raw_streamlines.mat', 'subs')
cog = readtable('/Users/user/Dropbox (The University of Manchester)/data/behavioural/600+_reduced2.csv');

all_HCP_subs = table2array(cog(:,2)); % subject IDs - whole dataset

beh = table2array(cog(:,[9:21])); % cognitive tests we are analysing atm
subs = cell2mat(subs); subs = str2num(subs); subs(237,:) = []; % subject 237 not part of the sample

% initially, we will do PCA on 433 subjects, then apply the solution to 249 subjects, this avoids data leakage
[tf,idx] = ismember(subs,all_HCP_subs);
beh(idx,:) = [];

% finding a number of components that is most stable with resampling
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
    end
end

desired_count_components = mode(component_count, 'all'); % the most stable number of components that have eigenvalue =>1
u = unique(component_count);
each_component_count_frequency = [u,histc(component_count(:),u)]; % frequency of other component numbers

%% pca by hand, varimax rotation perfectly corresponds to SPSS outputs, rotation works
% partly code from: https://stats.stackexchange.com/questions/171632/how-to-obtain-the-same-varimax-rotated-pca-results-in-matlab-and-spss

[Z, mean_z, standard_deviation_z] = zscore(beh); 
[V,D] = eig(corr(Z));

% Sorting the eigenvectors/eigenvalues
[~, ind] = sort(diag(D), 'descend');
D = D(ind, ind);
V = V(:, ind);

% Computing explained variance
for i = 1:13
Explained(i) = (D(i,i)/sum(D,'all'))*100;
end

% Keeping only the first five (non-zero ones)
D = D(1:5,1:5);
V = V(:,1:5);

% Computing loadings
L = V*sqrt(D);

% Rotating loadings - needed for illustration
L_rotated = rotatefactors(L);

save('cognitive_solution.mat')
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
title('Component 1')

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])

plots=get(gca, 'Children');

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1]) 

% box off % removes box but not on the left hand size
% set(gca,'XColor','none')
% b = barh(X,Y, 'EdgeColor','none');
% b(1).FaceColor = '#0072BD';
% title('Factor 1')
% 
% set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13)
% set(gca,'TickLength',[0 0])
% set(gca,'XTick', [-1 -.5 .5 1])
% set(gca,'TickLength',[0 0])

Y = [L_rotated(:, 2)];

nexttile
b = barh(X,Y, 'EdgeColor','none');
b = b([1,1]);
title('Component 2')
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
title('Component 3')
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
title('Component 4')
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
title('Component 5')
b(1).FaceColor = '#845ec2';

set(gca, 'YGrid', 'off', 'XGrid', 'on', 'FontSize', 13) 
set(gca,'TickLength',[0 0])
set(gca,'Ytick',[])

set(gca,'XTick', [-1 -.5 0 .5 1])
set(gca,'TickLength',[0 0])
xlim([-1 1])

%% PCA with MatLab toolbox
[coeff,score,latent,tsquared,explained,mu] = pca(Z);
coeff = coeff(:, 1:5); % grabbing the most stable number of components, also eigenvalue =>1

%% apply pca to 200 subjects we are analysing

train_beh = table2array(cog(idx,[5])); % test sample

Y = train_beh(1:200,:);
% pca transformation
                Y = bsxfun(@minus,Y,mean_z);
				Y = bsxfun(@rdivide,Y,standard_deviation_z); 
				Y = Y*coeff; 
% pca transformation
y = test_beh(201:249,:);
y = bsxfun(@minus,y,mean_z);
        y = bsxfun(@rdivide,y,standard_deviation_z);
        y = y*coeff;

save('cognitive_data.mat', 'Y' , 'y')
