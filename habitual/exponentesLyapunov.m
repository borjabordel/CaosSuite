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