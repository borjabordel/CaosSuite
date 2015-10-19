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

function [lambda] = exponentesLyapunovDef (sigma_, beta_, ro_, ci, N)

    global sigma;
    global beta;
    global ro;
    
    sigma = sigma_;
    beta = beta_;
    ro = ro_;
    
    %Opciones de integracion
    opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7]);
    
    % Salto temporal para evaluar las respuestas
    dt = 0.01;
    
    % Integraci�n
    [t, x] = ode45(@SistemaLorenz,0:1:10, ci, opciones);
    [t, x] = ode45(@SistemaLorenz, 0:dt:(N*dt), [x(end, 1); x(end,2); x(end,3)], opciones);
    
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
        J = (eye(3)+[-sigma, sigma, 0; ro-x3, -1 -x1; x2, x1, -beta]*dt);
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
 end