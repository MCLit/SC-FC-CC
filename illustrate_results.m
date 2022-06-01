clear
load('S_ID.mat')
load('F_ID.mat')
load('J_ID.mat')

% explained variance bar graph
Y = [ S_EF.Rsquared.Ordinary, F_EF.Rsquared.Ordinary,J_EF.Rsquared.Ordinary; ...
    S_SR.Rsquared.Ordinary, F_SR.Rsquared.Ordinary, J_SR.Rsquared.Ordinary;...
 S_L.Rsquared.Ordinary,F_L.Rsquared.Ordinary, J_L.Rsquared.Ordinary;...
 S_E.Rsquared.Ordinary,F_E.Rsquared.Ordinary, J_E.Rsquared.Ordinary;...
 S_SEQ.Rsquared.Ordinary, F_SEQ.Rsquared.Ordinary,J_SEQ.Rsquared.Ordinary];




% tiledlayout(2,1,'TileSpacing','Compact','Padding','Compact');
X = categorical({'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'});
X = reordercats(X,{'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'});


b = bar(Y);


str = {'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'};

hB=b;          % use a meaningful variable for a handle array...


hAx=gca;            % get a variable for the current axes handle
hAx.FontSize=11;
hAx.XTickLabel=str; % label the ticks

hT=[];              % placeholder for text object handles
for i=1:length(hB)  % iterate over number of bar objects
  hT=[hT text(hB(i).XData+hB(i).XOffset,hB(i).YData,num2str(hB(i).YData.','%.2f'), ...
                          'VerticalAlignment','bottom','horizontalalign','center',  'FontSize', 15)];
                      
end
legend( 'structural connectivity', 'functional connectivity','combined connectivity')
title('Explained variance', 'FontSize', 15) 
ylabel('Ordinary R-Squared', 'FontSize', 15)
h=gca; h.XAxis.TickLength = [0 0];
ylim([0 0.8])
%% absolute BIC bargraph

Y = [ S_EF.ModelCriterion.BIC, F_EF.ModelCriterion.BIC,J_EF.ModelCriterion.BIC; ...
    S_SR.ModelCriterion.BIC, F_SR.ModelCriterion.BIC, J_SR.ModelCriterion.BIC;...
 S_L.ModelCriterion.BIC,F_L.ModelCriterion.BIC, J_L.ModelCriterion.BIC;...
 S_E.ModelCriterion.BIC,F_E.ModelCriterion.BIC, J_E.ModelCriterion.BIC;...
 S_SEQ.ModelCriterion.BIC, F_SEQ.ModelCriterion.BIC,J_SEQ.ModelCriterion.BIC];


X = categorical({'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'});
X = reordercats(X,{'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'});

tiledlayout(1, 1, 'TileSpacing', 'compact', 'padding','none')
b = bar(Y);


str = {'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'};

hB=b;          % use a meaningful variable for a handle array...


hAx=gca;            % get a variable for the current axes handle
hAx.FontSize=11;
hAx.XTickLabel=str; % label the ticks

hT=[];              % placeholder for text object handles
for i=1:length(hB)  % iterate over number of bar objects
  hT=[hT text(hB(i).XData+hB(i).XOffset,hB(i).YData,num2str(hB(i).YData.','%.2f'), ...
                          'VerticalAlignment','bottom','horizontalalign','center',  'FontSize', 13)];
                      
end
% legend( 'structural', 'functional','joint')
title('Model Evidence', 'FontSize', 15) 
ylabel('BIC value', 'FontSize', 15)
h=gca; h.XAxis.TickLength = [0 0];
ylim([550 780])

legend( 'structural connectivity', 'functional connectivity','combined connectivity', 'Location','northeast')
%% below are illustrations for relative BIC values

S_EF.ModelCriterion.BIC-F_EF.ModelCriterion.BIC
S_SR.ModelCriterion.BIC - F_SR.ModelCriterion.BIC
S_L.ModelCriterion.BIC - F_L.ModelCriterion.BIC
S_E.ModelCriterion.BIC - F_E.ModelCriterion.BIC
S_SEQ.ModelCriterion.BIC -F_SEQ.ModelCriterion.BIC

%%
S_Exec = S_EF.ModelCriterion.BIC-J_EF.ModelCriterion.BIC;
F_Exec = F_EF.ModelCriterion.BIC-J_EF.ModelCriterion.BIC;
S_SR = S_SR.ModelCriterion.BIC - J_SR.ModelCriterion.BIC;
F_SR = F_SR.ModelCriterion.BIC- J_SR.ModelCriterion.BIC;
S_L = S_L.ModelCriterion.BIC - J_L.ModelCriterion.BIC;
F_L = F_L.ModelCriterion.BIC- J_L.ModelCriterion.BIC;
S_E = S_E.ModelCriterion.BIC - J_E.ModelCriterion.BIC;
F_E = F_E.ModelCriterion.BIC- J_E.ModelCriterion.BIC;
S_SEQ = S_SEQ.ModelCriterion.BIC -J_SEQ.ModelCriterion.BIC;
F_SEQ = F_SEQ.ModelCriterion.BIC - J_SEQ.ModelCriterion.BIC;


Y = [ S_Exec, F_Exec; ...
    S_SR, F_SR;...
 S_L,F_L;...
 S_E,F_E;...
 S_SEQ, F_SEQ];


X = categorical({'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'});
X = reordercats(X,{'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'});
figure(5)
b = bar(Y);


str = {'Executive function', 'Self-regulation', 'Language', 'Encoding', 'Sequence Processing'};

hB=b;          % use a meaningful variable for a handle array...


hAx=gca;            % get a variable for the current axes handle
hAx.FontSize=11;
hAx.XTickLabel=str; % label the ticks

hT=[];              % placeholder for text object handles
for i=1:length(hB)  % iterate over number of bar objects
  hT=[hT text(hB(i).XData+hB(i).XOffset,hB(i).YData,num2str(hB(i).YData.','%.2f'), ...
                          'VerticalAlignment','bottom','horizontalalign','center',  'FontSize', 15)];
                      
end
legend( 'structural connectivity', 'functional connectivity')
title('Model comparison with combined connectivity as reference', 'FontSize', 15) 
ylabel('BIC difference', 'FontSize', 15)
h=gca; h.XAxis.TickLength = [0 0];
ylim([-60 40])
