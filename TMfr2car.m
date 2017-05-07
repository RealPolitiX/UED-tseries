function TM = TMfr2car(a,b,c,alf,bet,gam)

v = sqrt(1 - cosd(alf)^2 - cosd(bet)^2 - cosd(gam)^2 + 2*cosd(alf)*cosd(bet)*cosd(gam));

% Transformation matrix from fractional coordinates to Cartesian coordinates
TM = [a b*cosd(gam) c*cosd(bet);
    0 b*sind(gam) (c*(cosd(alf) - cosd(bet)*cosd(gam)))/sind(gam);
    0 0 (c*v)/sind(gam)];

end