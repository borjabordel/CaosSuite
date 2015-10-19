%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el sistema de Lorenz en el periodo de tiempo indicado.
%
% Entradas:
% ci : condición inicial
% T : instante máximo hasta el que se quiere integrar en segundos
% a, b, c, d : Parámetros del sistema
%
% Salidas:
% valores : vector solución
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [valores, tiempo] = IntegraLorenz_and_Jacobiano(a_, b_, c_, d_, ci, T)
    
    global a;
    global b;
    global c;
    global d;
    
    a = a_;
    b = b_;
    c = c_;
    d = d_;

    % vector de opciones para controlar el error de integración
    opciones = odeset('RelTol', 10^-7, 'AbsTol', 10^-7);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaLorenz_and_Jacobiano, T, ci, opciones);    
end

