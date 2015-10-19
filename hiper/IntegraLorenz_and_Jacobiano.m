%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que integra el sistema de Lorenz en el periodo de tiempo indicado.
%
% Entradas:
% ci : condici�n inicial
% T : instante m�ximo hasta el que se quiere integrar en segundos
% a, b, c, d : Par�metros del sistema
%
% Salidas:
% valores : vector soluci�n
% tiempo : vector de instantes de tiempo donde se ha evaludo la soluci�n
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez


function [valores, tiempo] = IntegraLorenz_and_Jacobiano(a_, b_, c_, d_, ci, T)
    
    global a;
    global b;
    global c;
    global d;
    
    a = a_;
    b = b_;
    c = c_;
    d = d_;

    % vector de opciones para controlar el error de integraci�n
    opciones = odeset('RelTol', 10^-7, 'AbsTol', 10^-7);
    
    % integraci�n num�rica
    [tiempo, valores] = ode45(@SistemaLorenz_and_Jacobiano, T, ci, opciones);    
end

