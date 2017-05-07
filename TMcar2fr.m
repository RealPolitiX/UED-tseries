function TM = TMcar2fr(a,b,c,alf,bet,gam)

v = sqrt(1 - cosd(alf)^2 - cosd(bet)^2 - cosd(gam)^2 + 2*cosd(alf)*cosd(bet)*cosd(gam));

% Transformation matrix from Cartesian coordinates to fractional coordinates
TM = [1/a -cotd(gam)/a (cotd(gam)*(cosd(alf) - cosd(bet)*cosd(gam)) - cosd(bet)*sind(gam))/(a*v);
    0 1/(b*sind(gam)) -(cosd(alf) - cosd(bet)*cosd(gam))/(b*v*sind(gam));
    0 0 sind(gam)/(c*v)];

end