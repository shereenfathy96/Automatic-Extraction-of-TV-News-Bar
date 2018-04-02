function varargout = APPGUI(varargin)
% APPGUI MATLAB code for APPGUI.fig
%      APPGUI, by itself, creates a new APPGUI or raises the existing
%      singleton*.
%
%      H = APPGUI returns the handle to a new APPGUI or the handle to
%      the existing singleton*.
%
%      APPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPGUI.M with the given input arguments.
%
%      APPGUI('Property','Value',...) creates a new APPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before APPGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to APPGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help APPGUI

% Last Modified by GUIDE v2.5 29-Nov-2017 00:04:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @APPGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @APPGUI_OutputFcn, ...
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


% --- Executes just before APPGUI is made visible.
function APPGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to APPGUI (see VARARGIN)

% Choose default command line output for APPGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes APPGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = APPGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse_btn.
function Browse_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[chosenfile, chosenpath] = uigetfile('*.avi;*.mp4', 'Select a video');
  if ~ischar(chosenfile)
    return;   %user canceled dialog
  end
  Path = fullfile(chosenpath, chosenfile);
  set(handles.Video_name,'String' ,Path);
  guidata(hObject, handles);
  


function Video_name_Callback(hObject, eventdata, handles)
% hObject    handle to Video_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Video_name as text
%        str2double(get(hObject,'String')) returns contents of Video_name as a double


% --- Executes during object creation, after setting all properties.
function Video_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Video_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Extract_btn.
function Extract_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Path=get(handles.Video_name,'String');
newsbar=ReadVideo(Path);
axes(handles.axes1);
guidata(hObject, handles);
imshow(newsbar);
