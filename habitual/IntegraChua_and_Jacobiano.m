%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que integra el sistema de Chua en el periodo de tiempo indicado.
% Emplea el sistema normalizado definido en SistemaChua (ver descripci�n)
% Tambi�n genera una soluci�n aproximada mediante el sistema linealizado
%
% Entradas:
% ci : condiciones iniciales de la integraci�n
% T : intervalo temporal en que deseamos integrar
% R_ : par�metro de control
% E_ : Tensi�n de codo de la no linealidad
% Ga_ : Pediente suave de la no linealidad
% Gb_ : Pendiente fuerte de la no linealidad
% C1_ : Condensador peque�o 
% C2_ : Condensador grande
% L_ : bobina
%
% Salidas:
% valores : matriz con el resultado de la integraci�n
% tiempo : vector de instantes de tiempo donde se ha evaludo la soluci�n
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez


function [valores, tiempo] = IntegraChua_and_Jacobiano(R_, E_, Ga_, Gb_, C1_, C2_, L_, ci, T)
    
    global R;           % Par�metro de control
    global Ga;          % Pendiente "fuerte" del diodo
    global Gb;          % Pendiente "suave" del diodo
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina
    global E;           % Codo de la no linealidad
    
    R = R_;
    Ga = Ga_;          
    Gb = Gb_;         
    C1 = C1_;          
    C2 = C2_;          
    L = L_;
    E = E_;

    % vector de opciones para controlar el error de integraci�n
   opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7, 10^-6, 10^-6, 10^-7, 10^-6, 10^-6, 10^-7, 10^-6, 10^-6, 10^-7]);
    
    % integraci�n num�rica
    [tiempo, valores] = ode45(@SistemaChua_and_Jacobiano, T, ci);
end

