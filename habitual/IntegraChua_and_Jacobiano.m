%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el sistema de Chua en el periodo de tiempo indicado.
% Emplea el sistema normalizado definido en SistemaChua (ver descripción)
% También genera una solución aproximada mediante el sistema linealizado
%
% Entradas:
% ci : condiciones iniciales de la integración
% T : intervalo temporal en que deseamos integrar
% R_ : parámetro de control
% E_ : Tensión de codo de la no linealidad
% Ga_ : Pediente suave de la no linealidad
% Gb_ : Pendiente fuerte de la no linealidad
% C1_ : Condensador pequeño 
% C2_ : Condensador grande
% L_ : bobina
%
% Salidas:
% valores : matriz con el resultado de la integración
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [valores, tiempo] = IntegraChua_and_Jacobiano(R_, E_, Ga_, Gb_, C1_, C2_, L_, ci, T)
    
    global R;           % Parámetro de control
    global Ga;          % Pendiente "fuerte" del diodo
    global Gb;          % Pendiente "suave" del diodo
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina
    global E;           % Codo de la no linealidad
    
    R = R_;
    Ga = Ga_;          
    Gb = Gb_;         
    C1 = C1_;          
    C2 = C2_;          
    L = L_;
    E = E_;

    % vector de opciones para controlar el error de integración
   opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7, 10^-6, 10^-6, 10^-7, 10^-6, 10^-6, 10^-7, 10^-6, 10^-6, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaChua_and_Jacobiano, T, ci);
end

