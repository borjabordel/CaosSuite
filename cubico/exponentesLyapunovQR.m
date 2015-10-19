%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que calcula los exponentes de Lyapunov mediante la descomposición
% QR
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez

function [lambda] = exponentesLyapunovQR (R_, a, b, c, d_, C1, C2, L, ci, N)
   
    % Dimensión del sistena
    d=3;
    
    % Inicialización de variables
    Q0=eye(d);
    IC=[ci(:);Q0(:)];
    DiscardItr=20;
    Iteration=1;
    DiscardTime=DiscardItr*Iteration;
    n=0;			
    k=0;
    Sum=zeros(1,d);    
    A=[];

    %Paso de integración temporal
    TimeStep=0.01;
    %Intervalo de tiempo    
    T1=0;
    T2=T1+Iteration;
    TSpan=T1:TimeStep:T2;
    
    lambda=zeros(N, d);
    
    % Bucle principal
    while n < N 
        % Incremento del contador
        n=n+1;
        
        %Integración
        [X, ~] = IntegraChua_and_Jacobiano(R_, a, b, c, d_, C1, C2, L, IC, TSpan); 
        [rX,~]=size(X);
        
        % Extracción del sistema
        for i=1:d
            m1=d+1+(i-1)*d;
            m2=m1+d-1;
            A(:,i)=(X(rX,m1:m2))';
        end

        %Descomposición QR
        [Q,R]=qr(A);
        if T2>DiscardTime
            Q0=Q;
        else
            Q0=eye(d);
        end           
    
        %Nos protegemos frente a nulos en la diagonal principal
        permission=1;
        for i=1:d
            if R(i,i)==0
                permission=0;
                break;
            end
        end

        %Sumamos si el tiempo ha superado el transitorio 
        if (T2>DiscardTime && permission)
            k=k+1;
            T=k*Iteration;
            
            % Los exponentes de Lyapunov
            Sum=Sum+log(abs(diag(R))');
            lambda(n, :) = Sum/T;          
        end	
        
        %Actualización de variables
        ic=X(rX,1:3);
        T1=T1+Iteration;
        T2=T2+Iteration;
        TSpan=T1:TimeStep:T2;
        IC=[ic(:);Q0(:)];

    end
end