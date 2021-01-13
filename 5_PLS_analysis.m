
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%               RUN PLS on OMEGA data against demographics
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%% load data PSD data and prep for PLS

data=csvread("./output/subjects_source_PSD_ONESESSION.csv");
load("./output/demographics_full_data.mat");
% set parameters of data
k = 20469; % for PSD across all bands and sources 
Sub=158; % number of subjects
% prep x and y data
y=demo;
x=data(:,1:k-1);

%% load data AEC and prep for PLS

% data=csvread("./output/subjects_functional_connectivity_ONESESSION.csv"); % load data participants by connection matrix 
% load("./output/demographics_full_data.mat");
% % set parameters of data
% k =14078; % for AEC across all bands
% Sub=158; % number of subjects
% % prep x and y data
% y=demo;
% data=data(:,2:k-1);
% x=data(:,sum(data)~=Sub); % removing diagonal elemnets 

%% set parameters for PLS analys and RUN
% z score each matrix;
x=x-mean(x)./std(x);
y=y-mean(y)./std(y);

datamat{1}=x;
nsub{1}=Sub;

option.method = 3;
option.num_perm = 10000;
option.num_boot = 10000;
option.stacked_behavdata=y(:,2:5);

result = pls_analysis(datamat,nsub,1,option);

%% Plot Results 

figure;
bar(result.lvcorrs(:,1))
hold on
errorbar(1:4,result.lvcorrs(:,1), result.boot_result.llcorr_adj(:,1),result.boot_result.ulcorr_adj(:,1), 'k.','LineWidth', 2)
xticks([1:4])
xticklabels({'Clinical Status','Age','Gender','Handedness'})
set(findall(gcf,'-property','FontSize'),'FontSize',12)
ylabel("Demographic Scores")
figure;
bar(result.lvcorrs(:,2))
hold on
errorbar(1:4,result.lvcorrs(:,2), result.boot_result.llcorr_adj(:,2),result.boot_result.ulcorr_adj(:,2), 'k.','LineWidth', 2)
xticks([1:4])
xticklabels({'Clinical Status','Age','Gender','Handedness'})
set(findall(gcf,'-property','FontSize'),'FontSize',12)
ylabel("Demographic Scores")

cb=(result.s.^2)/(sum(result.s.^2)); % calculate percent varaince explained 

figure
plot(1:4,cb*100,'b.','MarkerSize', 30); % plot percent var explained
hold on
set(findall(gcf,'-property','FontSize'),'FontSize',12)
plot(1:4,cb*100,'b-','LineWidth', 1.5); % plot percent var explained
xlabel("Component Number")
ylabel("Percent Covariance Explained (%)")


figure
scatter(result.usc(:,1),result.vsc(:,1))
figure
scatter(result.usc(:,2),result.vsc(:,2))
