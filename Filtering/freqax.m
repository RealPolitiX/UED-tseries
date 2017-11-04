function freqs = freqax(arr, fstep)
% Calculate the frequency axis

    narr = length(arr);
    df = fstep/(narr-1);
    freqs = [-ceil((narr-1)/2):floor((narr-1)/2)]*df;

end