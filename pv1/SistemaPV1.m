%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que, dado un punto (v1, v2, v3) del sistema PV1
% devuelve el valor de las derivadas temporales en ese punto
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

function [dv] = SistemaPV1(t, v)

    global alfa;
    global beta;
    global gamma;    

   dv = zeros(3,1);
   
   dv(1) = -alfa*v(2);
   dv(2) = beta*v(1)+v(3)^2;
   dv(3) = 1+v(1)+2*v(2)-gamma*v(3);
   
end
