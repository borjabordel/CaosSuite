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

function [dv] = SistemaLorenz_and_Jacobiano(t, v)

    global sigma;
    global ro;
    global beta;
     
   dv = zeros(12,1);
   
   % Ecuaciones diferenciales
   dv(1) = sigma*(v(2)-v(1));
   dv(2) = ro*v(1)-v(2)-v(1)*v(3);
   dv(3) = v(1)*v(2)-beta*v(3);
   
   % Jacoabiano
   Jac = [-sigma, sigma,     0;
           ro-v(3),    -1,    -v(1);
           v(2),     v(1),  -beta];
       
   Jac_ci= [v(4), v(7), v(10);
            v(5), v(8), v(11);
            v(6), v(9), v(12)];
   
   % Nuevos valores linealizados
   dv(4:12) = Jac*Jac_ci;

end
