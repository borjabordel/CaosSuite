%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Función que calcula los exponentes de Lyapunov del sistema PV2 para
% unos valores dados
%
% ENTRADAS:
% 
% ci : Condiciones iniciales del circuito
% alfa, beta : Parámetros del sistema PV2
%
% SALIDAS:
% lambda : Exponentes de Lyapunov
%
% Caos en circuitos electrónicos
% Borja Bordel Sánchez

function [lambda] = exponentesLyapunovGS (alfa, beta, ci, N)
    
    % Vemos las dimensiones del sistema dinamico
   dimensiones = size(ci,2);
   % El número de elementos por inetante temporal que vamos a manejar
   % incluye las variables dinámicas y las dimensiones del jacobiano
   num_elementos = dimensiones*(dimensiones+1);

   % Paso de cálculo temporal
   dt = 0.1;

   % Reservamos memoria para mejorar la ejecuación
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

    % Primera iteración
    t = dt;

    % Bucle de cálculo
    for num_iter = 1:N

       % Integración de la solución con jacobiano
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
        
        % Módulo de la primera columna del jacobiano
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

              % Módulo de la columna j-ésima
              z_norm(j)=0.0;          
              for k=1:dimensiones 
                  z_norm(j)=z_norm(j)+y0(dimensiones*k+j)^2; 
              end          
              z_norm(j)=sqrt(z_norm(j));

              % Normalización de la columna j-ésima
              for k=1:dimensiones
                  y0(dimensiones*k+j)=y0(dimensiones*k+j)/z_norm(j); 
              end
          end;

           % Calculamos los números de Lyapunov
           for k=1:dimensiones 
               sumatorio(k)=sumatorio(k)+log(z_norm(k)); 
           end;

          % A partir de los números calculamos los exponentes  
          for k=1:dimensiones
              lp(k) = sumatorio(k)/t;
          end

          % Almacenamiento de los exponetes según avanza el tiempo
          if num_iter == 1      
             lambdaTemp = lp;
          else
             lambdaTemp = [lambdaTemp; lp];
          end  
          
          % Actulización de las condiciones iniciales
          for i=1:dimensiones
              for j=1:dimensiones
                  y(dimensiones*j+i)=y0(dimensiones*i+j);
              end
          end  
    end
    
    % Tomamos como valores de los exponentes de Lyapunov
    % el último resultado temporal
    lambda = lambdaTemp;
end
