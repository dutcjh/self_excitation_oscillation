function draw_arrow(startpoint,endpoint,headsize,color,linewidth,headstyle,varargin)
switch nargin
    case 2
        headsize = 0.07;color = 'b';linewidth = 1.3;headstyle = 1;
    case 3
        color = 'b';linewidth = 1.3;headstyle = 1;
    case 4
        linewidth = 1.3;headstyle = 1;
    case 5
        headstyle = 1;
end
mstartpoint = [1000*real(startpoint),imag(startpoint)];
mendpoint = [1000*real(endpoint),imag(endpoint)];
v1 = headsize*(mstartpoint-mendpoint)/2.5;
theta = 15*pi/180;
theta1 = -1*15*pi/180;
rotMatrix = [cos(theta)  -sin(theta) ; sin(theta)  cos(theta)];
rotMatrix1 = [cos(theta1)  -sin(theta1) ; sin(theta1)  cos(theta1)];
v2 = v1*rotMatrix;
v3 = v1*rotMatrix1;
x1 = mendpoint;
x2 = x1 + v2;
x3 = x1 + v3;
hold on;
if headstyle == 1
    fill([x1(1) x2(1) x3(1)]./1000,[x1(2) x2(2) x3(2)],color);     % this fills the arrowhead (color)
elseif headstyle == 2
    x11 = mstartpoint;
    x12 = x11 - v2;
    x13 = x11 - v3;
    fill([x1(1) x2(1) x3(1)]./1000,[x1(2) x2(2) x3(2)],color);     % this fills the arrowhead (color)
    fill([x11(1) x12(1) x13(1)]./1000,[x11(2) x12(2) x13(2)],color);     % this fills the arrowhead (color)
elseif headstyle == 3
    x4 = x1 + 0.5*v1;
    fill([x1(1) x2(1) x4(1) x3(1)]./1000,[x1(2) x2(2) x4(2) x3(2)],color);     % this fills the arrowhead (color) 
elseif headstyle == 4
    x4 = x1 + 1.25*v1;
    fill([x1(1) x2(1) x4(1) x3(1)]./1000,[x1(2) x2(2) x4(2) x3(2)],color);     % this fills the arrowhead (color) 
elseif headstyle == 5
    x4 = x1 + 2*v1;
    fill([x1(1) x2(1) x4(1) x3(1)]./1000,[x1(2) x2(2) x4(2) x3(2)],color);     % this fills the arrowhead (color)
end
    
    %  plot([startpoint(1) endpoint(1)],[startpoint(2) endpoint(2)],'linewidth',2,'color',[0 0 0]);
plot([mstartpoint(1) mendpoint(1)]./1000,[mstartpoint(2) mendpoint(2)],'Color',color,'linewidth',linewidth);