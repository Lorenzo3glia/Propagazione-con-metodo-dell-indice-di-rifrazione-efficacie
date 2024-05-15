function [alpha,beta] = AlphaBeta(k_p,n,polarizzazione,d,mu,mu_p,epsilon,epsilon_p,I)
if polarizzazione=='Tm'
    % Nel primo caso vado a valutare i valori di alpha e beta nel caso della
    % polarizzazione tm che noi abbiamo identificato nel caso della
    % discontinuità verticale

    %     N=ceil(k_p*d*sqrt(1-n^2)/(pi/2))
    %
    %     for I = 1:N
    %         if mod(I, 2) == 0  % Se I è pari
    %             alpha_v(I) = findzero('alp', pi*(I-1)/2, pi*I/2,1e-3,epsilon,epsilon_p,k_p,d,n);
    %         else               % Se I è dispari
    %             alpha_v(I) = findzero('ald', pi*(I-1)/2, pi*I/2,1e-3,epsilon,epsilon_p,k_p,d,n);
    %         end
    %     end

    %% -----------MODIFICHE PER CICLO ESTERNO------------
%[k_p*d*sqrt(1-n^2) pi*(I-1)/2*(1+1e-10) pi*I/2*(1-1e-10)]
    if mod(I, 2) == 0  % Se I è pari
        alpha = findzero('alp', pi*(I-1)/2*(1+1e-10), pi*I/2*(1-1e-10),1e-3,epsilon,epsilon_p,k_p,d,n);
    else               % Se I è dispari
        alpha = findzero('ald', pi*(I-1)/2*(1+1e-10), pi*I/2*(1-1e-10),1e-3,epsilon,epsilon_p,k_p,d,n);
    end

    %% Valutazione delle coordinate beta

    raggio=k_p*d*sqrt(1-n^2);
    beta=sqrt(raggio^2 - alpha^2);

elseif polarizzazione=='Te'

    %     N=ceil(k_p*d*sqrt(1-n^2)/(pi/2))
    %
    %     for I = 1:N
    %         if mod(I, 2) == 0  % Se I è pari
    %             alpha_v(I) = findzero('alp', pi*(I-1)/2, pi*I/2,1e-3,mu,mu_p,k_p,d,n);
    %         else               % Se I è dispari
    %             alpha_v(I) = findzero('ald', pi*(I-1)/2, pi*I/2,1e-3,mu,mu_p,k_p,d,n);
    %         end
    %     end

    %% -----------MODIFICHE PER CICLO ESTERNO------------

    if mod(I, 2) == 0  % Se I è pari
        alpha = findzero('alp', pi*(I-1)/2*(1+1e-10), pi*I/2*(1-1e-10),1e-3,mu,mu_p,k_p,d,n);
    else               % Se I è dispari
        alpha = findzero('ald', pi*(I-1)/2*(1+1e-10), pi*I/2*(1-1e-10),1e-3,mu,mu_p,k_p,d,n);
    end

    %% Valutazione delle coordinate di alpha e beta

    raggio=k_p*d*sqrt(1-n^2);
    beta=sqrt(raggio^2 - alpha^2);

end


end


