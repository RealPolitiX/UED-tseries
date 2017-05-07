function ROITracePlot(dataStruct,scanDate,scanNum,taxis,ymin,ymax,tmin,tmax)
% The last two arguments are optional

if nargin < 6
    print('Insufficient input arguments!')
elseif nargin > 8
    print('Too many input arguments!')
elseif nargin == 7
    print('Please specify both the lower and upper limits of axes!')
else
    nROI = length(dataStruct(1).ROI);
    ROIMat = reshape(1:nROI,4,floor(nROI/4))';
    %taxis = t0:dt:(t0+dt*(fnum-1));
    ytick = floor(ymin):floor(ymax);
    
    if nargin == 8
        xmin = tmin;xmax = tmax;
    elseif nargin == 6
        xmin = min(taxis); xmax = max(taxis);
    end

    legendLoca = 'NorthOutside';%'SouthOutside';
    legendOrient = 'horizontal'; % vertical or horizontal

    for m = 1:size(ROIMat,1)

        % The sequence of ROIs to be plotted in the same graph
        ROISeq = ROIMat(m,:);
        kmax = length(ROISeq);

        % Figure of ROI region relative change in the difference image
        hVal = figure;
        set(hVal,'Position',[100 100 700 600]);
        hold all
        grid on;
        for k = 1:kmax
            plot(taxis,dataStruct(1).ROIDiff(ROISeq(k),:)*100,'-o','LineWidth',3,'MarkerSize',2);
            lgd1{k} = ['ROI',num2str(ROISeq(k))];
        end
        hold off
        box on
        set(gca,'FontSize',15,'FontWeight','bold','LineWidth',2);
        legend(lgd1,'Location',legendLoca,'Orientation',legendOrient);
        xlabel('Pump-probe time delay (ps)','FontSize',20);
        %xlabel('Time point (ps)','FontSize',15);
        ylabel('Relative ROI change (%)','FontSize',20);
        set(gca,'xtick',floor(xmin):ceil(xmax));
        xlim([xmin xmax]);
        ylim([ymin ymax]);
        set(gca,'ytick',ytick);
        saveas(hVal,[scanDate,'_Scan',num2str(scanNum),'_ROIRel_',num2str(ROISeq)],'fig');
        saveas(hVal,[scanDate,'_Scan',num2str(scanNum),'_ROIRel_',num2str(ROISeq)],'bmp');

        % Figure of ROI region relative change with normalized electron numbers
        % on the pump+probe and probe only images
        hNorm = figure;
        set(hNorm,'Position',[100 100 700 600]);
        hold all
        grid on;
        for k = 1:kmax
            plot(taxis,dataStruct(1).ROIRel(ROISeq(k),:)*100,'-o','LineWidth',3,'MarkerSize',2);
            lgd2{k} = ['ROI',num2str(ROISeq(k))];
        end
        hold off
        box on
        set(gca,'FontSize',15,'FontWeight','bold','LineWidth',2);
        legend(lgd2,'Location',legendLoca,'Orientation',legendOrient);
        xlabel('Pump-probe time delay (ps)','FontSize',20);
        %xlabel('Time point (ps)','FontSize',15);
        ylabel('e-num norm. rel. ROI change (%)','FontSize',20);
        set(gca,'xtick',floor(xmin):ceil(xmax));
        xlim([xmin xmax]);
        ylim([ymin ymax]);
        set(gca,'ytick',ytick);
        saveas(hNorm,[scanDate,'_Scan',num2str(scanNum),'_ROIRelNorm_',num2str(ROISeq)],'fig');
        saveas(hNorm,[scanDate,'_Scan',num2str(scanNum),'_ROIRelNorm_',num2str(ROISeq)],'bmp');
    end

end