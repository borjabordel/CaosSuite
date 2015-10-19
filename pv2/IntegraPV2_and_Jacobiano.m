%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que integra el sistema PV2 en el periodo de tiempo indicado.
% Emplea el sistema normalizado definido en SistemaPV2_and_Jacobiano (ver descripci�n)
% Tambi�n genera una soluci�n aproximada mediante el sistema linealizado
%
% Entradas:
% ci : condiciones iniciales de la integraci�n
% T : intervalo temporal en que deseamos integrar
% alfa_, beta_ : Par�metros del sistema PV2
%
% Salidas:
% valores : matriz con el resultado de la integraci�n
% tiempo : vector de instantes de tiempo donde se ha evaludo la soluci�n
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez


function [valores, tiempo] = IntegraPV2_and_Jacobiano(alfa_, beta_, ci, T)
    
    global alfa;           
    global beta;             
    
    alfa = alfa_;
    beta = beta_;

    % vector de opciones para controlar el error de integraci�n
   opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7]);
    
    % integraci�n num�rica
    [tiempo, valores] = ode45(@SistemaPV2_and_Jacobiano, T, ci, opciones);
end

