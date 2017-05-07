function SeriesPlot(scanDate,scanNum,fDir,plotSize,displayParameter,imSect,colorScheme,colorScale,ImgKeyword)

% SeriesPlot(scanDate,scanNum,fDir,plotSize,displayParameter,imSect,colorScheme,colorScale,ImgKeyword)

if nargin < 8
    fprintf('Insufficient input arguments!')
    return
elseif nargin > 9
    fprintf('Too many input arguments!')
    return
elseif nargin == 8
    ImgKeyword = 'Time-Resolved';
end

flist = dir(fullfile(fDir,'*.spe')); % Grab all the spe files;
nlist = length(flist);
    
    % Extract keywords from the folder name and compile in an array
    fsearchlist = struct('name',[],'date',[],'bytes',[],'isdir',[],'datenum',[]);
    for s = 1:nlist
        if ~isempty(strfind(flist(s).name,ImgKeyword))
            fsearchlist(end+1) = flist(s);
        end
    end
    fsearchlist(1) = [];
    strkw = regexp([fsearchlist.name],'\w*fs\w*','match');

    % Pick out the relevant dimension of the split string
    ntpts = length(strkw); % Number of time points taken
    kw = zeros(1,ntpts);
    for l = 1:ntpts
        kw(l) = str2double(strkw{l}(1:6)); % Convert the timing label to number
    end
    % Sort by keywords from the folder name
    [~,kwidx] = sort(kw,'ascend');

    % Open images at each time point and plot in a graph
    NET.addAssembly('C:\Program Files\Matlab\NET\DataIOLib.dll');
    % Calculate the number of big pictures
    nsubpic = prod(displayParameter);
    npics = ceil(ntpts/nsubpic);
    picSeq = 1:ntpts;
    % Loop over the number of big pictures
    for m = 1:npics

        hsp = figure;
        set(hsp,'Position',[10 10 plotSize]);

        seqVec = picSeq(ceil(picSeq/nsubpic) == m);
        nsinglepic = length(seqVec);

        for i = 1:nsinglepic
            imgDir = fullfile([fDir,fsearchlist(kwidx(seqVec(i))).name]);
            imgData = double(DataIOLibrary.DataIO.ReadSpe(imgDir));
            % bkgdData = double(DataIOLibrary.DataIO.ReadSpe(bkgdDir));
            subf = subplot(displayParameter(1),displayParameter(2),seqVec(i)-(m-1)*nsubpic);
            
            if strcmp(colorScheme,'BW')
                imshow(imgData(imSect(1):imSect(2),imSect(3):imSect(4)),colorScale);
            elseif numel(find(strcmp(colorScheme,{'Hot','Cool','Summer','Winter','Bone','Copper','Pink','Jet'}))) == 1
                colormap(colorScheme);
                imagesc(imgData(imSect(1):imSect(2),imSect(3):imSect(4)),colorScale);
            else
                fprintf('No such color map!')
            end
            subpos = get(subf,'pos');
            subpos(3) = subpos(3) + 0.5;
            subpost(1) = subpos(1) + 0.5;
            title(strkw(kwidx(seqVec(i))),'FontSize',12,'FontWeight','bold');
        end

        saveas(hsp,[scanDate,'_Scan',scanNum,'_',ImgKeyword,'_',num2str(m)],'fig');
        saveas(hsp,[scanDate,'_Scan',scanNum,'_',ImgKeyword,'_',num2str(m)],'jpg');

    end
    

end