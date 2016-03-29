%% 计算波形参数
function [time,uc,i2,Tend] = getmvc(handles) % handles
Ub=15; Ue=5; Ud=Ub; Ib=5e-3; Ie=25e-3;Id=30e-3;  
US = str2double(get(handles.us,'String'));
C = str2double(get(handles.capa,'String'))/1e6;
R1 = str2double(get(handles.res1,'String'));
% C=0.01; US=25;R1=900;
Rd1=Ub/Ib;
Rd2=(Ud-Ue)/(Id-Ie);
T1=(R1*Rd1/(R1+Rd1))*C;
T2=(R1*Rd2/(R1+Rd2))*C;
uc2 = US*Rd1/(R1+Rd1); % 上升时的稳态值
U0=Ue-Rd2*Ie; % 等效电压源电压
uc3=(Rd2*US+R1*U0)/(R1+Rd2); % 下降时的稳态值
uc0=0;  % 电容初始电压值
k=0;
set(handles.vt1,'String',num2str(T1));
set(handles.vt2,'String',num2str(T2));
set(handles.vtt,'String','-');
p = getappdata(handles.mainwin,'interp');
% 0-b
if (real(p) <= Ib) 
    m=0.03; Tend=6*T1+T2;
    for t=0:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc0+uc2*(1-exp(-t/T1));
        i2(k)=uc(k)/Rd1;
    end
% b-e
elseif ((real(p) < Ie)&&(real(p) > Ib)) 
    Ttotal = T1*log((Ue-uc2)/(Ud-uc2))+T2*log((Ud-uc3)/(Ue-uc3));
    set(handles.vtt,'String',num2str(Ttotal));
    m=0.03; Tend=3*Ttotal+T1*log((-uc2)/(Ud-uc2));
    % 1
    for t=0:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc2+(uc0-uc2)*exp(-t/T1);
        i2(k)=uc(k)/Rd1;
        if uc(k)>Ub
            t1=t;
            break
        end
    end
    % 2
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
        i2(k)=(uc(k)-U0)/Rd2;
        if uc(k)<Ue
            t1=t;
            break
        end
    end
    % 3
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc2+(Ue-uc2)*exp(-(t-t1)/T1);
        i2(k)=uc(k)/Rd1;
        if uc(k)>Ub
            t1=t;
            break
        end
    end
    % 4 
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
        i2(k)=(uc(k)-U0)/Rd2;
        if uc(k)<Ue
            t1=t;
            break
        end
    end
    % 5
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc2+(Ue-uc2)*exp(-(t-t1)/T1);
        i2(k)=uc(k)/Rd1;
        if uc(k)>Ub
            t1=t;
            break
        end
    end
    % 6
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
        i2(k)=(uc(k)-U0)/Rd2;
        if uc(k)<Ue
            t1=t;
            break
        end
    end
    % 7
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc2+(Ue-uc2)*exp(-(t-t1)/T1);
        i2(k)=uc(k)/Rd1;
        if uc(k)>Ub
            t1=t;
            break
        end
    end
    
else % e-
    m=0.03; Tend=6*T1+T2;
    % 1
    for t=0:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc2+(uc0-uc2)*exp(-t/T1);
        i2(k)=uc(k)/Rd1;
        if uc(k)>Ub
            t1=t;
            break
        end
    end
    % 2 
    for t=t1:m*T1:Tend
        k=k+1;
        time(k)=t;
        uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
        i2(k)=(uc(k)-U0)/Rd2;
    end
end


