zita
zita_p


z_e_te=(zita*k)/ky          %Z mezzo esterno
z_p_te=(zita_p*k_p)/ky_p    %Z mezzo interno da controllare il valore di kzinp

kyrif_p=-ky_p;
kytra3=ky;
kytra1=-ky;
kx_te=0;

%% Calcolo dei valori di campo

E1=(2*z_e_te/(z_e_te-z_p_te))*Einc_p*exp(1i*(ky+ky_p)*d_o);
E3=(2*z_e_te/(z_e_te+z_p_te))*Einc_p*exp(1i*(ky-ky_p)*d_o);
Erif_p=((z_e_te+z_p_te)/(z_e_te-z_p_te))*Einc_p*exp(2*1i*ky_p*d_o);

%% Calcolo del campo totale


for xn = 1:nptx
    for yn = 1:npty
        Etot(xn,yn)=onde_piane_te2(x(xn),y(yn),kx_te,ky_p,kyrif_p,kytra1,kytra3,Einc_p,E1,Erif_p,E3,d_o);
    end
end

% figure(1)
% imagesc(y,x,abs(Etot));
% colorbar;



%% Plot con fplot delle funzioni ald e alp

% ylim([0,raggio])
% xlim([0,raggio])
% betd=@(ald) (mu/mu_p)*ald.*tan(ald);
% fplot(betd)
% hold on
% betp=@(alp) -(mu/mu_p)*alp.*cot(alp);
% fplot(betp)
% hold off

%% Plot della sezione trasversa 
figure(3);
title('TE');
hold on
plot(y,abs(Etot(1,:)));
plot(linspace(d_o,d_o,101),linspace(0,2,101),'.')
plot(linspace(-d_o,-d_o,101),linspace(0,2,101),'.')
grid on
hold off