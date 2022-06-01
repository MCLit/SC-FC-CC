clear
for cog = 1:5 % names of the output files

fname_csv1 =  sprintf('S%d.csv', cog); % output of masking
SC_th_mdl_brainspace = load(fname_csv1);
fname_csvp =  sprintf('S%dp.csv', cog); % output in 7-network space
fname_csvn =  sprintf('S%dn.csv', cog);
load('/Users/user/yeo7nets/labels_7RSN.mat') % this is the file with each Shen region having an RSN name
for i = 1:length(out) % some cells are empty because RSNs defined by Yeo are cortical
    if isempty(out{i,1})
        out{i,1} = ["None", "(100 %)"];
    end
end

for w = 1:278 % the Shen parcels may overlap with several regions, so we select the region that maximally overlaps with this
    current = out(w);
    for l = length(current)
        d = current{l};
        for n = 1:length(d)
            
        if floor(n/2)==n/2 % remove the parantheses from the number
        % code for even columns
            p = erase(d(n), '(');
            
            
            p = erase(p, ' %)');
            perc(n,1) = str2double(p);
        else  % this is the label
        % code for odd columns
            label(n,1) = d(n);
        end
        end
        % for current ROI find maximum overlap network
        [U, I] = max(perc);
    end
    new_out(w,:,:) = [label(I-1); perc(I)];
end

RSN = new_out;

% now to ensure that we include subcortical and cerebellum areas are also
% described
%
load('/Users/user/universal/atlas/RSN labels/AAL_single_dominant.mat') %% AAL3 atlas tells us which regions are categorised as cerbellar, others we can call subcortical
c_rsn = [RSN, AAL_single(:,1)];
for i = 1:278
    c = contains(c_rsn(i,1),'None');
    r = startsWith(c_rsn(i,3),'Cereb');
    if c == 1 && r ==1 
    c_rsn(i,1) = 'cerebellum';
    elseif c == 1
    c_rsn(i,1) = 'subcortical';
end
end
c_rsn = c_rsn(:,1); % only keeping the name, we do not care for percentage

% we now have to load varimax-rotated PCA solution
M = SC_th_mdl_brainspace; % BUT USE ACTUAL PROJECTIONS.

n = 278;

    F = M;
    
    pos = F;
    neg = F;
    
    neg(neg>0) = 0; % positive loadings = 0
    pos(pos<0) = 0; % negative loadings = 0
    
    neg = abs(neg); % flip negative loadings for thresholding

 % either analyse positive coeffs separately from negative
 % or analyse all togther and positive PCA loadings together or separately
% out_pos = out_pos/5;
% out_neg = out_neg/5;
ce = cellstr(c_rsn); % celll representation of complete rsn mapping of Shen atlas

network_categories = unique(c_rsn); 

n = length(network_categories);

negative_mat_value = zeros(n,n);
positive_mat_value = zeros(n,n);
negative_mat_count= zeros(n,n);
positive_mat_count= zeros(n,n);
for j = 1:278
    for k = 1:278 % rotate over rows and columns (i.e. roi connections)
        
        for l = 1:n % rotate over rows and columns (i.e. rsn connections)
            
            l_label = network_categories(l); % grab currently studied region
            
            for c = 1:n
                c_label = network_categories(c);
                
                if ce(j) == l_label && ce(k) == c_label  % if roi's atlas row label matches rsn connection label
                    positive_mat_value(l,c) = positive_mat_value(l,c) + pos(j,k);
                    if pos(j,k) ~= 0
                        positive_mat_count(l,c) = positive_mat_count(l,c) + 1; % pos_count is for ALL 5 components we put in
                    end
                    negative_mat_value(l,c) = negative_mat_value(l,c) + neg(j,k);
                    if neg(j,k) ~= 0
                        
                        negative_mat_count(l,c) = negative_mat_count(l,c) + 1; % pos_count is for ALL 5 components we put in
                    end
                end
            end
        end
    end
end

positive_mat_mean = positive_mat_value./positive_mat_count;
negative_mat_mean = negative_mat_value./negative_mat_count;


% grab lower diagonal matrix
data = positive_mat_mean;
    mask = tril(true(size(data)),0);
    data = data(mask);
data(isnan(data)) = 0;
% raescale it
data = rescale(data, 0, 1);
% project it back in the space

M = zeros(n,n); l = tril(M,0); ind = find(tril(ones(n,n)));
M(ind) = data; K = M';

K(1:1+size(K,1):end) = 0;
positive_mat_mean = M+K;

% grab lower diagonal matrix
data = negative_mat_mean;
mask = tril(true(size(data)),0);
data = data(mask);
data(isnan(data)) = 0;
% raescale it
data = rescale(data, 0, 1);
% project it back in the space

M = zeros(n,n); l = tril(M,0); ind = find(tril(ones(n,n)));
M(ind) = data; K = M';

K(1:1+size(K,1):end) = 0;
negative_mat_mean = M+K;

csvwrite(fname_csvp, positive_mat_mean)
csvwrite(fname_csvn, negative_mat_mean)
end
