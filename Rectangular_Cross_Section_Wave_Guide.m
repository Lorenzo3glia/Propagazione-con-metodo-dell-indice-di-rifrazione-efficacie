clear all
close all

epsilon0=8.854e-12;
mu0=4*pi*1.e-7;

f=10e9;
c0=1/sqrt(epsilon0*mu0);
w = 2*pi*f;

epsilon = 1*epsilon0;
epsilon_p = 2*epsilon0;


mu = 1*mu0;
mu_p = 1*mu0;

lambda=c0/f;

n=sqrt((epsilon*mu)/(epsilon_p*mu_p));

k=w.*sqrt(epsilon*mu);
k_p=w.*sqrt(epsilon_p*mu_p);

Einc_p = 1;
Hinc_p = 1; 

zita=sqrt(mu/epsilon)
zita_p=sqrt(mu_p/epsilon_p)



%% Dichiarazione simboli discontinuità verticale
%Il pedice var_v indica che sto facendo riferimento ad un dato considerato
%nella trattazione verticale della discontinuità.

d_v=0.1;%1.4*lambda; %d_v= a sugli appunti 

%% Dichiarazione simboli discontinuità orizzontale
%Il pedice var_o indica che sto facendo riferimento ad un dato considerato
%nella trattazione orizzontale della discontinuità.

d_o=0.1;%0.6*lambda; %d_o= b sugli appunti 


%%%%%%%%%%%%%%% Per i plot %%%%%%%%%
nptx=1001;
npty=1001;
x=linspace(-2*d_v,2*d_v,nptx);
y=linspace(-2*d_o,2*d_o,npty);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1 step(verticale) associato alla polarizzazione verticale
%k_verticale_componente_primo
k_o_y_p_0=0;
k_v_p=sqrt(k_p^2-k_o_y_p_0^2);

polarizzazione='Tm';


%% For per il calcolo di alpha e beta
N_v=ceil(k_v_p*d_v*sqrt(1-n^2)/(pi/2))
alpha_v_v=zeros(1,N_v);
beta_v_v=zeros(1,N_v);
    for I = 1:N_v
       [alpha_v,beta_v]=AlphaBeta(k_v_p,n,polarizzazione,d_v,mu,mu_p,epsilon,epsilon_p,I);
       alpha_v_v(I)=alpha_v;
       beta_v_v(I)=beta_v;
    end


% disp('Alpa_v_v')
% disp(alpha_v_v(:))
% disp('beta_v_v')
% disp(beta_v_v(:))

%% SCELTA DI ALPHA E BETA
StringaTM = sprintf('Seleziona il modo TM che vuoi utilizzare da 1 a %d: ', N_v);
ModoSelTM=input(StringaTM)

 alpha_v=alpha_v_v(ModoSelTM);
 
%Da inserire un while che non faccia uscire finquando non si fa una scelta
%consona e quindi un numero compresto tra 1 e il valore massimo



k_v_x_p(1)=alpha_v/d_v;

%k_v_x(1)=-1i*beta_v/d_v %Mi devo ricordare di come era definito inizialmente
%L'istruzione soprastante la userò solo alla fine, di conseguenza non è
%necessario che la definisca ora


%Valutazione del primo elemento del kz
kz(1)=sqrt(k_v_p^2-k_v_x_p(1)^2)

%% Implementazione del secondo step (orizzontale) associato alla polarizzazione te
%k_orizzontale_componente_primo
%epsilon_p=2*epsilon0;
%mu_p=mu;

polarizzazione='Te';

%% For per il calcolo di alpha e beta

k_o_p=sqrt(k_p^2-k_v_x_p(1)^2);
N_o=ceil(k_o_p*d_o*sqrt(1-n^2)/(pi/2))
alpha_o_v=zeros(1,N_o);
beta_o_v=zeros(1,N_o);

for I = 1:N_o
    [alpha_o,beta_o]=AlphaBeta(k_o_p,n,polarizzazione,d_o,mu,mu_p,epsilon,epsilon_p,I);
    alpha_o_v(I)=alpha_o;
    beta_o_v(I)=beta_o;
end


% disp('Alpa_o_v')
% disp(alpha_o_v(:))
% disp('beta_o_v')
% disp(beta_o_v(:))

%% Scelta di Alpha e Beta
StringaTE = sprintf('Seleziona il modo TE che vuoi utilizzare da 1 a %d: ', N_o);
ModoSelTE=input(StringaTE)

 alpha_o=alpha_o_v(ModoSelTE);
% beta_o=beta_o_v(ModoSelTE);
% disp('Le coordinate selezionate sono: ');
% disp(['Alpha: ', num2str(alpha_o)]);
% disp(['Beta: ', num2str(beta_o)]);

%Da inserire un while che non faccia uscire finquando non si fa una scelta
%consona e quindi un numero compresto tra 1 e il valore massimo

k_o_y_p(1)=alpha_o/d_o;
%k_o_y(1)=-1i*beta_o/d_o %Mi devo ricordare di come era definito inizialmente
%L'istruzione soprastante la userò solo alla fine, di conseguenza non è
%necessario che la definisca ora


%% Calcolo
kz(1)=sqrt(k_o_p^2-k_o_y_p(1)^2)



%% -------------------------------------------------------------------------

err_conv=1;
Index=1;

%% Ciclo while


while err_conv>1e-10
Index=Index+1;
k_v_p=sqrt(k_p^2-k_o_y_p(Index-1)^2); 
polarizzazione='Tm';
[alpha_v,beta_v]=AlphaBeta(k_v_p,n,polarizzazione,d_v,mu,mu_p,epsilon,epsilon_p,ModoSelTM);



if length(alpha_v)==0
    kz(Index)=0
   break
end


% disp('Alpa_v_v')
% disp(alpha_v_v(:))
% disp('beta_v_v')
% disp(beta_v_v(:))

k_v_x_p(Index)=alpha_v/d_v;

%k_v_x(1)=-1i*beta_v/d_v %Mi devo ricordare di come era definito inizialmente
%L'istruzione soprastante la userò solo alla fine, di conseguenza non è
%necessario che la definisca ora

%Valutazione del primo elemento del kz
kz(Index)=sqrt(k_v_p^2-k_v_x_p(Index)^2);

%% Implementazione del secondo step (orizzontale) associato alla polarizzazione te
%k_orizzontale_componente_primo
polarizzazione='Te';

%% For per il calcolo di alpha e beta

k_o_p=sqrt(k_p^2-k_v_x_p(Index)^2);

[alpha_o,beta_o]=AlphaBeta(k_o_p,n,polarizzazione,d_o,mu,mu_p,epsilon,epsilon_p,ModoSelTE)


if length(alpha_o)==0
    kz(Index)=0;
    break
end

% disp('Alpa_o_v')
% disp(alpha_o_v(:))
% disp('beta_o_v')
% disp(beta_o_v(:))

k_o_y_p(Index)=alpha_o/d_o;
%k_o_y(1)=-1i*beta_o/d_o %Mi devo ricordare di come era definito inizialmente
%L'istruzione soprastante la userò solo alla fine, di conseguenza non è
%necessario che la definisca ora


%% Calcolo
kz(Index)=sqrt(k_o_p^2-k_o_y_p(Index)^2);

%% Aggiorniamo l'errore di convergenza
err_conv=abs(kz(Index)-kz(Index-1))/kz(Index-1)
end

if kz(Index)==0
    warning('Il modo non è propagativo')
end

kz=kz(Index);
%% Calcolo dei campi




%Caso Te
ky=-1i*(beta_o/d_o);
ky_p=k_o_y_p(Index);
RoutineTE;


%Caso Tm
kx=-1i*(beta_v/d_v);   
kx_p=k_v_x_p(Index);
RoutineTM;

%1 non è un campo elettrico perche sto moltiplicando un campo elettrico per
%un campo magnetico , IL VALORE ASSOLUTO DI QUESTA QUANTITà A MENO DI UNA
%COSTANTE DI  PROPORZIONALITA CHE HA UNA DIMENSIONE , IL MODULO DI QUESTA
%QUANTITà CORRSISPONDE AL CAMPO ELETTRICO TOTALE NELLA GUIDA.

Results=Etot.*Htot;
figure(1)
imagesc(y,x,abs(Results.'));
axis image;

%Da confrontare i kz kz_p con i ky ky_p


