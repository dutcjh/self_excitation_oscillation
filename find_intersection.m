function intersection=find_intersection(line1,line2)    % 确定两直线交点。
a1=line1(1);  b1=line1(2);   c1=line1(3);
a2=line2(1);  b2=line2(2);   c2=line2(3);
A=[a1,b1;a2,b2];  B=[-c1;-c2];
x=A\B;
intersection=x(1)+1j*x(2);


