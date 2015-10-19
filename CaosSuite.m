%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Programa para el estudio y análisis de los sistemás caóticos del
% proyecto. En especial exponentes de Lyapunov y espacio de fases.

% Control del sistema de estudio
global sistema;

% Variables de Chua habitual/cubico
global C2;
global R;

% Variables de Van Der pol
global mu;
global A;
global omega;

% Variables de Lorenz
global sigma;
global ro;

%Variables de PV1
global gamma;

% Variables de PV2
global beta;
global alfa;

% Variables de Lorenz
global a;
global d;

% Otras variables
global Nf;
global cerrojo;
global metodo;

% Inicialización
sistema = 0;
Nf = 500;
R = 1540;
C2 = 10^-8;
mu = 3;
A = 2.5;
omega = 6.5;
sigma = 10;
ro = 30;
gamma = 2;
beta = 1.5;
alfa = 3;
a = 10;
d = 10;
cerrojo = 0;
metodo = 1;

% Arranque del programa
Inicio();