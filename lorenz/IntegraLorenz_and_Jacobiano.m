%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que integra el sistema de Lorenz en el periodo de tiempo indicado.
%
% Entradas:
% v1_0 : condici�n inicial para la primera coordenada
% v2_0 : condici�n inicial para la segunda coordenada
% v3_0 : condici�n inicial para la tercera coordenada
% T : instante m�ximo hasta el que se quiere integrar en segundos
% sigma : N�mero Prandtl
% beta : Constante del sistema
% ro : N�mero de Rayleigh
%
% Salidas:
% v1 : vector soluci�n para la primera variable
% v2 : vector soluci�n para la segunda variable
% v3 : vector soluci�n para la tercera variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la soluci�n
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez


function [valores, tiempo] = IntegraLorenz_and_Jacobiano(sigma_, ro_, beta_, ci, T)
    
    global sigma;
    global ro;
    global beta;
    
    sigma = sigma_;
    beta = beta_;
    ro = ro_;

    % vector de opciones para controlar el error de integraci�n
    opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7]);
    
    % integraci�n num�rica
    [tiempo, valores] = ode45(@SistemaLorenz_and_Jacobiano, T, ci, opciones);    
end

