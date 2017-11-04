function [filtered_arr, varargout] = fftfilter1D(arr, fstep, freqrange, varargin)
    
    fmin = min(freqrange);
    fmax = max(freqrange);
    
    % Parse additional input arguments
    psr = inputParser;
    addParameter(psr, 'Padding', true);
    addParameter(psr, 'Window', 'Tukey');
    addParameter(psr, 'Return', 'Filtered');
    parse(psr, varargin{:});
    padding = psr.Results.Padding;
    ret = psr.Results.Return;
    window = psr.Results.Window;
    
    % Array padding
    if padding
        arrpad = padarray(arr,[0 2*length(arr)],'post');
    else
        arrpad = arr;
    end
    midp = ceil(length(arrpad)/2);
    
    % Calculate the freuquency domain signal through FFT
    farr = fftshift(ifft(ifftshift(arrpad)));
    faxis = freqax(arr, fstep)*1e-12*33.3564; % Convert frequency axis to cm-1
    
    % Construct window function
    fminind = findnearest(fmin, faxis);
    fmaxind = findnearest(fmax, faxis);
    if fmaxind > fminind
        wsize = fmaxind - fminind;
    else
        error('Frequency range is too narrow!')
    end
    if window == 'Tukey'
        w = tukeywin(wsize,0.4);
    end
    
    % Construct filter function in frequency domain
    fltr = zeros(size(arrpad));
    wint = findnearest(-abs(fmin), faxis);
    fltr(wint:wint+wsize-1) = w;  % Positive frequency window
    nvebd = midp-(wint-midp);
    fltr(nvebd-wsize+1:nvebd) = w;  % Negative frequency window
    filtered_arr = farr.*fltr;
    
    if strcmp(ret, 'All')
        varargout{1} = faxis;
    end

end