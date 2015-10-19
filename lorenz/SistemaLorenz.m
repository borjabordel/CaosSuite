%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que, dado un punto (v1, v2, v3) del sistema de Lorenz
% devuelve el valor de las derivadas temporales en ese punto
%
% El sistema de Chua original es de la forma:
%
%  dv(1) = sigma(v(2)-v(1));
%  dv(2) = ro*v(1)-v(2)-v(1)*v(3);
%  dv(3) = v(1)*v(2)-beta*v(3);
%
% Entradas:
% t : instante de tiempo en segundos
% v : vector trimensional de (x, y,z)
%
% Salidas:
% dv : vector tridimensional con los valores de las derivadas (dx, dy, dz)
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [dv] = SistemaLorenz(t, v)

    global sigma;
    global ro;
    global beta;
     

   dv = zeros(3,1);
   
   dv(1) = sigma*(v(2)-v(1));
   dv(2) = ro*v(1)-v(2)-v(1)*v(3);
   dv(3) = v(1)*v(2)-beta*v(3);
   
end
