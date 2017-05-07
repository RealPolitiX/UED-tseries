function tstruct = ROIDecayAnalyze(fileFolder,backgroundFile,ROI)

if nargin < 3
    print('Insufficient input arguments!')
elseif nargin > 4
    print('Too many input arguments!')
else
    NET.addAssembly('C:\Program Files\Matlab\NET\DataIOLib.dll');

    fDir = fileFolder;
    flist = dir(fullfile(fDir,'*.spe'));
    fnum = length(flist);

    fprlist = struct('name',[],'date',[],'bytes',[],'isdir',[],'datenum',[]);

    for l = 1:fnum
        if ~isempty(strfind(flist(l).name,'frame'))
            fprlist(end+1) = flist(l);
        end
    end

    fprlist(1) = [];
    prlist = fprlist;

    % Load background image
    bkgdDir = backgroundFile;
    bkgd = double(DataIOLibrary.DataIO.ReadSpe(bkgdDir));

    % Caculate ROI values
    nROI = length(ROI);
    [~,idpr] = sort([prlist.datenum]);
    fnum = length(prlist);
    prROINorm = zeros(nROI,fnum);
    prROIVal = zeros(nROI,fnum);


    for i = 1:fnum
        prdata = double(DataIOLibrary.DataIO.ReadSpe(fullfile([fDir,prlist(idpr(i)).name]))) - bkgd;
    %    enumpr = sum(sum(prdata(40:310,40:355)));enumpp = sum(sum(ppdata(40:310,40:355)));
        enumpr = sum(sum(prdata));
        for j = 1:nROI
            prROIsum = sum(sum(prdata(ROI(j,1):ROI(j,2),ROI(j,3):ROI(j,4))));
            prROIVal(j,i) = prROIsum;
            prROINorm(j,i) = prROIsum/enumpr;
        end
    end

    tstruct = struct('fnum',fnum,'prROIVal',prROIVal,'prROINorm',prROINorm,'ROI',ROI);
end

end