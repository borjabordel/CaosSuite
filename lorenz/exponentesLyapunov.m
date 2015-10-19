%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n distribuye el c�lculo de los exponentes de Lyapunov entre las
% diferentes opciones de forma apropiada
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [lambda] = exponentesLyapunov (sigma, ro, beta, ci, N, metodo)

    switch metodo
        case 1
           lambda = exponentesLyapunovGS (sigma, ro, beta, ci, N);
        case 2
            lambda = exponentesLyapunovQR (sigma, beta, ro, ci, N);
        case 3
            lambda = exponentesLyapunovDef (sigma, beta, ro, ci, N);
    end
end