function tstruct = ROITraceAnalyze(fileFolder,backgroundFile,ROI)

if nargin < 3
    print('Insufficient input arguments!')
elseif nargin > 4
    print('Too many input arguments!')
else
    dataIOAssembly = NET.addAssembly('C:\Program Files\Matlab\NET\DataIOLib.dll');

    fDir = fileFolder;
    flist = dir(fullfile(fDir,'*.spe'));
    fnum = length(flist);

    fdifflist = struct('name',[],'date',[],'bytes',[],'isdir',[],'datenum',[]);
    fprlist = struct('name',[],'date',[],'bytes',[],'isdir',[],'datenum',[]);
    fpplist = struct('name',[],'date',[],'bytes',[],'isdir',[],'datenum',[]);

    for l = 1:fnum
        if ~isempty(strfind(flist(l).name,'Time'))
            fdifflist(end+1) = flist(l);
        elseif ~isempty(strfind(flist(l).name,'sec Probe'))
            fprlist(end+1) = flist(l);
        elseif ~isempty(strfind(flist(l).name,'Pump'))
            fpplist(end+1) = flist(l);
        end
    end

    fdifflist(1) = [];
    fprlist(1) = [];
    fpplist(1) = [];
    difflist = fdifflist;
    prlist = fprlist;
    pplist = fpplist;

    % Load background image
    bkgdDir = backgroundFile;
    bkgd = double(DataIOLibrary.DataIO.ReadSpe(bkgdDir));

    % Caculate ROI values
    nROI = length(ROI);
    [~,idpr] = sort([prlist.datenum]);
    [~,iddiff] = sort([difflist.datenum]);
    fnum = length(difflist);
    ROIRel = zeros(nROI,fnum);
    ROIDiff = zeros(nROI,fnum);
    prROINorm = zeros(nROI,fnum);
    prROIVal = zeros(nROI,fnum);
    ppROINorm = zeros(nROI,fnum);
    ppROIVal = zeros(nROI,fnum);


    for i = 1:fnum
        prdata = double(DataIOLibrary.DataIO.ReadSpe(fullfile([fDir,prlist(idpr(i)).name]))) - bkgd;
        ppdata = double(DataIOLibrary.DataIO.ReadSpe(fullfile([fDir,pplist(idpr(i)).name]))) - bkgd;
        diffdata = double(DataIOLibrary.DataIO.ReadSpe(fullfile([fDir,difflist(iddiff(i)).name])));
        enumpr = sum(sum(prdata(40:310,40:355)));enumpp = sum(sum(ppdata(40:310,40:355)));
    %    enumpr = sum(sum(prdata));enumpp = sum(sum(ppdata));
        for j = 1:nROI
            prROIsum = sum(sum(prdata(ROI(j,1):ROI(j,2),ROI(j,3):ROI(j,4))));
            ppROIsum = sum(sum(ppdata(ROI(j,1):ROI(j,2),ROI(j,3):ROI(j,4))));
            dfROIsum = sum(sum(diffdata(ROI(j,1):ROI(j,2),ROI(j,3):ROI(j,4))));
            prROIVal(j,i) = prROIsum;ppROIVal(j,i) = ppROIsum;
            prROINorm(j,i) = prROIsum/enumpr;
            ppROINorm(j,i) = ppROIsum/enumpp;
            ROIDiff(j,i) = dfROIsum/prROIsum;
            ROIRel(j,i) = (ppROIsum*enumpr)/(prROIsum*enumpp) - 1;
            %ROIRel(j,i) = ppROIsum/enumpp;
        end
    end

    tstruct = struct('fnum',fnum,'ROIRel',ROIRel,'ROIDiff',ROIDiff,...
        'prROIVal',prROIVal,'prROINorm',prROINorm,'ppROIVal',ppROIVal,...
        'ppROINorm',ppROINorm,'ROI',ROI);
end

end