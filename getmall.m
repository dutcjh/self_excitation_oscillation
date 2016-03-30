%% ���Ƶ�������ѹ���񵴹��̵ı仯����
function getmall(handles) % handles
pbi = getappdata(handles.mainwin,'breakpoint');
pint = getappdata(handles.mainwin,'interp');
plotimag(handles);
xlim = get(handles.imag,'Xlim');
ylim = get(handles.imag,'Ylim');

[time,uc,i2,Tend] = getmvc(handles);

axes(handles.current_imag);
cla(handles.current_imag);
hold on;
axis([xlim(1),xlim(2),0,Tend]);
set(handles.current_imag,'XAxisLocation','top');
set(handles.current_imag,'YDir','reverse');
ylabel('ʱ��t/s');
xlabel('����i2/A');
grid on;

axes(handles.voltage_imag);
cla(handles.voltage_imag);
hold on;
axis([0,Tend,ylim(1),ylim(2)]);
xlabel('ʱ��t/s');
ylabel('��ѹu2/V');
grid on;

for i = pbi:numel(time)
    cla(handles.current_imag)
    cla(handles.voltage_imag)
    
    plot(handles.current_imag,i2(1:i),time(1:i),'LineWidth',2,'Color','b');
    plot(handles.current_imag,[i2(i),i2(i)],[0,Tend],'r--','LineWidth',1.5);
    plot(handles.current_imag,i2(i),time(i),'b-o');
    
    plot(handles.voltage_imag,time(1:i),uc(1:i),'LineWidth',2,'Color','r');
    plot(handles.voltage_imag,[0,Tend],[uc(i),uc(i)],'b--','LineWidth',1.5);
    plot(handles.voltage_imag,time(i),uc(i),'r-o');
    plotimag(handles);
    plot(handles.imag,[xlim(1),xlim(2)],[uc(i),uc(i)],'b--','LineWidth',2);
    plot(handles.imag,[i2(i),i2(i)],[ylim(1),ylim(2)],'r--','LineWidth',2);
    plot(handles.imag,i2(i),uc(i),'k-o');
    
    pflag = getappdata(handles.mainwin,'pauseflag');
    if pflag == 1
        if real(pint) <= 5e-3
            plotimag(handles,4);
        elseif real(pint) <= 25e-3
            Tx = str2double(get(handles.vtt,'String'));
            if time(i) >= Tx
                plotimag(handles,1);
            else
                if i2(i) <= 5e-3
                    plotimag(handles,4);
                else
                    plotimag(handles,3);
                end
            end
        elseif real(pint) < 30e-3
            if i2(i) <= 5e-3
                plotimag(handles,4);
            else
                plotimag(handles,3);
            end
        else 
            if i2(i) <= 5e-3
                plotimag(handles,4);
            else
                plotimag(handles,2);
            end
        end
        plot(handles.imag,[xlim(1),xlim(2)],[uc(i),uc(i)],'b--','LineWidth',2);
        plot(handles.imag,[i2(i),i2(i)],[ylim(1),ylim(2)],'r--','LineWidth',2);
        plot(handles.imag,i2(i),uc(i),'k-o');
        break;
    end
    pause(0.0001);
end
setappdata(handles.mainwin,'breakpoint',i);
if i >= numel(time)
    setappdata(handles.mainwin,'breakpoint',1);
    cf = get(handles.xunhuan,'Value');
    if cf == 0
        if real(pint) <= 5e-3
            plotimag(handles,4);
        elseif real(pint) <= 25e-3
            plotimag(handles,1);
        elseif real(pint) < 30e-3
            plotimag(handles,3);
        else 
            plotimag(handles,2);
        end
        plot(handles.imag,[xlim(1),xlim(2)],[uc(i),uc(i)],'b--','LineWidth',2);
        plot(handles.imag,[i2(i),i2(i)],[ylim(1),ylim(2)],'r--','LineWidth',2);
        plot(handles.imag,i2(i),uc(i),'k-o');
        setappdata(handles.mainwin,'pauseflag',-1); %��ʼ��ͼ
        set(handles.allplot,'String','��ʼ��ͼ');
        set(handles.clearimag,'Enable','on');
        hand2 = [handles.us,handles.res1,handles.capa];
        set(hand2,'Enable','on');   
        axes(handles.circuit);%��axes�����趨��ǰ��������������circuit
        img_src=imread('circuit.png'); %��ȡ��·ͼ
        imshow(double(img_src)./255);%��imread����ͼƬ������imshow��circuit����ʾ
    else
        getmall(handles);
    end
end

