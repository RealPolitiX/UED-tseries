function TM = TMfr2car(a,b,c,alf,bet,gam)
    % Construct transform matrix from fractional to Cartesian coordinates
    
    % Calculate unit cell volume
    v = sqrt(1 - cosd(alf)^2 - cosd(bet)^2 - cosd(gam)^2 + 2*cosd(alf)*cosd(bet)*cosd(gam));

    % Transformation matrix
    TM = [a b*cosd(gam) c*cosd(bet);
        0 b*sind(gam) (c*(cosd(alf) - cosd(bet)*cosd(gam)))/sind(gam);
        0 0 (c*v)/sind(gam)];

end
