function [v_ind] = Vinduced(V_inf,Omega_r,R,Nb,CofR,CD,CL)
W0 = 1;
h = 0.01;
count = 0;
while(count<100)
    count =count+1;
    F1 = F_of_w(V_inf,Omega_r,R,Nb,CofR,CD,CL,W0-h);
    F2 = F_of_w(V_inf,Omega_r,R,Nb,CofR,CD,CL,W0+h);
    FprimeofW0 = 0.5*(F2-F1)/h;
    FofW0 = F_of_w(V_inf,Omega_r,R,Nb,CofR,CD,CL,W0);
    if FprimeofW0 == 0
        count = 100;
    else
        W1 = W0-FofW0/FprimeofW0;
        if abs(W1-W0)<0.0001
            count = 100;
        end
            W0 = W1;
    end
        
    
end
v_ind = W0;
end
function [fofw] = F_of_w(V_inf,Omega_r,R,Nb,CofR,CD,CL,w)
fofw = 25.13274 .* w .* R / (Nb.*CofR) - sqrt( 1+ (Omega_r./(V_inf+w)).^2).*(CL.*Omega_r-CD.*(V_inf+w));
end