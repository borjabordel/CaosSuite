%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que, dado un punto (v1, v2, v3) del sistema de Lorenz
% hipercaótico
% devuelve el valor de las derivadas temporales en ese punto
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

    global a;
    global b;
    global c;
    global d;
     
   dv = zeros(20,1);
   
   % Ecuaciones diferenciales
   dv(1) = d*(v(2)-v(1))+2*v(4);
   dv(2) = 5*v(1)+c*v(2)-4*v(1)*v(3);
   dv(3) = v(1)*v(2)-3*v(3);
   dv(4) = -b*v(4)-a*(v(1)-v(2));
   
   % Jacoabiano
   Jac = [-d, d, 0 2 ; 5-4*v(3) c -4*v(1) 0 ; v(2)  v(1) -3 0 ; -a a 0 -b];
       
   Jac_ci= [v(5), v(9), v(13), v(17);
            v(6), v(10), v(14), v(18);
            v(7), v(11), v(15), v(19);
            v(8), v(12), v(16), v(20)];
   
   % Nuevos valores linealizados
   dv(5:20) = Jac*Jac_ci;

end
