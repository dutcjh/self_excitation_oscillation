function p2=find_nextpoint(p1,abc,length)   % ����ֱ֪���ϣ�����p1 Ϊ��������length�ĵ�
a=abc(1);  b=abc(2);  c=abc(3);
p2=p1+length*(-b+1j*a)/sqrt(a^2+b^2);
end

