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

function [lambda] = exponentesLyapunovDef (alfa_, beta_, gamma_, ci, N)

    global alfa;
    global beta;
    global gamma;
    
    alfa = alfa_;
    beta = beta_;
    gamma = gamma_;
    
    %Opciones de integracion
    opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7]);
    
    % Salto temporal para evaluar las respuestas
    dt = 0.01;
    
    % Integración
    [t, x] = ode45(@SistemaPV1,0:1:10, ci, opciones);
    [t, x] = ode45(@SistemaPV1, 0:dt:(N*dt), [x(end, 1); x(end,2); x(end,3)], opciones);
    
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
        J = (eye(3)+[0 -alfa 0; beta 0 2*x3 ; 1 2  -gamma]*dt);
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
 end