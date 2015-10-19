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
% con f(v) = a*x^3+b*x^2+c*x+d
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
    global aa;           % Término cúbico de la no-linealidad
    global bb;           % Término cuadrático de la no-linealidad
    global cc;           % Término lineal de la no-linealidad
    global dd;           % Término independiente de la no-linealidad
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina

    % Parámetros del sistema normalizado
    alfa = C2/C1;
    beta =  C2*R^2/L;

    dv = zeros(12,1);

    dv(1) = alfa*(v(2)-v(1)-R*f(v(1)));
    dv(2) = v(3)+v(1)- v(2);
    dv(3) = -beta*v(2);
    
   Jac = Jacobiano(v(1));
       
   Jac_ci= [v(4), v(7), v(10);
            v(5), v(8), v(11);
            v(6), v(9), v(12)];
        
   dv(4:12) = Jac*Jac_ci;
   
   % No linealidad
    function [i] = f(v)        
        i = aa*v.^3+bb*v.^2+cc*v+dd;
    end

    % Cálculo del jacobiano
    function [jac] = Jacobiano(v)
         jac = [-alfa-alfa*R*(3*aa*v^2+2*bb*v+cc)  alfa 0;
                   1  -1    1;
                   0  -beta   0];        
    end
end
