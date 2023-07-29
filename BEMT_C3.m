%%Verification using Rotron SPARTAN Fan (SPTSL 3531SF). 
clc;clear all;
%user inputs


Rp    = 5.5/100;%Propeller Diameter [m]
Rhub  = 2.25/100;%Propeller Diameter [m]
Cr    = 4.5/100;%propeller chord [m]
Ct    = 4.5/100;%propeller tip chord [m]
RPM   = 5200;%Rotor RPM [-]
cfm = 0.0892;%mass flow rate from validationdata sheet
area = pi*(Rp-Rhub)^2;%N thrust from validation data sheet
V_inf = 0;%cfm/area;
%V_inf = 23.67;%Airspeed [m/s]
n = 120;%number of blade elements
Nb = 5;
raa = 50;% Root advance angle [deg]
taa = 30;%tip advance angle [deg]
%%
%Aerodynamic data import
aero_data;
%%
%Enviromental Conditions
T_0    = 288.15;                    % Temperature at MSL           [K]
rho    = 1.1991;                    % Density at UIUC wind tunnel  [kg/m³]
mu     = 1.79e-5;                   % Dry air dynamic viscosity    [kg/m-s]
nu     = mu/rho;            % Dry air kinematic viscosity  [m²/s]
R      = 287.05;                    % Air specific constant        [J/kg-K]
gamma  = 1.4;                       % Isentropic coefficient       [-]
 
a = 340; % sound speed [m/s]
%%
%Calculation geometric
delta_r = (Rp-Rhub)/(n);%infinetesimal element size [m]
r       = [Rhub+delta_r/2:delta_r:Rp];%location element [m]
x       = r./Rp;%Blade span fraction [m]
S       = ones(1,n)*Cr*delta_r;%area of element [m2]
cr      = ones(1,n) * Cr;
%S = [Cr:-(Cr-Ct)/n:Ct];%area of element in case Cr!=Ct [m2]
%Calculation Velocities
omega   = 2*3.14*(RPM)/60;
omega_r = omega.*r;
w       = ones(1,n);
Vr      = sqrt(V_inf^2 + omega_r.^2);
Ve      = sqrt((w+V_inf).^2 + omega_r.^2);
Mach    = ones(1,n).*Ve./a ;
%flow angles
j       = [1:1:n];
beta    = raa.*(1-(j-0.5)/n)+taa.*(j-0.5)./n;
phi     = atan(V_inf./omega_r)*180/pi;
alpha_i = asin(w./Vr).*180/pi;
alpha   = beta - phi - alpha_i;
Re      = rho.*Vr.*cr/mu;
%induced velocity
[CL,CD] = coeff(alpha,Mach,cl_data,cd_data);
for i = 1:n
    w(i) = Vinduced(V_inf,omega_r(i),r(i),Nb,cr(i),CD(i),CL(i));
end

%Revision calculations
Ve_1      = sqrt((w+V_inf).^2 + omega_r.^2);
Mach_1    = ones(1,n).*Ve_1./a ;
%flow angles
j_1       = [1:1:n];
beta_1    = raa.*(1-(j_1-0.5)./n)+taa*(j_1-0.5)./n;
phi_1     = atan(V_inf./omega_r)*180/pi;
alpha_i_1 = asin(w./Vr).*180/pi;
alpha_1   = beta_1 - phi_1 -alpha_i_1;
Re_1      = rho.*Vr.*cr/mu;
[CL_1,CD_1] = coeff(alpha_1,Mach_1,cl_data,cd_data);

%force calculation
[dL,dD,dT,dQ,dP] = force(rho,S,Ve_1,CL_1,CD_1,phi_1,alpha_i_1,r,omega);

%Print to console
fprintf('Lift %d N \n',sum(dL));
fprintf('Drag %d N \n',sum(dD));
fprintf('Thrust %d N \n',Nb*sum(dT));
fprintf('Torque %d Nm \n',Nb*sum(dQ));
fprintf('Power %d watts Nm/s \n',Nb*sum(dP));

%%
%RANKINE-FROUDE MOMENTUM THEORY
T = Nb*sum(dT);
Ap = pi*(Rp-Rhub)^2;
Vw = 0.5*(-V_inf + sqrt( V_inf^2+2*T/(rho*Ap)));
m_dot = T/Vw;
fprintf('Mass flow rate %d CFM',(m_dot/rho)/ (4.71947*10^-4)  );