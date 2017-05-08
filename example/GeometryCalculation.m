clc;
a = 9.5161; b = 15.6549; c = 15.8860;
alf = 83.4610; bet = 74.2290; gam = 78.5220;
U = TMfr2car(9.5161,15.6549,15.8860,83.4610,74.2290,78.5220);
Uinv = TMcar2fr(9.5161,15.6549,15.8860,83.4610,74.2290,78.5220);
%% Calculate the angle of a particular plane (hkl) wrt a, b, and c axes
clc;
ac = U*[1 0 0]';
bc = U*[0 1 0]';
cc = U*[0 0 1]';
V = ac'*cross(bc,cc);
rac = cross(bc,cc)/V;
rbc = cross(cc,ac)/V;
rcc = cross(ac,bc)/V;
h = -1;
k = -6;
l = 1;
d = h*rac + k*rbc + l*rcc;
tha = acosd(d'*ac/(norm(d)*norm(ac)))
thb = acosd(d'*bc/(norm(d)*norm(bc)))
thc = acosd(d'*cc/(norm(d)*norm(cc)))
S11 = (b*c*sind(alf))^2;
S22 = (a*c*sind(bet))^2;
S33 = (a*b*sind(gam))^2;
S12 = (a*b*c^2)*(cosd(alf)*cosd(bet) - cosd(gam));
S23 = (b*c*a^2)*(cosd(bet)*cosd(gam) - cosd(alf));
S13 = (a*c*b^2)*(cosd(gam)*cosd(alf) - cosd(bet));
dkinv = (1/V^2)*(S11*h^2 + S22*k^2 + S33*l^2 + 2*S12*h*k + 2*S23*k*l + 2*S13*h*l);
dk = dkinv^(-0.5)

%%
ebv = [-6.9942 1.255848 -4.28748]';
ebvc = U*ebv;
ac = U*[1 0 0]';
bc = U*[0 1 0]';
cc = U*[0 0 1]';
V = ac'*cross(bc,cc);
rac = cross(bc,cc)/V;
rbc = cross(cc,ac)/V;
rcc = cross(ac,bc)/V;
thea = acosd(ebvc'*ac/(norm(ebvc)*norm(ac)))
theb = acosd(ebvc'*bc/(norm(ebvc)*norm(bc)))
thec = acosd(ebvc'*cc/(norm(ebvc)*norm(cc)))
thera = acosd(ebvc'*rac/(norm(ebvc)*norm(rac)))
therb = acosd(ebvc'*rbc/(norm(ebvc)*norm(rbc)))
therc = acosd(ebvc'*rcc/(norm(ebvc)*norm(rcc)))