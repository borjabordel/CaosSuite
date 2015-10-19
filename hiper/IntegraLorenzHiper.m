%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que integra el sistema de Lorenz  hiperca�tico en el periodo de tiempo indicado.
%
% Entradas:
% a_, b_, c_, d_ : Par�metros del sistema hiperca�tico
% v1_0 : condici�n inicial para la primera coordenada
% v2_0 : condici�n inicial para la segunda coordenada
% v3_0 : condici�n inicial para la tercera coordenada
% v4_0 : condici�n inicial para la cuarta coordenada
% T : instante m�ximo hasta el que se quiere integrar en segundos
%
% Salidas:
% v1 : vector soluci�n para la primera variable
% v2 : vector soluci�n para la segunda variable
% v3 : vector soluci�n para la tercera variable
% v4 : vector soluci�n para la cuarta variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la soluci�n
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez


function [v1, v2, v3, v4, tiempo] = IntegraLorenzHiper(a_, b_, c_, d_, v1_0, v2_0, v3_0, v4_0, T)
    
    global a;
    global b;
    global c;
	global d;
    
    a = a_;
    b = b_;
    c = c_;
	d = d_;

    % vector de opciones para controlar el error de integraci�n
    opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7, 10^-7]);
    
    % integraci�n num�rica
    [tiempo, valores] = ode45(@SistemaLorenzHiper, [0 T], [v1_0 v2_0 v3_0 v4_0], opciones);
    
    % Separaci�n de las columnas de la matriz soluci�n en vectores
    v1 = valores(:,1);
    v2 = valores(:,2);
    v3 = valores(:,3);
	v4 = valores(:,4);
end

