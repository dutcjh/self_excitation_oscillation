function [a,b,c]= find_line2(p0,line_vector)   % 由点的斜率矢量，确定方程
x0=real(p0);   y0=imag(p0);
x1=real(line_vector);   y1=imag(line_vector);
a=y1; b=-x1;  c=-x0*y1+y0*x1;
end


