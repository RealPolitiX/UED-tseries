function TM = TMcar2fr(a,b,c,alf,bet,gam)
    % Construct transform matrix from Cartesian to fraction coordinate systems
    
    % Calculate unit cell volume
    v = sqrt(1 - cosd(alf)^2 - cosd(bet)^2 - cosd(gam)^2 + 2*cosd(alf)*cosd(bet)*cosd(gam));

    % Transformation matrix
    TM = [1/a -cotd(gam)/a (cotd(gam)*(cosd(alf) - cosd(bet)*cosd(gam)) - cosd(bet)*sind(gam))/(a*v);
        0 1/(b*sind(gam)) -(cosd(alf) - cosd(bet)*cosd(gam))/(b*v*sind(gam));
        0 0 sind(gam)/(c*v)];

end
