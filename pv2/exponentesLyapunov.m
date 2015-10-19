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

function [lambda] = exponentesLyapunov (alfa, beta, ci, N, metodo)

    switch metodo
        case 1
           lambda = exponentesLyapunovGS (alfa, beta, ci, N);
        case 2
            lambda = exponentesLyapunovQR (alfa, beta,  ci, N);
        case 3
            lambda = exponentesLyapunovDef (alfa, beta, ci, N);
    end
end