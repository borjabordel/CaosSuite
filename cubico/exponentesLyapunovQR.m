%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que calcula los exponentes de Lyapunov mediante la descomposici�n
% QR
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [lambda] = exponentesLyapunovQR (R_, a, b, c, d_, C1, C2, L, ci, N)
   
    % Dimensi�n del sistena
    d=3;
    
    % Inicializaci�n de variables
    Q0=eye(d);
    IC=[ci(:);Q0(:)];
    DiscardItr=20;
    Iteration=1;
    DiscardTime=DiscardItr*Iteration;
    n=0;			
    k=0;
    Sum=zeros(1,d);    
    A=[];

    %Paso de integraci�n temporal
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
        
        %Integraci�n
        [X, ~] = IntegraChua_and_Jacobiano(R_, a, b, c, d_, C1, C2, L, IC, TSpan); 
        [rX,~]=size(X);
        
        % Extracci�n del sistema
        for i=1:d
            m1=d+1+(i-1)*d;
            m2=m1+d-1;
            A(:,i)=(X(rX,m1:m2))';
        end

        %Descomposici�n QR
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
        
        %Actualizaci�n de variables
        ic=X(rX,1:3);
        T1=T1+Iteration;
        T2=T2+Iteration;
        TSpan=T1:TimeStep:T2;
        IC=[ic(:);Q0(:)];

    end
end