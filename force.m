function [dL,dD,dT,dQ,dP] = force(rho,S,Ve,cl,cd,phi,alpha_i,r,omega) 
dL = 0.5 * rho .* (Ve.^2) .*S .* cl; 
dD = 0.5 * rho .* (Ve.^2) .*S .* cd;
dT = dL.*cos((phi+alpha_i).*pi/180)-dD.*sin((phi+alpha_i).*pi/180);
dQ = r.*(dL.*sin((phi+alpha_i).*pi/180) + dD.*cos(phi+alpha_i).*pi/180);
dP = omega.*r.*(dL.*sin((phi+alpha_i).*pi/180)+dD.*cos(phi+alpha_i).*pi/180 );

end