%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que calcula los exponentes de Lyapunov mediante la definici�n
% aproximada y con ayuda de la ortogonalizaci�n de Gram-Smith
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [lambda] = exponentesLyapunovDef (R_, Ga_, Gb_, C1_, C2_, L_, ci, N)

    global R;           % Par�metro de control
    global Ga;          % Pendiente "fuerte" del diodo
    global Gb;          % Pendiente "suave" del diodo
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina
    
    R = R_;
    Ga = Ga_;
    Gb = Gb_;
    C1 = C1_;
    C2 = C2_;
    L = L_;
    
    %Opciones de integracion
    opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7]);
    
    % Salto temporal para evaluar las respuestas
    dt = 0.01;
    
    % Integraci�n
    [t, x] = ode45(@SistemaChuaNormalizado,0:1:10, ci, opciones);
    [t, x] = ode45(@SistemaChuaNormalizado, 0:dt:(N*dt), [x(end, 1); x(end,2); x(end,3)], opciones);
    
    % Exponentes e inicializaci�nd de otras variables
    lambda = zeros(N,3);
    w = eye(3); % IMPORTANTE INICIALIZAR CON LA IDENTIDAD
    
   % Bucle de c�lculo
    for k = 1:N
        % Tomamos los valores de la se�al
        x1 = x(k,1);
        x2 = x(k,2);
        x3 = x(k,3);
        
        % Jacobiano y ortogonalizaci�n
        J = (eye(3)+Jacobiano(x1)*dt);
        w = J*w;        
        % Dimensi�n del subespacio que ortogonalizamos
        [numFila, numCol] = size (w);

        % Matriz ortogonal
        ortoM = zeros(numFila, numCol);

        % Algoritmo de c�lculo (ortonormalizaci�n)
        
        % Primer elemento
        ortoM(:, 1) = w (:, 1);
        lambda(k,1) = lambda(k,1)+log(norm(ortoM(:,1)));
        ortoM(:, 1) = ortoM(:, 1)/norm(ortoM(:, 1)); 
        %Normalizamos para estabilizar el algoritmo
        
        % Bucle
        for i = 2:numCol
            ortoM(:, i) = w (:, i);
            for j = 1: i-1
                ortoM(:, i) = ortoM(:,i) - dot(ortoM(:,j),w (:,i))* ortoM(:,j);
            end
            lambda(k,i) = lambda(k,i)+log(norm(ortoM(:,i)));
            %Normalizamos para estabilizar el algoritmo
            ortoM(:, i) = ortoM(:, i)/norm(ortoM(:, i));
        end	
        
        w = ortoM;
        % Normalizaci�n de los exponentes
        lambda(k,:) = lambda(k,:)/(dt*k);
    end
 
    % Funci�n que calcula el jacobiano de Chua Normalizado
    function [jac] = Jacobiano(v)
         
        alfa = C2/C1;
        beta =  C2*R^2/L;
        m0 = Ga*R;
        m1 = Gb*R;
        
        % Seg�n la regi�n lineal en la que estemos el resultado var�a
        if(abs(v)<1)
            jac = [-alfa-alfa*m0  alfa 0;
                   1  -1    1;
                   0  -beta   0]; 
        else
            jac = [-alfa-alfa*m1  alfa 0;
                   1  -1    1;
                   0  -beta   0]; 
        end
    end
end