%% 绘制振荡过程图像
function plotimag(handles,flag)
if nargin == 1
    flag = 0;
end
Ub=15; Ue=5; Ud=Ub; Ib=5e-3; Ie=25e-3;Id=30e-3;
Pb = Ib+1j*Ub; Pe = Ie+1j*Ue; Pd = Id+1j*Ud;
axes(handles.imag);%用axes命令设定当前操作的坐标轴是imag
cla(handles.imag);
draw_line(0,Pb,'k',2);
hold on;
draw_line(Pb,Pe,'k',2);
draw_line(Pe,Pd,'k',2);
a3 =10;
b3 =-0.005;
c3 =-0.225;
% [a3,b3,c3]=find_line1(Pe,Pd)
% p1 = find_nextpoint(Pd,[a3,b3,c3],12)
p1 = 0.036 +27j;
draw_line(Pd,p1,'k',2);
% [a1,b1,c1]=find_line1(0,Pb);
a1 =15;
b1 =-0.005;
c1 =0;
% [a2,b2,c2]=find_line1(Pb,Pe);
a2 =-10;
b2 =-0.02;
c2 =0.35;
if flag == 1
%     [ax,bx,cx] = find_line1(1j*Ue,Pe);
%     Pf =find_intersection([a1,b1,c1],[ax,bx,cx]);
    draw_line(1j*Ub,Pd,'r--',2);
    draw_line(1j*Ue,Pe,'r--',2);
    Pf = 0.0017 + 5j;
    midob = 0.0033 +10j;
    draw_arrow(Pf,midob,1,'k',1.5,3);
    mided = 0.0275 +10j;
    draw_arrow(Pd,mided,1,'k',1.5,3);
    midbd = 0.0175 +15j;
    midbd2 = 0.015 +15j;
    draw_arrow(midbd2,midbd,2.5,'r',1.5,3);
    midef = 0.0133 + 5j;
    midef2 = 0.011 + 5j;
    draw_arrow(midef,midef2,2.5,'r',1.5,3);
end
Us = str2double(get(handles.us,'String'));
R1 = str2double(get(handles.res1,'String'));
[a,b,c] = find_line2(1j*Us,1-1j*R1);
p = find_intersection([a,b,c],[a1,b1,c1]);
if (real(p) <= Ib);
else
    if R1 ~= a2/b2
        p = find_intersection([a,b,c],[a2,b2,c2]);
        if (real(p) < Ie)&&(real(p) > Ib);
        else
            p = find_intersection([a,b,c],[a3,b3,c3]);
        end
    else
        p = find_intersection([a,b,c],[a3,b3,c3]);
    end
end
draw_line(1j*Us,p,'m',2);
plot(p,'r-o');
setappdata(handles.mainwin,'interp',p);
p2 = find_nextpoint(p,[a,b,c],6);
draw_line(p,p2,'m',2);
if real(p) > 35e-3
    draw_line(Pd,p,'k',2);
end
xlabel('电流i2/A');
ylabel('电压u2/V');
ylim([0,Us+5]);
grid on;