function imgNbk = ROIAnnotate(imgDir,bkgdDir,colorScheme,colorScale,imgRegion,ROI)

% Draw ROIs in a color plot or black & white plot

if nargin < 5
    
    print('Insufficient input arguments!');
    
elseif nargin == 5
    
    NET.addAssembly('C:\Program Files\Matlab\NET\DataIOLib.dll');
    imgData = double(DataIOLibrary.DataIO.ReadSpe(imgDir));
    bkgdData = double(DataIOLibrary.DataIO.ReadSpe(bkgdDir));
    imgNbk = imgData - bkgdData;

    h = figure;
    set(h,'Position',[15 15 900 900]);

    switch colorScheme
        case 'Jet'
            colormap(jet);
            imagesc(imgNbk,colorScale);
        case '+BW'
            imshow(imgNbk,colorScale);
        case '-BW'
            imshow(-imgNbk,colorScale);
    end
    xlim([imgRegion(1) imgRegion(2)]);
    ylim([imgRegion(3) imgRegion(4)]);

elseif nargin == 6
    
    NET.addAssembly('C:\Program Files\Matlab\NET\DataIOLib.dll');
    imgData = double(DataIOLibrary.DataIO.ReadSpe(imgDir));
    bkgdData = double(DataIOLibrary.DataIO.ReadSpe(bkgdDir));
    imgNbk = imgData - bkgdData;

    h = figure;
    set(h,'Position',[15 15 900 900]);

    switch colorScheme
        case 'Jet'
            colormap(jet);
            imagesc(imgNbk,colorScale);
%         case 'LogJet'
%             colormap(jet);
%             imagesc(abs(log(imgNbk)),colorScale);
        case '+BW'
            imshow(imgNbk,colorScale);
        case '-BW'
            imshow(-imgNbk,colorScale);
    end
    
    hold on
    ROIType = length(size(ROI));
    nROI = size(ROI,1);

    if ROIType == 2 % For rectangular ROI, draw rectangles directly on the plot
        for i = 1:nROI
            rectangle('Position',[ROI(i,3),ROI(i,1),ROI(i,4)-ROI(i,3),ROI(i,2)-ROI(i,1)],...
                'LineWidth',2,'EdgeColor','c');
            text(ROI(i,3),ROI(i,1)-3,num2str(i),'FontSize',12,'FontWeight','bold','Color','r');
        end
        %[204 122 83]/255
    elseif ROIType == 3
        for i = 1:nROI % For polygonal ROI, draw lines connecting vertices of the polygon
            line(ROI(i,:,1),ROI(i,:,2),'Color','r','LineWidth',2);
            line([ROI(i,end,1),ROI(i,1,1)],[ROI(i,end,2),ROI(i,1,2)],'Color','r','LineWidth',2);
            text(ROI(i,1,1)-5,ROI(i,1,2)-12,num2str(i),'FontSize',12,'FontWeight','bold','Color',[204 122 83]/255);
        end
    end
    hold off
    xlim([imgRegion(1) imgRegion(2)]);
    ylim([imgRegion(3) imgRegion(4)]);
    
end 

end