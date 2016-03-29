%% �Լ��񵴽�ѧ��ʾ���
% ���ߣ��½���
% �汾�ţ�v3.0
% ���¼�¼��2016-3-10 v3.0 ����ʵʱ���ٹ��ܣ��޸�BUG�����ٰ�ť
%           2016-3-3 v2.0 �Ż�����
%           2016-3-1 v1.1 ���ӱ��涯�����ܣ��޸�����BUG
%           2016-2-29 v1.0 �������
%
%% ��ʼ������
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


axes(handles.circuit);%��axes�����趨��ǰ��������������circuit
img_src=imread('circuit.png'); %��ȡ��·ͼ
imshow(double(img_src)./255);%��imread����ͼƬ������imshow��circuit����ʾ

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

axes(handles.circuit);%��axes�����趨��ǰ��������������circuit
img_src=imread('circuit.png'); %��ȡ��·ͼ
imshow(double(img_src)./255);%��imread����ͼƬ������imshow��circuit����ʾ
    
setappdata(handles.mainwin,'breakpoint',1);%������1��ʼ��ͼ
setappdata(handles.mainwin,'pauseflag',-1); %�����Ϊ��ʼ��ͼ
set(handles.allplot,'String','��ʼ��ͼ');

% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
close(gcf);


% --- Executes on button press in allplot.
function allplot_Callback(hObject, eventdata, handles)
hand2 = [handles.us,handles.res1,handles.capa];
fg = getappdata(handles.mainwin,'pauseflag');
if fg == 0
    setappdata(handles.mainwin,'pauseflag',1); 
    axes(handles.circuit);%��axes�����趨��ǰ��������������circuit
    img_src=imread('circuit.png'); %��ȡ��·ͼ
    imshow(double(img_src)./255);%��imread����ͼƬ������imshow��circuit����ʾ
    plotimag(handles,1);
    set(hObject,'String','����');
    set(handles.clearimag,'Enable','on');
    set(hand2,'Enable','on');
else
    setappdata(handles.mainwin,'pauseflag',0); 
    axes(handles.circuit);%��axes�����趨��ǰ��������������circuit
    img_src=imread('circuit2.png'); %��ȡ��·ͼ2
    imshow(double(img_src)./255);%��imread����ͼƬ������imshow��circuit����ʾ
    set(hObject,'String','��ͣ');
    set(handles.clearimag,'Enable','off');
    set(hand2,'Enable','inactive');
    getmall(handles);
end

% --- Executes on button press in xunhuan.
function xunhuan_Callback(hObject, eventdata, handles)

% --- Executes on button press in helpbutton.
function helpbutton_Callback(hObject, eventdata, handles)
helpdlg({'�汾�ţ�3.0' '��Ȩ����ϣ�У��½���'},'�������');

% --- end ---
