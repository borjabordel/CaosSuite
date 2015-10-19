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
% sigma : Número Prandtl
% beta : Constante del sistema
% ro : Número de Rayleigh
%
% Salidas:
% v1 : vector solución para la primera variable
% v2 : vector solución para la segunda variable
% v3 : vector solución para la tercera variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [valores, tiempo] = IntegraLorenz_and_Jacobiano(sigma_, ro_, beta_, ci, T)
    
    global sigma;
    global ro;
    global beta;
    
    sigma = sigma_;
    beta = beta_;
    ro = ro_;

    % vector de opciones para controlar el error de integración
    opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaLorenz_and_Jacobiano, T, ci, opciones);    
end

