function Etot = onde_piane_te2(z,y,kz,ky_p,kyrif_p,kytra1,kytra3,Einc_p,E1,Erif_p,E3,d)
%Sto calcolando i campi elettrici
%% Costruisco Gli If

if y<=-1*d
    Etot=E1*exp(-1*i*(kytra1*y+kz*z));
elseif (-1*d<y)&&(y<d)
    Etot=Einc_p*exp(-1*i*((kz*z)+(ky_p*y)))+Erif_p*exp(-1*i*(kz*z + kyrif_p*y));
elseif y>=d
    Etot=E3*exp(-1*i*(kz*z+kytra3*y));
end