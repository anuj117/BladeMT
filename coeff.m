function [cl,cd] = coeff(alpha,Mach,cl_data,cd_data)
% cl = -0.000004582.*alpha.^4 - 0.00002926.*alpha.^3 + 0.000249.*alpha.^2+ 0.07239.*alpha + 0.4426;
% cd = 0.000006844.*alpha.^3 + 0.0003439.*alpha.^2 + 0.003488.*alpha + 0.01996;
cl  = ones(1,length(Mach));
cd  = ones(1,length(Mach));
cl_data = table2array(cl_data);
cd_data = table2array(cd_data);
for i=1:length(Mach)
    [v,c] = min(abs(cl_data(1,2:end)-Mach(i)));
    [v,r] = min(abs(cl_data(2:end,1)-alpha(i)));
    cl(i) = cl_data(r+1,c+1);
    %cd
    [v,c] = min(abs(cd_data(1,2:end)-Mach(i)));
    [v,r] = min(abs(cd_data(2:end,1)-alpha(i)));
    cd(i) = cd_data(r+1,c+1);
end


end