%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que, dado un punto (x, y) del oscilador de Van Der Pol forzado
% devuelve el valor de las derivadas temporales en ese punto
%
% El oscilador de Van Der Pol Forzado, en su forma original es:
% 
% x''+mu*(1-x^2)x'+x -A*sin(omega*t) = 0
%
% donde mu es un par�metro que permite hacer el sistema disipativo (mu <
% 0), inyectarle energ�a (mu > 0) o hacerlo conservativo (mu = 0, sin
% amortiguamiento).
%
% A y omega son los par�metros del r�gimen forzado
%
% Sin embargo, para facilitar el trabajo con dicha ecuaci�n, aplicamos
% la transformaci�n de Lienard para obtener un sistema de trabajo. 
%
% Entradas:
% t : instante de tiempo en segundos en el que nos encontramos
% v : vector trimensional de (x, y)
%
% Salidas:
% dv : vector tridimensional con los valores de las derivadas (dx, dy)
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [dv] = VanDerPolForzado(t, v)

% Par�metro de amortiguamiento
global mu;

%Terminos de forzado
global omega;
global A;

% Inicializamos
dv = zeros(3,1);

% Sistema diferencial
dv(1) = v(2);
dv(2) = -v(1)+mu*(1-v(1)^2)*v(2)+A*sin(v(3));
dv(3) = omega;

end

