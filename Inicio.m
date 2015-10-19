%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Esta función imprime la pantalla inicial del programa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODIGO DE LA GUI GENERADO POR MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = Inicio(varargin)
    % INICIO MATLAB code for Inicio.fig
    %      INICIO, by itself, creates a new INICIO or raises the existing
    %      singleton*.
    %
    %      H = INICIO returns the handle to a new INICIO or the handle to
    %      the existing singleton*.
    %
    %      INICIO('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in INICIO.M with the given input arguments.
    %
    %      INICIO('Property','Value',...) creates a new INICIO or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before Inicio_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to Inicio_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help Inicio

    % Last Modified by GUIDE v2.5 28-Jun-2014 18:39:14

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @Inicio_OpeningFcn, ...
                       'gui_OutputFcn',  @Inicio_OutputFcn, ...
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

% --- Executes just before Inicio is made visible.
function Inicio_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to Inicio (see VARARGIN)

    % Choose default command line output for Inicio
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes Inicio wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = Inicio_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes during object creation, after setting all properties.
function selector_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to selector (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: popupmenu controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to figure1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODIGO PROPIO PARA GESTIONAR EL PROGRAMA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on selection change in selector. MENU DESPLEGABLE
function selector_Callback(hObject, eventdata, handles)
    % hObject    handle to selector (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Hints: contents = cellstr(get(hObject,'String')) returns selector contents as cell array
    %        contents{get(hObject,'Value')} returns selected item from selector

    fun =get(handles.selector,'Value');
    switch fun
        case 2
            explicaVanDerPol(handles);
        case 3
            explicaChuaHabitual(handles);
        case 4
            explicaChuaCubico(handles);
        case 5
            explicaLorenz(handles);
        case 6
            explicaPV1(handles);
        case 7
            explicaPV2(handles);
        case 8
            explicaHipercaos(handles);
    end
end

% Funciones para pintar la explicación sobre el sistema que se selecciones
% en el PoP UP

function explicaVanDerPol(handles)
    explicacion = [{'Sistema dinámico de Van Der Pol forzado mediante una fuente de señal',...
        ' sinusoidal.'},{''},{'El sistema viene descrito por la dinámica:x"-mu(1-x^2)x´+x = A*sen(omega*t+fi)'},{''},...
        {'Para poder integrar el sistema en MATLAB, desarrollaremos la dinámica en la forma:'},...
        {''}, {'dx = y'}, {'dy = -x+mu*(1-x^2)*y+A*sen(z)'},{'dz = omega'}];
    set(handles.explanation,'String',explicacion);
end

function explicaChuaHabitual(handles)
    explicacion = [{'Sistema dinámico de Chua implementado con la no linealdiad habitual (curva lineal a trozos)'},...
        {''},{'El sistema viene descrito por la dinámica:'},{''},...        
        {''}, {'dx = alfa*(y-x-f(x))'}, {'dy = x-y+z'},{'dz = -beta*y'}, {''}, {'con: f(x)= m1*x+0.5*(m0-m1)*(|x+1|+|x-1|)'}];
    set(handles.explanation,'String',explicacion);
end

function explicaChuaCubico(handles)
    explicacion = [{'Sistema dinámico de Chua implementado con la no linealdiad cúbica'},...
        {''},{'El sistema viene descrito por la dinámica:'},{''},...        
        {''}, {'dx = alfa*(y-x-f(x))'}, {'dy = x-y+z'},{'dz = -beta*y'}, {''}, {'con: f(x)= a*x^3+c*x'}];
    set(handles.explanation,'String',explicacion);
end

function explicaLorenz(handles)
    explicacion = [{'Sistema dinámico de Lorenz'},...
        {''},{'El sistema viene descrito por la dinámica:'},{''},...        
        {''}, {'dx = sigma*(y-x)'}, {'dy = x*(ro-z)-y'},{'dz = xy-beta*z'}];
    set(handles.explanation,'String',explicacion);
end

function explicaHipercaos(handles)
    explicacion = [{'Sistema dinámico hipercaótico basado en el sistema de Lorenz'},...
        {''},{'El sistema viene descrito por la dinámica:'},{''},...        
        {''}, {'dx = d*(x-y)+2*w'}, {'dy = 5*x+c*y-4*x*z'},{'dz = x*y-3*z'},{'dw = -b*w-a*(x-y)'}];
    set(handles.explanation,'String',explicacion);
end

function explicaPV1(handles)
    explicacion = [{'Sistema dinámico caótico mínimo (SMC) PV1'},...
        {''},{'El sistema viene descrito por la dinámica:'},{''},...        
        {''}, {'dx = -alfa*y'}, {'dy = beta*x-z^2'},{'dz = 1+x+2*y-gamma*z'}];
    set(handles.explanation,'String',explicacion);
end

function explicaPV2(handles)
    explicacion = [{'Sistema dinámico caótico mínimo (SMC) PV2'},...
        {''},{'El sistema viene descrito por la dinámica:'},{''},...        
        {''}, {'dx = -alfa*y'}, {'dy = beta*x-z^2'},{'dz = 1+x+5/2*y-2*z'},{''},...
        {'Este sistema, además, puede expresarse en forma jerk'}];
    set(handles.explanation,'String',explicacion);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    global sistema;
    fun =get(handles.selector,'Value');
    if (fun ~= 1)
        sistema = fun;
        main();
    end
end
