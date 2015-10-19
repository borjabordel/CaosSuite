%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Funci�n que calcula los exponentes de Lyapunov del sistema PV2 para
% unos valores dados
%
% ENTRADAS:
% 
% ci : Condiciones iniciales del circuito
% alfa, beta : Par�metros del sistema PV2
%
% SALIDAS:
% lambda : Exponentes de Lyapunov
%
% Caos en circuitos electr�nicos
% Borja Bordel S�nchez

function [lambda] = exponentesLyapunovGS (alfa, beta, ci, N)
    
    % Vemos las dimensiones del sistema dinamico
   dimensiones = size(ci,2);
   % El n�mero de elementos por inetante temporal que vamos a manejar
   % incluye las variables din�micas y las dimensiones del jacobiano
   num_elementos = dimensiones*(dimensiones+1);

   % Paso de c�lculo temporal
   dt = 0.1;

   % Reservamos memoria para mejorar la ejecuaci�n
   y = zeros(num_elementos,1); 
   y0 = y;
   GS = zeros(dimensiones,1); 
   z_norm = zeros(dimensiones,1);
   sumatorio = zeros(dimensiones,1);
   lambdaTemp = 0;
   
   % Condiciones iniciales
    y(1:dimensiones)= ci;

    for i=1:dimensiones
        y((dimensiones+1)*i) = 1.0; 
    end

    % Primera iteraci�n
    t = dt;

    % Bucle de c�lculo
    for num_iter = 1:N

       % Integraci�n de la soluci�n con jacobiano
       [Y, tiempo] = IntegraPV2_and_Jacobiano(alfa, beta, y, [t t+dt]);

       % Avanzamos en el tiempo
        t = t+dt;
        y = Y(size(Y,1),:);

        % Buscamos las nuevas ci
        for i = 1:dimensiones
            for j = 1:dimensiones 
                y0(dimensiones*i+j)=y(dimensiones*j+i); 
            end
        end

        % Ortogonalizamos por Gram-Smith
        
        % M�dulo de la primera columna del jacobiano
        z_norm(1) = 0;    
         for j=1:dimensiones 
             z_norm(1) = z_norm(1)+ y0(dimensiones*j+1)^2; 
         end
         z_norm(1) = sqrt(z_norm(1));

         % Normalizacion de la primera columna del jacobiano
         for j=1:dimensiones 
             y0(dimensiones*j+1)=y0(dimensiones*j+1)/z_norm(1); 
         end

         % Gram - Smitch para el resto de columnas
          for j=2:dimensiones
              for k = 1:(j-1)
                  GS(k)=0.0;
                  for l=1:dimensiones 
                      GS(k)=GS(k)+y0(dimensiones*l+j)*y0(dimensiones*l+k); 
                  end
              end;

              for k=1:dimensiones
                  for l=1:(j-1)
                      y0(dimensiones*k+j)=y0(dimensiones*k+j)-GS(l)*y0(dimensiones*k+l);
                  end;
              end;

              % M�dulo de la columna j-�sima
              z_norm(j)=0.0;          
              for k=1:dimensiones 
                  z_norm(j)=z_norm(j)+y0(dimensiones*k+j)^2; 
              end          
              z_norm(j)=sqrt(z_norm(j));

              % Normalizaci�n de la columna j-�sima
              for k=1:dimensiones
                  y0(dimensiones*k+j)=y0(dimensiones*k+j)/z_norm(j); 
              end
          end;

           % Calculamos los n�meros de Lyapunov
           for k=1:dimensiones 
               sumatorio(k)=sumatorio(k)+log(z_norm(k)); 
           end;

          % A partir de los n�meros calculamos los exponentes  
          for k=1:dimensiones
              lp(k) = sumatorio(k)/t;
          end

          % Almacenamiento de los exponetes seg�n avanza el tiempo
          if num_iter == 1      
             lambdaTemp = lp;
          else
             lambdaTemp = [lambdaTemp; lp];
          end  
          
          % Actulizaci�n de las condiciones iniciales
          for i=1:dimensiones
              for j=1:dimensiones
                  y(dimensiones*j+i)=y0(dimensiones*i+j);
              end
          end  
    end
    
    % Tomamos como valores de los exponentes de Lyapunov
    % el �ltimo resultado temporal
    lambda = lambdaTemp;
end
