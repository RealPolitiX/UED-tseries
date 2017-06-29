function [xin, yin, innum] = PickPolyCoords(polyvertex,matr,matc)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Generate the Cartesian coordinates within a polygon area
    %
    % Input arguments
    % polyvertex: coordinates of the vertices of the polygon
    % matr, matc: row and column dimensions of the input matrix
    %
    % Output arguments
    % xin, yin: x, y coordinates of the points within the polygon area
    % innum: total number of points inside the polygon
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Generate Cartesian coordinates of the meshgrid the size of the matrix
    [xall, yall] = meshgrid(1:matr,1:matc);
    % Reshape the x, y coordinates into 1D array
    xq = reshape(xall,1,numel(xall));
    yq = reshape(yall,1,numel(yall));
    
    % Close the polygon by duplicating the first vertex at the end
    if polyvertex(end,:) ~= polyvertex(1,:)
        polyvertex(end+1,:) = polyvertex(1,:);
    end
    
    % Check if the points are within the polygon area
    % Output 1D boolean array
    inpoly = inpolygon(xq,yq,polyvertex(:,1),polyvertex(:,2));
    
    % Retain the points
    xin = xq(inpoly);
    yin = yq(inpoly);
    
    % Count the number of points inside the polygon
    innum = numel(xin);

end
