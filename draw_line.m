% ªÊ÷∆œﬂ∂Œ
function draw_line(start_point,end_point,color,linewidth,varargin)
% switch nargin
%     case 2
%         color = 'b';linewidth = 1.5;
%     case 3
%         linewidth = 1.5;
%     case 1
%         end_point = 0;color = 'b';linewidth = 1.5;
% end
plot([real(start_point),real(end_point)],[imag(start_point),...
    imag(end_point)],color,'Linewidth',linewidth);
end
    