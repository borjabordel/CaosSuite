%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función distribuye el cálculo de los exponentes de Lyapunov entre las
% diferentes opciones de forma apropiada
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez

function [lambda] = exponentesLyapunov (mu, A, omega, ci, N, metodo)

    switch metodo
        case 1
           lambda = exponentesLyapunovGS (mu, A, omega, ci, N);
        case 2
            lambda = exponentesLyapunovQR (mu, A, omega, ci, N);
        case 3
            lambda = exponentesLyapunovDef (mu, A, omega, ci, N);
    end
end