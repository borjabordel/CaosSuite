%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el sistema PV2 en el periodo de tiempo indicado.
% Emplea el sistema normalizado definido en SistemaPV2_and_Jacobiano (ver descripción)
% También genera una solución aproximada mediante el sistema linealizado
%
% Entradas:
% ci : condiciones iniciales de la integración
% T : intervalo temporal en que deseamos integrar
% alfa_, beta_ : Parámetros del sistema PV2
%
% Salidas:
% valores : matriz con el resultado de la integración
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [valores, tiempo] = IntegraPV2_and_Jacobiano(alfa_, beta_, ci, T)
    
    global alfa;           
    global beta;             
    
    alfa = alfa_;
    beta = beta_;

    % vector de opciones para controlar el error de integración
   opciones = odeset('RelTol', 10^-7, 'AbsTol', [10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaPV2_and_Jacobiano, T, ci, opciones);
end

