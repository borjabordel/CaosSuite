%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que calcula los exponentes de Lyapunov mediante la definición
% aproximada y con ayuda de la ortogonalización de Gram-Smith
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez

function [lambda] = exponentesLyapunovDef (R_, Ga_, Gb_, C1_, C2_, L_, ci, N)

    global R;           % Parámetro de control
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
    
    % Integración
    [t, x] = ode45(@SistemaChuaNormalizado,0:1:10, ci, opciones);
    [t, x] = ode45(@SistemaChuaNormalizado, 0:dt:(N*dt), [x(end, 1); x(end,2); x(end,3)], opciones);
    
    % Exponentes e inicializaciónd de otras variables
    lambda = zeros(N,3);
    w = eye(3); % IMPORTANTE INICIALIZAR CON LA IDENTIDAD
    
   % Bucle de cálculo
    for k = 1:N
        % Tomamos los valores de la señal
        x1 = x(k,1);
        x2 = x(k,2);
        x3 = x(k,3);
        
        % Jacobiano y ortogonalización
        J = (eye(3)+Jacobiano(x1)*dt);
        w = J*w;        
        % Dimensión del subespacio que ortogonalizamos
        [numFila, numCol] = size (w);

        % Matriz ortogonal
        ortoM = zeros(numFila, numCol);

        % Algoritmo de cálculo (ortonormalización)
        
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
        % Normalización de los exponentes
        lambda(k,:) = lambda(k,:)/(dt*k);
    end
 
    % Función que calcula el jacobiano de Chua Normalizado
    function [jac] = Jacobiano(v)
         
        alfa = C2/C1;
        beta =  C2*R^2/L;
        m0 = Ga*R;
        m1 = Gb*R;
        
        % Según la región lineal en la que estemos el resultado varía
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