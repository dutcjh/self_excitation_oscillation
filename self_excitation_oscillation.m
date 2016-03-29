%% 自激振荡教学演示软件
% 作者：陈建辉
% 版本号：v3.0
% 更新记录：2016-3-10 v3.0 增加实时跟踪功能，修复BUG，减少按钮
%           2016-3-3 v2.0 优化性能
%           2016-3-1 v1.1 增加保存动画功能，修复部分BUG
%           2016-2-29 v1.0 基本完成
%
%% 初始化代码
function varargout = self_excitation_oscillation(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @self_excitation_oscillation_OpeningFcn, ...
                   'gui_OutputFcn',  @self_excitation_oscillation_OutputFcn, ...
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

% --- Executes just before self_excitation_oscillation is made visible.
function self_excitation_oscillation_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


axes(handles.circuit);%用axes命令设定当前操作的坐标轴是circuit
img_src=imread('circuit.png'); %读取电路图
imshow(double(img_src)./255);%用imread读入图片，并用imshow在circuit上显示

clearimag_Callback(hObject, eventdata, handles);


% --- Outputs from this function are returned to the command line.
function varargout = self_excitation_oscillation_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function us_Callback(hObject, eventdata, handles)
volt = str2double(get(hObject,'String'));
if volt > 100
    volt = 100;
elseif volt < 15
    volt = 15;
end
set(hObject,'String',num2str(volt));
plotimag(handles);

% --- Executes during object creation, after setting all properties.
function us_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function res1_Callback(hObject, eventdata, handles)
res = str2double(get(hObject,'String'));
if res > 1000000
    res = 1000000;
elseif res < 0
    res = 0;
end
set(hObject,'String',num2str(res));
plotimag(handles);

% --- Executes during object creation, after setting all properties.
function res1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function capa_Callback(hObject, eventdata, handles)
cap = str2double(get(hObject,'String'));
if cap > 1000000
    cap = 1000000;
elseif cap < 0
    cap = 0;
end
set(hObject,'String',num2str(cap));

% --- Executes during object creation, after setting all properties.
function capa_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearimag.
function clearimag_Callback(hObject, eventdata, handles)
hand2 = [handles.us,handles.res1,handles.capa];
set(hand2,'Enable','on');

axes(handles.imag);
plotimag(handles);
ylim = get(handles.imag,'Ylim');

axes(handles.voltage_imag);
cla reset;
axis([0,100,ylim(1),ylim(2)]);
grid on;

xlim = get(handles.imag,'Xlim');
axes(handles.current_imag);
cla reset;
axis([xlim(1),xlim(2),0,100]);
set(handles.current_imag,'XAxisLocation','top');
set(handles.current_imag,'YDir','reverse');
grid on;

axes(handles.circuit);%用axes命令设定当前操作的坐标轴是circuit
img_src=imread('circuit.png'); %读取电路图
imshow(double(img_src)./255);%用imread读入图片，并用imshow在circuit上显示
    
setappdata(handles.mainwin,'breakpoint',1);%清除后从1开始绘图
setappdata(handles.mainwin,'pauseflag',-1); %清除后为开始绘图
set(handles.allplot,'String','开始绘图');

% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
close(gcf);


% --- Executes on button press in allplot.
function allplot_Callback(hObject, eventdata, handles)
hand2 = [handles.us,handles.res1,handles.capa];
fg = getappdata(handles.mainwin,'pauseflag');
if fg == 0
    setappdata(handles.mainwin,'pauseflag',1); 
    axes(handles.circuit);%用axes命令设定当前操作的坐标轴是circuit
    img_src=imread('circuit.png'); %读取电路图
    imshow(double(img_src)./255);%用imread读入图片，并用imshow在circuit上显示
    plotimag(handles,1);
    set(hObject,'String','继续');
    set(handles.clearimag,'Enable','on');
    set(hand2,'Enable','on');
else
    setappdata(handles.mainwin,'pauseflag',0); 
    axes(handles.circuit);%用axes命令设定当前操作的坐标轴是circuit
    img_src=imread('circuit2.png'); %读取电路图2
    imshow(double(img_src)./255);%用imread读入图片，并用imshow在circuit上显示
    set(hObject,'String','暂停');
    set(handles.clearimag,'Enable','off');
    set(hand2,'Enable','inactive');
    getmall(handles);
end

% --- Executes on button press in xunhuan.
function xunhuan_Callback(hObject, eventdata, handles)

% --- Executes on button press in helpbutton.
function helpbutton_Callback(hObject, eventdata, handles)
helpdlg({'版本号：3.0' '版权：陈希有，陈建辉'},'关于软件');

% --- end ---
