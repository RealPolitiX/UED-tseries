function pcount = PixelSum(img,pxlx,pxly)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Sum over all designated pixel values of the input image
    %
    % Input arguments
    % img: image matrix
    % pxlx, pxly: the x & y Cartesian coordinates of summand pixels
    %
    % Output argument
    % pcount: integrated value of all input pixels
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    nx = length(pxlx);
    ny = length(pxly);
    
    % Input size check
    if nx == ny
        % Initiate the pixel intensity count to 0
        pcount = 0;
        for i = 1:nx
            pcount = pcount + img(pxlx(i),pxly(i));
        end

    else
        print('Input coordinate vectors have different lengths!')
        
    end

end
