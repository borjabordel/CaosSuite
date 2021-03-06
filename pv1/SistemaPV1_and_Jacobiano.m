%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que, dado un punto (v1, v2, v3) del sistema PV1
% devuelve el valor de las derivadas temporales en ese punto y una solución
% aproximada mediante el sistema linealizado
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

function [dv] = SistemaPV1_and_Jacobiano(t, v)

    global alfa;
    global beta;
    global gamma;

    dv = zeros(12,1);

   dv(1) = -alfa*v(2);
   dv(2) = beta*v(1)+v(3)^2;
   dv(3) = 1+v(1)+2*v(2)-gamma*v(3);
    
   Jac = [0 -alfa 0 ; beta 0 2*v(3) ; 1 2 -gamma];
       
   Jac_ci= [v(4), v(7), v(10);
            v(5), v(8), v(11);
            v(6), v(9), v(12)];
        
   dv(4:12) = Jac*Jac_ci;
end
