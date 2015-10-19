%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que, dado un punto (v1, v2, v3, v4) del sistema de Lorenz
% hiperca�tico
% devuelve el valor de las derivadas temporales en ese punto
%
% Entradas:
% t : instante de tiempo en segundos
% v : vector trimensional de (x, y, z, w)
%
% Salidas:
% dv : vector cuatri-dimensional con los valores de las derivadas (dx, dy, dz, dw)
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [dv] = SistemaLorenzHiper(t, v)

    global a;
    global b;
    global c;
	global d;
     

   dv = zeros(4,1);
   
   dv(1) = d*(v(2)-v(1))+2*v(4);
   dv(2) = 5*v(1)+c*v(2)-4*v(1)*v(3);
   dv(3) = v(1)*v(2)-3*v(3);
   dv(4) = -b*v(4)-a*(v(1)-v(2));
   
end
