
%% Selezione di alpha e beta per i vettori di propagazione

z_e=(zita*kx)/k            % Z mezzo esterno
z_p=(zita_p*kx_p)/k_p    % Z mezzo interno da controllare il valore di kzinp

zita
zita_p
kxrif_p=-kx_p;
kxtra3=kx;
kxtra1=-kx;
ky_tm=0;

%% Calcolo dei valori di campo

H1=-1*(2*z_p/(z_e-z_p))*Hinc_p*exp(1*i*(kx+kx_p)*d_v);
H3=1*(2*z_p/(z_e+z_p))*Hinc_p*exp(1*i*(kx-kx_p)*d_v);
Hrif_p=-((z_e+z_p)/(z_e-z_p))*Hinc_p*exp(2*1*i*kx_p*d_v);

%% Calcolo del campo totale

for xn = 1:nptx
    for yn = 1:npty
        Htot(xn,yn)=onde_piane_tm(y(yn),x(xn),ky_tm,kx_p,kxrif_p,kxtra1,kxtra3,Hinc_p,H1,Hrif_p,H3,d_v);
    end
end

% figure(1)
% imagesc(z,x,abs(Htot));
% colorbar;

%% Plot della sezione trasversa 
figure(2);
title('TM');
hold on
plot(x,abs(Htot(:,1).'));
plot(linspace(d_v,d_v,101),linspace(0,2,101),'.')
plot(linspace(-d_v,-d_v,101),linspace(0,2,101),'.')
grid on
hold off