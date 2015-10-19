%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el oscilador de Van Der Pol forzado en el periodo de tiempo 
% indicado.
% Emplea el oscilador definido en VanDerPolForzado (ver descripción)
%
% Entradas:
% x0 : condición inicial para la primera coordenada
% y0 : condición inicial para la segunda coordenada
% z0 : condición inicial para la tercera coordenada
% T : instante máximo hasta el que se quiere integrar en segundos
% mu_ : Coeficiente de amortiguamiento
% A_ : Amplitud de la fuerza
% omega_ : Frecuencia de la fuerza
%
% Salidas:
% x  : vector solución para la primera variable
% y  : vector solución para la segunda variable
% y  : vector solución para la tercera variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez

function [valores, tiempo] = IntegraVanDerPolForzado_and_Jacobiano(mu_, A_, omega_, ci, T)
    
    global mu;
    global A;
    global omega;
    
    mu = mu_;
    A = A_;
    omega = omega_;

    % Opciones para controlar el error
    opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@VanDerPolForzado_and_Jacobiano, T, ci);
end

