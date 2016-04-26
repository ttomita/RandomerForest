%% Compute oob error, ave tree strength, tree bias, and tree variance

close all
clear
clc

InPath = '../Results/Untransformed/';
contents = dir([InPath,'*.mat']);
OutPath = '../Results/Untransformed/Performance_profiles/';

load('../Data/Benchmark_data.mat','Y','n','d')

min_d = 1;
max_d = 100;
min_n = 1;
max_n = 50000;

rmidx = [];
for i = 1:length(n)
    if ~(n(i) >= min_n && n(i) < max_n && d(i) >= min_d && d(i) < max_d)
        rmidx = [rmidx i];
    end
end
n(rmidx) = [];
d(rmidx) = [];
Y(rmidx) = [];

for i = 1:length(contents)
    InFile = [InPath,contents(i).name];
    load(InFile,'Yhats','Time','ntrees','mtrys','nmixs')
    Classifiers = fieldnames(Yhats);
    mtrys_rf = mtrys(mtrys<=d(i));
    
    for c = 1:length(Classifiers)
        cl = Classifiers{c};
        if strcmp(cl,'rf') || strcmp(cl,'rf_rot')
            m = mtrys_rf;
        else
            m = mtrys;
        end
        
        for j = 1:length(m)
            MR.(cl)(i,j) = oob_error(Yhats.(cl)(:,:,j),Y{i},'last');
            S.(cl)(i,j) = misclassification_rate(Yhats.(cl)(:,:,j),...
                Y{i},false);
            V.(cl)(i,j) = classifier_variance(Predictions);
            B.(cl)(i,j) = S.(cl)(i,j) - V.(cl)(i,j);
        end
    end
end