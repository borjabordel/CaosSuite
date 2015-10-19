%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que, dado un punto (v1, v2, v3) del sistema de Chua
% devuelve el valor de las derivadas temporales en ese punto
%
% El sistema de Chua c�bico es de la forma:
%
% dv1 = (1/C1)*[(1/R)*(v1-v2)-f(v1)]
% dv2 = (1/C2)*[(1/R)*(v1-v2)+ i3]
% di3 = (1/L)*v2 
%
% con f(v) = a*v^3+b*v^2+c-*v+d
%
% Sin embargo, es necesario dar mayor robustez al sistema, pensando en su
% posterior integraci�n. Para ello trabajaremos con el sistema normalizado,
% garantizando la bondad del resultado. El cambio de variable es com sigue:
%
% x = v1
% y = v2
% z = i3*R
% tau = t/(C2*R)
% 
% desarrollando las expresiones se llega al sistema que vamos a emplear
%
% Entradas:
% t : instante de tiempo normalizado. Es del orden de xxx veces el tiempo
% deseado en segundos
% v : vector trimensional de (x, y,z)
%
% Salidas:
% dv : vector tridimensional con los valores de las derivadas (dx, dy, dz)
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [dv] = SistemaChuaNormalizado(t,v)

% Par�metros circuitales (todo en sistema internacional)

global R;           % Par�metro de control
global aa;           % T�rmino c�bico de la no-linealidad
global bb;           % T�rmino cuadr�tico de la no-linealidad
global cc;           % T�rmino lineal de la no-linealidad
global dd;           % T�rmino independiente de la no-linealidad
global C1;          % Condensador 1
global C2;          % Condensador 2
global L;           % Valor de la bobina

% Par�metros del sistema normalizado
alfa = C2/C1;
beta =  C2*R^2/L;

dv = zeros(3,1);

dv(1) = alfa*(v(2)-v(1)-R*f(v(1)));
dv(2) = v(3)+v(1)- v(2);
dv(3) = -beta*v(2);

    function [i] = f(v)        
        i = aa*v.^3+bb*v.^2+cc*v+dd;
    end

end

