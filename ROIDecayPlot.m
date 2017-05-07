function ROIDecayPlot(dataStruct,scanDate,scanNum,pulsperframe)

% Make ROI decay plots

% Calculate the number of pulses
fnum = dataStruct(1).fnum;
naxis = (pulsperframe/1000)*[1:fnum];
nROI = length(dataStruct(1).ROI);
ROIMat = reshape(1:nROI,4,floor(nROI/4))';

for m = 1:size(ROIMat,1)
    
    ROISeq = ROIMat(m,:);
    kmax = length(ROISeq);

    hROIVal = figure;
    hold all
    grid on;box on;
    for k = 1:kmax
        plot(naxis,dataStruct.prROIVal(ROISeq(k),:),'-o','LineWidth',1.5,'MarkerSize',6);
        lgd1{k} = ['ROI',num2str(ROISeq(k))];
    end
    hold off
    legend(lgd1,'Location','SouthOutside','Orientation','horizontal');
    xlabel('Number of pump pulses (10^3 shots)','FontSize',15);
    ylabel('Integrated ROI count','FontSize',15);
    xlim([min(naxis) max(naxis)]);
    
    saveas(hROIVal,[scanDate,'_Scan',num2str(scanNum),'_ROIRel_Decay',num2str(ROISeq)],'fig');
    saveas(hROIVal,[scanDate,'_Scan',num2str(scanNum),'_ROIRel_Decay',num2str(ROISeq)],'bmp');

    hROIValNorm = figure;
    hold all
    grid on;box on;
    for k = 1:kmax
        plot(naxis,dataStruct.prROINorm(ROISeq(k),:),'-o','LineWidth',1.5,'MarkerSize',6);
        lgd2{k} = ['ROI',num2str(ROISeq(k))];
    end
    hold off
    legend(lgd2,'Location','SouthOutside','Orientation','horizontal');
    xlabel('Number of pump pulses (10^3 shots)','FontSize',15);
    ylabel('e-num-norm. integ. ROI count','FontSize',15);
    xlim([min(naxis) max(naxis)]);
    
    saveas(hROIValNorm,[scanDate,'_Scan',num2str(scanNum),'_ROIRelNorm_Decay',num2str(ROISeq)],'fig');
    saveas(hROIValNorm,[scanDate,'_Scan',num2str(scanNum),'_ROIRelNorm_Decay',num2str(ROISeq)],'bmp');

    hROIValPct = figure;
    hold all
    grid on;box on;
    for k = 1:kmax
        plot(naxis,dataStruct.prROINorm(ROISeq(k),:)/dataStruct.prROINorm(ROISeq(k),1),'-o','LineWidth',1.5,'MarkerSize',6);
        lgd3{k} = ['ROI',num2str(ROISeq(k))];
    end
    hold off
    legend(lgd3,'Location','SouthOutside','Orientation','horizontal');
    xlabel('Number of pump pulses (10^3 shots)','FontSize',15);
    ylabel('e-num-norm. ROI ratio, ROI(t_n)/ROI(t_1)','FontSize',15);
    xlim([min(naxis) max(naxis)]);
    ylim([0.7 1.2]);
    
    saveas(hROIValPct,[scanDate,'_Scan',num2str(scanNum),'_ROIRelNormPct_Decay',num2str(ROISeq)],'fig');
    saveas(hROIValPct,[scanDate,'_Scan',num2str(scanNum),'_ROIRelNormPct_Decay',num2str(ROISeq)],'bmp');

end

end