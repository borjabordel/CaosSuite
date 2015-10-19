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

function [lambda] = exponentesLyapunov (R, E, Ga, Gb, C1, C2, L, ci, N, metodo)

    switch metodo
        case 1
           lambda = exponentesLyapunovGS (R, E, Ga, Gb, C1, C2, L, ci, N);
        case 2
            lambda = exponentesLyapunovQR (R, E, Ga, Gb, C1, C2, L, ci, N);
        case 3
            lambda = exponentesLyapunovDef (R, Ga, Gb, C1, C2, L, ci, N);
    end
end