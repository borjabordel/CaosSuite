%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que integra el sistema de Chua en el periodo de tiempo indicado.
% Emplea el sistema normalizado definido en SistemaChua (ver descripci�n)
%
% Entradas:
% v1_0 : condici�n inicial para la primera coordenada
% v2_0 : condici�n inicial para la segunda coordenada
% v3_0 : condici�n inicial para la tercera coordenada
% T : instante m�ximo hasta el que se quiere integrar en segundos
% R_ : Resistencia de control del circuito
% a_, b_, c_, d_ : par�metros de la no linealidad c�bica
% C1_ : Condensador peque�o del circuito
% C2_ : Condensador grande del circuito
% L_ : Bobina
%
% Salidas:
% v1 : vector soluci�n para la primera variable
% v2 : vector soluci�n para la segunda variable
% v3 : vector soluci�n para la tercera variable
% tiempo : vector de instantes de tiempo donde se ha evaludo la soluci�n
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez


function [v1, v2, v3, tiempo] = IntegraChua(R_, a_, b_, c_, d_, C1_, C2_, L_, v1_0, v2_0, v3_0, T)
    
    global R;           % Par�metro de control
    global aa;           % T�rmino c�bico de la no-linealidad
    global bb;           % T�rmino cuadr�tico de la no-linealidad
    global cc;           % T�rmino lineal de la no-linealidad
    global dd;           % T�rmino independiente de la no-linealidad
    global C1;          % Condensador 1
    global C2;          % Condensador 2
    global L;           % Valor de la bobina
    
    R = R_;
    aa = a_;          
    bb = b_;
    cc = c_;          
    dd = d_;
    C1 = C1_;          
    C2 = C2_;          
    L = L_;
    
    % vector de opciones para controlar el error de integraci�n
    opciones = odeset('RelTol', 10^-6, 'AbsTol', [10^-6, 10^-6, 10^-7]);
    
    % integraci�n num�rica
    [tiempo, valores] = ode45(@SistemaChuaNormalizado, [0 T], [v1_0 v2_0 v3_0], opciones);
    
    % Separaci�n de las columnas de la matriz soluci�n en vectores
    v1 = valores(:,1);
    v2 = valores(:,2);
    v3 = valores(:,3);
end

