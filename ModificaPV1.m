%
% PROYECTO:
% ANÁLISIS, CONSTRUCCIÓN, SIMULACIÓN Y SINCRONIZACIÓN DE CIRCUITOS ELECTRÓNICOS PROTOTIPOS DE CAOS 
%
% Borja Bordel Sánchez
%
% Script que permite pintar la ventana de modificación del sistema PV1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCIONES GENERADAS POR MATLAB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = ModificaPV1(varargin)
% MODIFICAVANDERPOL MATLAB code for ModificaVanDerPol.fig
%      MODIFICAVANDERPOL, by itself, creates a new MODIFICAVANDERPOL or raises the existing
%      singleton*.
%
%      H = MODIFICAVANDERPOL returns the handle to a new MODIFICAVANDERPOL or the handle to
%      the existing singleton*.
%
%      MODIFICAVANDERPOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODIFICAVANDERPOL.M with the given input arguments.
%
%      MODIFICAVANDERPOL('Property','Value',...) creates a new MODIFICAVANDERPOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ModificaVanDerPol_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ModificaVanDerPol_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ModificaVanDerPol

% Last Modified by GUIDE v2.5 03-Jul-2014 23:20:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ModificaPV1_OpeningFcn, ...
                   'gui_OutputFcn',  @ModificaPV1_OutputFcn, ...
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

function gamma__Callback(hObject, eventdata, handles)
% hObject    handle to gamma_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_ as text
%        str2double(get(hObject,'String')) returns contents of gamma_ as a double
end

% --- Executes during object creation, after setting all properties.
function gamma__CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%%%%%%% FUNCIONES PARA LA GESUÓN DE HEBRAS %%%%%%%%

% Libera el cerrojo
function abrirCerrojo ()
    global cerrojo;
    cerrojo = 0;  
end

% Función de cierre en el boton superior
function cerrar (src, evnt)
    abrirCerrojo;
    delete(gcf);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCIONES RECOGIDA Y PRESENTACIÓN DE DATOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes just before ModificaVanDerPol is made visible.
function ModificaPV1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ModificaVanDerPol (see VARARGIN)

% Choose default command line output for ModificaVanDerPol
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.figure1,'CloseRequestFcn',@cerrar);

% UIWAIT makes ModificaVanDerPol wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Presentación de los datos
global gamma;
global Nf;
global metodo;

set(handles.gamma_, 'String', num2str(gamma));
set(handles.tiempo, 'String', num2str(Nf));
set(handles.algoritmo, 'Value', metodo);
end

% --- Outputs from this function are returned to the command line.
function varargout = ModificaPV1_OutputFcn(hObject, eventdata, handles) 
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

    global gamma;
    global metodo;
    global Nf;
    
    gamma = str2double(get(handles.gamma_, 'String'));
    Nf = str2double(get(handles.tiempo, 'String'));
    metodo = get(handles.algoritmo,'Value');

    close ModificaPV1;
end
