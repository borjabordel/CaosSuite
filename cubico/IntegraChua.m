%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el sistema de Chua en el periodo de tiempo indicado.
% Emplea el sistema normalizado definido en SistemaChua (ver descripción)
%
% Entradas:
% v1_0 : condición inicial para la primera coordenada
% v2_0 : condición inicial para la segunda coordenada
% v3_0 : condición inicial para la tercera coordenada
% T : instante máximo hasta el que se quiere integrar en segundos
% R_ : Resistencia de control del circuito
% a_, b_, c_, d_ : parámetros de la no linealidad cúbica
% C1_ : Condensador pequeño del circuito
% C2_ : Condensador grande del circuito
% L_ : Bobina
%
% Salidas:
% v1 : vector solución para la primera variable
% v2 : vector solución para la segunda variable
% v3 : vector solución para la tercera variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [v1, v2, v3, tiempo] = IntegraChua(R_, a_, b_, c_, d_, C1_, C2_, L_, v1_0, v2_0, v3_0, T)
    
    global R;           % Parámetro de control
    global aa;           % Término cúbico de la no-linealidad
    global bb;           % Término cuadrático de la no-linealidad
    global cc;           % Término lineal de la no-linealidad
    global dd;           % Término independiente de la no-linealidad
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina
    
    R = R_;
    aa = a_;          
    bb = b_;
    cc = c_;          
    dd = d_;
    C1 = C1_;          
    C2 = C2_;          
    L = L_;
    
    % vector de opciones para controlar el error de integración
    opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaChuaNormalizado, [0 T], [v1_0 v2_0 v3_0], opciones);
    
    % Separación de las columnas de la matriz solución en vectores
    v1 = valores(:,1);
    v2 = valores(:,2);
    v3 = valores(:,3);
end

