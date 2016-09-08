%% Plot benchmark classifier rank distributions

clear
close all
clc

fpath = mfilename('fullpath');
rerfPath = fpath(1:strfind(fpath,'RandomerForest')-1);

LineWidth = 2;
FontSize = .12;
axWidth = 2.75;
axHeight = 1.25;
axLeft = FontSize*3*ones(1,5);
axBottom = [FontSize*16+axHeight*4,FontSize*11+axHeight*3,...
    FontSize*8+axHeight*2,FontSize*5+axHeight,...
    FontSize];
figWidth = axLeft(end) + axWidth + FontSize;
figHeight = axBottom(1) + axHeight + FontSize*2;

fig = figure;
fig.Units = 'inches';
fig.PaperUnits = 'inches';
fig.Position = [0 0 figWidth figHeight];
fig.PaperPosition = [0 0 figWidth figHeight];
fig.PaperSize = [figWidth figHeight];

fpath = mfilename('fullpath');
rerfPath = fpath(1:strfind(fpath,'RandomerForest')-1);

Transformations = {'Untransformed','Rotated','Scaled','Affine','Outlier'};

for i = 1:length(Transformations)
    load(['~/Benchmarks/Results/Benchmark_' lower(Transformations{i}) '.mat'])
    Classifiers = fieldnames(TestError{1});
    Classifiers(~ismember(Classifiers,{'rf','rfr','frc','frcr','rr_rf','rr_rfr'})) = [];

    TestError = TestError(~cellfun(@isempty,TestError));

    ErrorMatrix = [];
    for j = 1:length(TestError)
        for k = 1:length(Classifiers)
            ErrorMatrix(j,k) = TestError{j}.(Classifiers{k});
        end
    end

    ClRanks = tiedrank(ErrorMatrix')';
    IntRanks = floor(ClRanks);
    

    RankCounts = NaN(length(Classifiers));
    for j = 1:length(Classifiers)
        RankCounts(j,:) = sum(IntRanks==j); 
        MeanRank.(Classifiers{j}).(Transformations{i}) = mean(IntRanks(:,j));
    end
    
    ax(i) = axes;
    bar(RankCounts')
    Bars = allchild(ax(i));
    for j = 1:length(Bars)
        Bars(j).EdgeColor = 'k';
        Bars(j).BarWidth = 1;
    end

    ylabel('Frequency')
    if strcmp(Transformations{i},'Outlier')
        title('Corrupted')
    else
        title(Transformations{i})
    end

    ax(i).LineWidth = LineWidth;
    ax(i).FontUnits = 'inches';
    ax(i).FontSize = FontSize;
    ax(i).Units = 'inches';
    ax(i).Position = [axLeft(i) axBottom(i) axWidth axHeight];
    if i==1
        xlabel('Rank')
        ax(i).XTickLabel = {'RF' 'RF(r)' 'F-RC' 'F-RC(r)' 'RR-RF' 'RR-RF(r)'};
    else
        ax(i).XTick = [];
    end
    ax(i).XLim = [0.5 6.5];
    ax(i).YLim = [0 60];
    
    ColoredIdx = [1,3,5];
    for j = ColoredIdx
        p = patch([j-0.5 j+0.5 j+0.5 j-0.5],[0 0 ax(i).YLim(2) ax(i).YLim(2)],...
            [0.9 0.9 0.9]);
        p.EdgeColor = 'none';
    end
    
    ColoredIdx = [2,4,6];
    for j = ColoredIdx
        p = patch([j-0.5 j+0.5 j+0.5 j-0.5],[0 0 ax(i).YLim(2) ax(i).YLim(2)],...
            [0.8 0.8 0.8]);
        p.EdgeColor = 'none';
    end
        
    ch = ax(i).Children;
    ch(1:6) = [];
    ch(end+1:end+6) = ax(i).Children(1:6);
    ax(i).Children = ch;

%     if i==5
%         [l,obj,~,~] = legend('1st place','2nd place','3rd place','4th place','5th place',...
%             '6th place');
%         l.Location = 'northwest';
%         l.Box = 'off';
%     end
    
    if strcmp(Transformations{i},'Untransformed')
%         line([1 1],[30 40],'Color','k','LineWidth',LineWidth)
%         line([3 3],[29 40],'Color','k','LineWidth',LineWidth)
%         line([1 3],[40 40],'Color','k','LineWidth',LineWidth)
%         t = text(2,40,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[42 46],'Color','k','LineWidth',LineWidth)
%         line([4 4],[29 46],'Color','k','LineWidth',LineWidth)
%         line([1 4],[46 46],'Color','k','LineWidth',LineWidth)
%         t = text(2.5,46,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
        t = text(3,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(4,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
    elseif strcmp(Transformations{i},'Rotated')
%         line([1 1],[29 36],'Color','k','LineWidth',LineWidth)
%         line([3 3],[35 36],'Color','k','LineWidth',LineWidth)
%         line([1 3],[36 36],'Color','k','LineWidth',LineWidth)
%         t = text(2,36,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[38 42],'Color','k','LineWidth',LineWidth)
%         line([4 4],[41 42],'Color','k','LineWidth',LineWidth)
%         line([1 4],[42 42],'Color','k','LineWidth',LineWidth)
%         t = text(2.5,42,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[44 48],'Color','k','LineWidth',LineWidth)
%         line([5 5],[43 48],'Color','k','LineWidth',LineWidth)
%         line([1 5],[48 48],'Color','k','LineWidth',LineWidth)
%         t = text(3,48,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[50 54],'Color','k','LineWidth',LineWidth)
%         line([6 6],[27 54],'Color','k','LineWidth',LineWidth)
%         line([1 6],[54 54],'Color','k','LineWidth',LineWidth)
%         t = text(3.5,54,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
        t = text(3,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(4,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(5,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(6,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
    elseif strcmp(Transformations{i},'Affine')
%         line([1 1],[33 39],'Color','k','LineWidth',LineWidth)
%         line([4 4],[38 39],'Color','k','LineWidth',LineWidth)
%         line([1 4],[39 39],'Color','k','LineWidth',LineWidth)
%         t = text(2.5,39,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[41 45],'Color','k','LineWidth',LineWidth)
%         line([6 6],[38 45],'Color','k','LineWidth',LineWidth)
%         line([1 6],[45 45],'Color','k','LineWidth',LineWidth)
%         t = text(3.5,45,'*','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
        t = text(4,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(6,ax(i).YLim(2),'\bf{+}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
    elseif strcmp(Transformations{i},'Outlier')
%         line([1 1],[33 38],'Color','k','LineWidth',LineWidth)
%         line([3 3],[37 38],'Color','k','LineWidth',LineWidth)
%         line([1 3],[38 38],'Color','k','LineWidth',LineWidth)
%         t = text(2,38,'**','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[40 44],'Color','k','LineWidth',LineWidth)
% %         line([5 5],[10 44],'Color','k','LineWidth',LineWidth)
%         line([1 5],[44 44],'Color','k','LineWidth',LineWidth)
%         t = text(3,44,'**','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
% 
%         line([1 1],[46 50],'Color','k','LineWidth',LineWidth)
%         line([6 6],[48 50],'Color','k','LineWidth',LineWidth)
%         line([1 6],[50 50],'Color','k','LineWidth',LineWidth)
%         t = text(3.5,50,'**','HorizontalAlignment','center',...
%             'VerticalAlignment','middle','FontSize',12);
        t = text(3,ax(i).YLim(2),'\bf{-}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(5,ax(i).YLim(2),'\bf{-}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
        t = text(6,ax(i).YLim(2),'\bf{-}','HorizontalAlignment','center',...
            'VerticalAlignment','top','FontSize',14,'Color','r');
    end
end

save_fig(gcf,[rerfPath 'RandomerForest/Figures/Fig4_benchmark_ranks'])