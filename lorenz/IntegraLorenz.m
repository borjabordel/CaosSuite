%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el sistema de Lorenz en el periodo de tiempo indicado.
%
% Entradas:
% v1_0 : condición inicial para la primera coordenada
% v2_0 : condición inicial para la segunda coordenada
% v3_0 : condición inicial para la tercera coordenada
% T : instante máximo hasta el que se quiere integrar en segundos
% sigma_ : Número Prandtl
% beta_ : Constante del sistema
% ro_ : Número de Rayleigh
%
% Salidas:
% v1 : vector solución para la primera variable
% v2 : vector solución para la segunda variable
% v3 : vector solución para la tercera variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [v1, v2, v3, tiempo] = IntegraLorenz(sigma_, ro_, beta_, v1_0, v2_0, v3_0, T)
    
    global sigma;
    global ro;
    global beta;
    
    sigma = sigma_;
    beta = beta_;
    ro = ro_;

    % vector de opciones para controlar el error de integración
    opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaLorenz, [0 T], [v1_0 v2_0 v3_0], opciones);
    
    % Separación de las columnas de la matriz solución en vectores
    v1 = valores(:,1);
    v2 = valores(:,2);
    v3 = valores(:,3);
end

