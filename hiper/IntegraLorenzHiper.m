%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que integra el sistema de Lorenz  hipercaótico en el periodo de tiempo indicado.
%
% Entradas:
% a_, b_, c_, d_ : Parámetros del sistema hipercaótico
% v1_0 : condición inicial para la primera coordenada
% v2_0 : condición inicial para la segunda coordenada
% v3_0 : condición inicial para la tercera coordenada
% v4_0 : condición inicial para la cuarta coordenada
% T : instante máximo hasta el que se quiere integrar en segundos
%
% Salidas:
% v1 : vector solución para la primera variable
% v2 : vector solución para la segunda variable
% v3 : vector solución para la tercera variable
% v4 : vector solución para la cuarta variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la solución
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez


function [v1, v2, v3, v4, tiempo] = IntegraLorenzHiper(a_, b_, c_, d_, v1_0, v2_0, v3_0, v4_0, T)
    
    global a;
    global b;
    global c;
	global d;
    
    a = a_;
    b = b_;
    c = c_;
	d = d_;

    % vector de opciones para controlar el error de integración
    opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7, 10^-7]);
    
    % integración numérica
    [tiempo, valores] = ode45(@SistemaLorenzHiper, [0 T], [v1_0 v2_0 v3_0 v4_0], opciones);
    
    % Separación de las columnas de la matriz solución en vectores
    v1 = valores(:,1);
    v2 = valores(:,2);
    v3 = valores(:,3);
	v4 = valores(:,4);
end

