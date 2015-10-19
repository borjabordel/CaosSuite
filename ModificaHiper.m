%
% PROYECTO:
% AN�LISIS, CONSTRUCCI�N, SIMULACI�N Y SINCRONIZACI�N DE CIRCUITOS ELECTR�NICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel S�nchez
%
% Script que permite pintar la ventana de modificaci�n del sistema de
% Lorenz hiperca�tico

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCIONES GENERADAS POR MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = ModificaHiper(varargin)
    % MODIFICAHABITUAL MATLAB code for ModificaHabitual.fig
    %      MODIFICAHABITUAL, by itself, creates a new MODIFICAHABITUAL or raises the existing
    %      singleton*.
    %
    %      H = MODIFICAHABITUAL returns the handle to a new MODIFICAHABITUAL or the handle to
    %      the existing singleton*.
    %
    %      MODIFICAHABITUAL('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in MODIFICAHABITUAL.M with the given input arguments.
    %
    %      MODIFICAHABITUAL('Property','Value',...) creates a new MODIFICAHABITUAL or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before ModificaHabitual_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to ModificaHabitual_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help ModificaHabitual

    % Last Modified by GUIDE v2.5 03-Jul-2014 23:51:45

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @ModificaHiper_OpeningFcn, ...
                       'gui_OutputFcn',  @ModificaHiper_OutputFcn, ...
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

function a__Callback(hObject, eventdata, handles)
% hObject    handle to a_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_ as text
%        str2double(get(hObject,'String')) returns contents of a_ as a double
end

% --- Executes during object creation, after setting all properties.
function a__CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function d__Callback(hObject, eventdata, handles)
% hObject    handle to d_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_ as text
%        str2double(get(hObject,'String')) returns contents of d_ as a double
end

% --- Executes during object creation, after setting all properties.
function d__CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function tiempo_Callback(hObject, eventdata, handles)
% hObject    handle to tiempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tiempo as text
%        str2double(get(hObject,'String')) returns contents of tiempo as a double
end

% --- Executes during object creation, after setting all properties.
function tiempo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tiempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in algoritmo.
function algoritmo_Callback(hObject, eventdata, handles)
% hObject    handle to algoritmo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns algoritmo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from algoritmo
end

% --- Executes during object creation, after setting all properties.
function algoritmo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to algoritmo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%%%%%%% FUNCIONES PARA LA GESU�N DE HEBRAS %%%%%%%%

% Libera el cerrojo
function abrirCerrojo ()
    global cerrojo;
    cerrojo = 0;  
end

% Funci�n de cierre en el boton superior
function cerrar (src, evnt)
    abrirCerrojo;
    delete(gcf);
end

%%%%%%%%%%%%%%%%%%%%%%
% Funciones de presentaci�n 
% y recogida de dato
%%%%%%%%%%%%%%%%%%%%%

% --- Executes just before ModificaHabitual is made visible.
    function ModificaHiper_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to ModificaHabitual (see VARARGIN)

    % Choose default command line output for ModificaHabitual
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
    set(handles.figure1,'CloseRequestFcn',@cerrar);

    % UIWAIT makes ModificaHabitual wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
    
    % Inicializaci�n
    global a;
    global d;
    global Nf;
    global metodo;
    
    set(handles.a_, 'String', num2str(a));
    set(handles.d_, 'String', num2str(d));
    set(handles.tiempo, 'String', num2str(Nf));
    set(handles.algoritmo, 'Value', metodo);
end

% --- Outputs from this function are returned to the command line.
function varargout = ModificaHiper_OutputFcn(hObject, eventdata, handles) 
    % varargout  cell array for returning output args (see VARARGOUT);
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)

    % Get default command line output from handles structure
    varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
    % hObject    handle to pushbutton1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Datos modificables
    global a;
    global d;
    global Nf;
    global metodo;

    a = str2double(get(handles.a_, 'String'));
    d = str2double(get(handles.d_, 'String'));
    Nf = str2double(get(handles.tiempo, 'String'));
    metodo = get(handles.algoritmo,'Value');

    close ModificaHiper;
end
