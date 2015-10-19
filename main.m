%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Esta función imprime la pantalla principal del programa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODIGO DE LA GUI GENERADO POR MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = main(varargin)
    % MAIN MATLAB code for main.fig
    %      MAIN, by itself, creates a new MAIN or raises the existing
    %      singleton*.
    %
    %      H = MAIN returns the handle to a new MAIN or the handle to
    %      the existing singleton*.
    %
    %      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in MAIN.M with the given input arguments.
    %
    %      MAIN('Property','Value',...) creates a new MAIN or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before main_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to main_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help main

    % Last Modified by GUIDE v2.5 05-Jul-2014 23:27:33

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @main_OpeningFcn, ...
                       'gui_OutputFcn',  @main_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT
end

% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main (see VARARGIN)

    % Choose default command line output for main
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes main wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    
    % Miramos qué sistema queremos simular
    global sistema;
    switch sistema
            case 2
                linea = 'de Van Der Pol';
            case 3
                linea = 'de Chua';
            case 4
                linea = 'de Chua cúbico';
            case 5
                linea = 'de Lorenz';
            case 6
                linea = 'PV1';
            case 7
                linea = 'PV2';
            case 8
                linea = 'hipercaótico';
                set(handles.text9, 'Visible', 'on');
                set(handles.ci4, 'Visible', 'on');
                set(handles.lienzo_w, 'Visible', 'on');
                plot(handles.lienzo_w, 0,0);
                title(handles.lienzo_w, 'Señal w');
                ylabel(handles.lienzo_w, '(v)');
    end

    % Inicilizamos los cuadros de pintura 
    set(handles.Titulo,'String',['Análisis del sistema ', linea])
    plot3(handles.lienzoAtractor, 0,0,0);
    title(handles.lienzoAtractor, 'Atractor');
    xlabel(handles.lienzoAtractor, 'x');
    ylabel(handles.lienzoAtractor, 'y');
    zlabel(handles.lienzoAtractor, 'z');

    plot(handles.lienzoExp,0,0,0,0,0,0);
    title(handles.lienzoExp, 'Exponentes de Lyapunov');
    xlabel(handles.lienzoExp, 'Tiempo normalizado');
    ylabel(handles.lienzoExp, 'Valor de los exponentes');
    
    plot(handles.lienzo_x, 0,0);
    title(handles.lienzo_x, 'Señal x');
    ylabel(handles.lienzo_x, '(v)');
    
    plot(handles.lienzo_y, 0,0);
    title(handles.lienzo_y, 'Señal y');
    ylabel(handles.lienzo_y, '(v)');
    
    plot(handles.lienzo_z, 0,0);
    title(handles.lienzo_z, 'Señal z');
    xlabel(handles.lienzo_z, 'Tiempo');
    ylabel(handles.lienzo_z, '(v)');
end


% --- Outputs from this function are returned to the command line.
 function varargout = main_OutputFcn(hObject, eventdata, handles) 
        % varargout  cell array for returning output args (see VARARGOUT);
        % hObject    handle to figure
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        % Get default command line output from handles structure
        varargout{1} = handles.output;
 end

 %%%%%%%%%%%%%%%%%%%%%%
 % CONTROL DE HEBRAS
 %%%%%%%%%%%%%%%%%%%%%%%
 
 % Bloquea la hebra
function cerrarCerrojo ()
    global cerrojo;
    cerrojo = 1;
    while cerrojo
        pause (0.1);
    end
end

%%%%%%%%%%%%%
% FUNCIÓN QUE PINTA Y ANALIZA
%%%%%%%%%%%%%

% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
    % hObject    handle to start (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Avisamos de que calculamos
    set(handles.aviso, 'String', 'Espere, por favor, calculando...');
    guidata(hObject, handles);
    drawnow;

    [lambda, v1, v2, v3, v4, tiempo] = calculaGraficas (handles);
    
    set(handles.aviso, 'String', '');
    guidata(hObject, handles);
    drawnow;
    
    pintaGraficas(lambda, v1, v2, v3, v4, tiempo, handles, hObject);
end

%%%%%
% PINTURA
%%%%

function [] = pintaGraficas(lambda, v1, v2, v3, v4, tiempo, handles, hObject)
    
    global sistema;
    global Nf;
    
    N=1:Nf;
    
    indiceExp = 2;
    mag = floor (length(v1)/length(N));
    indiceAtractor = mag+1;

    c1 = lambda(1,1);
    c2 = lambda(1,2);
    c3 = lambda(1,3);
    if sistema == 8, c4 = lambda(1,4); end

    s1 = v1(1:mag);
    s2 = v2(1:mag);
    s3 = v3(1:mag);
    if sistema == 8, s4 = v4(1:mag); end
    time = N(1);
    
    clock = tiempo(1:mag);

    atractor = plot3(handles.lienzoAtractor, s1, s2, s3, 'XDataSource', 's1', 'YDataSource','s2', 'ZDataSource', 's3');
    title(handles.lienzoAtractor, 'Atractor');
    xlabel(handles.lienzoAtractor, 'x');
    ylabel(handles.lienzoAtractor, 'y');
    zlabel(handles.lienzoAtractor, 'z');
    
    sennal_x = plot(handles.lienzo_x, clock, s1, 'XDataSource', 'clock', 'YDataSource','s1');
    title(handles.lienzo_x, 'Señal x');
    ylabel(handles.lienzo_x, '(v)');
    
    sennal_y = plot(handles.lienzo_y, clock, s2, 'XDataSource', 'clock', 'YDataSource','s2');
    title(handles.lienzo_y, 'Señal y');
    ylabel(handles.lienzo_y, '(v)');
    
    sennal_z = plot(handles.lienzo_z, clock, s3, 'XDataSource', 'clock', 'YDataSource','s3');
    title(handles.lienzo_z, 'Señal z');
    ylabel(handles.lienzo_z, '(v)');
    xlabel(handles.lienzo_z, 'Tiempo');

    exponentes1 = plot(handles.lienzoExp, time, c1, 'Color', 'b', 'XDataSource', 'time', 'YDataSource','c1');
    hold(handles.lienzoExp, 'on');
    exponentes2 = plot(handles.lienzoExp, time, c2, 'Color', 'g', 'XDataSource', 'time', 'YDataSource','c2');
    exponentes3 = plot(handles.lienzoExp, time, c3, 'Color', 'r', 'XDataSource', 'time', 'YDataSource','c3');
    if sistema == 8
        exponentes4 = plot(handles.lienzoExp, time, c4, 'Color', 'k', 'XDataSource', 'time', 'YDataSource','c4');
        sennal_w = plot(handles.lienzo_w, clock, s4, 'XDataSource', 'clock', 'YDataSource','s4');
        title(handles.lienzo_w, 'Señal w');
        ylabel(handles.lienzo_w, '(v)');
        axis(handles.lienzo_w, [0, max(tiempo), min(v4), max(v4)]);
    end
    axis(handles.lienzoExp, [0, max(N), min(min(lambda)), max(max(lambda))]);
    axis(handles.lienzoAtractor, [min(v1), max(v1), min(v2), max(v2), min(v3), max(v3)]);
    axis(handles.lienzo_x, [0, max(tiempo), min(v1), max(v1)]);
    axis(handles.lienzo_y, [0, max(tiempo), min(v2), max(v2)]);
    axis(handles.lienzo_z, [0, max(tiempo), min(v3), max(v3)]);
    title(handles.lienzoExp, 'Exponentes de Lyapunov');
    xlabel(handles.lienzoExp, 'Tiempo normalizado');
    ylabel(handles.lienzoExp, 'Valor de los exponentes');

    set(handles.listaExponentes, 'String',['(', num2str(lambda(1,1)), ' , ',  num2str(lambda(1,2)), ' , ',num2str(lambda(1,3)),')'])
    set(handles.listaDimension, 'String', num2str(calculaDimensionL(lambda(1,:))));
    guidata(hObject, handles);
    drawnow;

    while indiceExp <= length(N)       

        while (indiceAtractor <= indiceExp*mag)
           s1 = [s1; v1(indiceAtractor)];
           s2 = [s2; v2(indiceAtractor)];
           s3 = [s3; v3(indiceAtractor)];           
           clock = [clock; tiempo(indiceAtractor)];
           refreshdata(sennal_x,'caller');
           refreshdata(sennal_y,'caller');
           refreshdata(sennal_z,'caller');
           if sistema == 8
               s4 = [s4; v4(indiceAtractor)];
               refreshdata(sennal_w,'caller'); 
           end    
           refreshdata(atractor,'caller');
           drawnow;
           indiceAtractor = indiceAtractor + 1;
        end

           time = [time, N(indiceExp)];
           c1 = [c1; lambda(indiceExp,1)];
           c2 = [c2; lambda(indiceExp,2)];
           c3 = [c3; lambda(indiceExp,3)];           
           if sistema == 8, c4 = [c4; lambda(indiceExp,4)]; end
           refreshdata(exponentes1,'caller');
           refreshdata(exponentes2,'caller'); 
           refreshdata(exponentes3,'caller'); 
           if sistema == 8
               refreshdata(exponentes4,'caller'); 
           end
           if sistema == 8
               set(handles.listaExponentes, 'String',['(', num2str(lambda(indiceExp,1)), ' , ',  num2str(lambda(indiceExp,2)), ' , ',num2str(lambda(indiceExp,3)), ' , ',num2str(lambda(indiceExp,4)),')'])
           else
               set(handles.listaExponentes, 'String',['(', num2str(lambda(indiceExp,1)), ' , ',  num2str(lambda(indiceExp,2)), ' , ',num2str(lambda(indiceExp,3)),')']);
           end

           set(handles.listaDimension, 'String', num2str(calculaDimensionL(lambda(indiceExp,:))));

           guidata(hObject, handles);
           drawnow;

           indiceExp = indiceExp + 1;
    end
end

%%%%%%%%%%%%%%
% Función que calcula los contenidos de las
% gráficas
%%%%%%%%%%%%%%%

function [lambda, v1, v2, v3, v4, tiempo] = calculaGraficas(handles)
    ci_1 = str2double(get(handles.ci1, 'String'));
    ci_2 = str2double(get(handles.ci2, 'String'));
    ci_3 = str2double(get(handles.ci3, 'String'));
    ci_4 = str2double(get(handles.ci4, 'String'));
       
    global sistema;
    global Nf;
    global C2;
    global R;
    global mu;
    global A;
    global omega;
    global sigma;
    global ro;
    global gamma;
    global beta;
    global alfa;
    global a;
    global d;
    global metodo;

    if sistema ~= 8, v4 = -1; end
    tiempoInt = Nf/10;
     
    % Seleccionamos el sistema que integramos
    switch sistema
        
            case 2
                cd('van_der_pol');                               
                lambda = exponentesLyapunov (mu, A, omega, [ci_1, ci_2, ci_3], Nf, metodo);              
                [v1, v2, v3, tiempo] = IntegraVanDerPolForzado(mu, A, omega, ci_1, ci_2, ci_3, tiempoInt);           
                cd('..');
                
            case 3
                cd('habitual');                
                lambda = exponentesLyapunov (R, 0.7, -7.57*10^-4, -4.09*10^-4, 10^-9, C2, 1.5*10^-3, [ci_1, ci_2, ci_3], Nf, metodo);                
                [v1, v2, v3, tiempo] = IntegraChua(R, -7.57*10^-4, -4.09*10^-4, 10^-9, C2, 1.5*10^-3, ci_1, ci_2, ci_3,tiempoInt);
                cd('..');
                
            case 4
                cd('cubico');                
                lambda = exponentesLyapunov (R, 7.57*10^-4/80, 0, -7.57*10^-4, 0, 10^-9, C2, 1.5*10^-3, [ci_1, ci_2, ci_3], Nf, metodo);
                [v1, v2, v3, tiempo] = IntegraChua(R, 7.57*10^-4/80, 0, -7.57*10^-4, 0, 10^-9, C2, 1.5*10^-3, ci_1, ci_2, ci_3,Nf);
                cd('..');
                
            case 5
                cd('lorenz');                
                lambda = exponentesLyapunov (sigma, ro, 8/3, [ci_1, ci_2, ci_3], Nf, metodo);               
                [v1, v2, v3, tiempo] = IntegraLorenz(sigma, ro, 8/3, ci_1, ci_2, ci_3,tiempoInt);
                cd('..');
                
            case 6
                cd('pv1');                
                lambda = exponentesLyapunov (1.8, 1.5, gamma, [ci_1, ci_2, ci_3], Nf, metodo);
                [v1, v2, v3, tiempo] = IntegraPV1(1.8, 1.5, gamma, ci_1, ci_2, ci_3,tiempoInt);
                cd('..');
                
            case 7
                cd('pv2');                
                lambda = exponentesLyapunov (alfa, beta, [ci_1, ci_2, ci_3], Nf, metodo);                
                [v1, v2, v3, tiempo] = IntegraPV2(alfa, beta, ci_1, ci_2, ci_3,tiempoInt);
                cd('..');
                
            case 8
                cd('hiper');
                lambda = exponentesLyapunov (a, 2, 3, d, [ci_1, ci_2, ci_3, ci_4], Nf, metodo);                
                [v1, v2, v3, v4, tiempo] = IntegraLorenzHiper(a, 2, 3, d, ci_1, ci_2, ci_3, ci_4, tiempoInt);
                cd('..');
    end
end


%%%%%%%%%%%%%%
% Función que calcula la dimensión de 
% Lyapunov dados unos exponentes
%%%%%%%%%%%%%%

function [dimensionL] = calculaDimensionL (lambda)
    
  % Ordenamos los exponentes de Lyapunov en orden descendente
  lambda = sort(lambda, 'descend');
  
  % Inicializamos una variable auxiliar
  LESum = lambda(1);			
  % La dimensión es nula
  dimensionL = 0;
  
  % Si sólo hay un exponentes, o el máximo es nulo, la dimensión es cero
  if (length(lambda) > 1 && lambda(1) > 0)
     % Recorremos los exponentes
     for i = 1:length(lambda)-1
        % Si es no nulo 
        if lambda(i+1)~=0
           % Fórmula de la dimensión de Lyapunov 
           dimensionL = i+LESum/abs(lambda(i+1));
           LESum=LESum+lambda(i+1);
           % Cuando se hace negativo, paramos
           if LESum<0
              break;
           end
        end
     end
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Control de la posibilidad de 
% modificación
%%%%%%%%%%%%%%%%%%%%%%%%%%
    
% --- Executes on button press in settings.
function settings_Callback(hObject, eventdata, handles)
    % hObject    handle to settings (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    global sistema;

    switch sistema
        case 2            
            ModificaVanDerPol();  
        case 3            
            ModificaHabitual();    
        case 4            
            ModificaCubico();  
        case 5            
            ModificaLorenz();
        case 6
            ModificaPV1();
        case 7
            ModificaPV2();
        case 8
            ModificaHiper();
    end
    
    % Cerramos el cerrojo
    cerrarCerrojo();
end


function ci1_Callback(hObject, eventdata, handles)
% hObject    handle to ci1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ci1 as text
%        str2double(get(hObject,'String')) returns contents of ci1 as a double
end

% --- Executes during object creation, after setting all properties.
function ci1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ci1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function ci2_Callback(hObject, eventdata, handles)
% hObject    handle to ci2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ci2 as text
%        str2double(get(hObject,'String')) returns contents of ci2 as a double
end

% --- Executes during object creation, after setting all properties.
function ci2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ci2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function ci3_Callback(hObject, eventdata, handles)
% hObject    handle to ci3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ci3 as text
%        str2double(get(hObject,'String')) returns contents of ci3 as a double

end

% --- Executes during object creation, after setting all properties.
function ci3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ci3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function ci4_Callback(hObject, eventdata, handles)
    % hObject    handle to ci4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: get(hObject,'String') returns contents of ci4 as text
    %        str2double(get(hObject,'String')) returns contents of ci4 as a double

end

% --- Executes during object creation, after setting all properties.
function ci4_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to ci4 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end
