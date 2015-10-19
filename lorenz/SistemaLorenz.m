%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que, dado un punto (v1, v2, v3) del sistema de Lorenz
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
% Caos en circuitos electrónicos
% Borja Bordel Sánchez

function [dv] = SistemaLorenz(t, v)

    global sigma;
    global ro;
    global beta;
     

   dv = zeros(3,1);
   
   dv(1) = sigma*(v(2)-v(1));
   dv(2) = ro*v(1)-v(2)-v(1)*v(3);
   dv(3) = v(1)*v(2)-beta*v(3);
   
end
