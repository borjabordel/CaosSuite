%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que, dado un punto (v1, v2, v3) del sistema de Chua
% devuelve el valor de las derivadas temporales en ese punto y una solución
% aproximada mediante el sistema linealizado
%
% El sistema de Chua original es de la forma:
%
% dv1 = (1/C1)*[(1/R)*(v1-v2)-f(v1)]
% dv2 = (1/C2)*[(1/R)*(v1-v2)+ i3]
% di3 = (1/L)*v2 
%
% con f(v) = Gb*v+0.5*(Ga-Gb)*(abs(v+E)-abs(v-E))
%
% Sin embargo, es necesario dar mayor robustez al sistema, pensando en su
% posterior integración. Para ello trabajaremos con el sistema normalizado,
% garantizando la bondad del resultado. El cambio de variable es com sigue:
%
% x = v1/E
% y = v2/E
% z = i3*R/E
% tau = t/(C2*R)
% 
% desarrollando las expresiones se llega al sistema que vamos a emplear
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

function [dv] = SistemaChua_and_Jacobiano(t, v)

    global R;           % Parámetro de control
    global Ga;          % Pendiente "fuerte" del diodo
    global Gb;          % Pendiente "suave" del diodo
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina    

    % Parámetros del sistema normalizado
    alfa = C2/C1;
    beta =  C2*R^2/L;
    m0 = Ga*R;
    m1 = Gb*R;

    dv = zeros(12,1);

    dv(1) = alfa*(v(2)-v(1)-f(v(1)));
    dv(2) = v(3)+v(1)- v(2);
    dv(3) = -beta*v(2);
    
   Jac = Jacobiano(v(1));
       
   Jac_ci= [v(4), v(7), v(10);
            v(5), v(8), v(11);
            v(6), v(9), v(12)];
        
   dv(4:12) = Jac*Jac_ci;
   
   % No linealidad
   function [i] = f(v)        
        i = m1*v+0.5*(m0-m1)*(abs(v+1)-abs(v-1));
   end

    % Cálculo del jacobiano
    function [jac] = Jacobiano(v)
        
        % Según la región lineal en la que estemos el resultado varía
        if(abs(v)<1)
            jac = [-alfa-alfa*m0  alfa 0;
                   1  -1    1;
                   0  -beta   0]; 
        else
            jac = [-alfa-alfa*m1  alfa 0;
                   1  -1    1;
                   0  -beta   0]; 
        end
    end
end
