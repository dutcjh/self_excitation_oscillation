function [a,b,c]=find_line1(p1,p2)   % 由两点确定方程
x1=real(p1);  y1=imag(p1);
x2=real(p2);  y2=imag(p2);
a=y2-y1;   b=-(x2-x1);   c=y1*x2-y2*x1;
end




