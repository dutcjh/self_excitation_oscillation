
% Figure 14.11.5. self excitation oscillation.
clear all; close all;
Ub=15; Ue=5; Ud=Ub; Ib=5e-3; Ie=25e-3;Id=30e-3;  C=0.01; US=22;R1=900;
Rd1=Ub/Ib;  Rd2=(Ub-Ue)/(Id-Ie);
T1=Rd1*C;  T2=(R1*Rd2/(R1+Rd2))*C;
u=0; uc0=0; m=0.005; Tend=10*(T1+T2);
k=0;
for t=0:m*T1:Tend
    if u>Ub
        t1=t;
        break
    else
        k=k+1;
        time(k)=t;
        t1 = t;
        uc2=US*Rd2/(R1+Rd2);
        uc(k)=uc2+(uc0-uc2)*exp(-t/T1);
        u=uc(k);
    end
end
% 2
for t=t1:m*T1:Tend
if u<Ue
    t1=t;
    break
else
    U0=Ue-Rd2*Ie;
    uc3=(Rd2*US+R1*U0)/(R1+Rd2);
    k=k+1;
    time(k)=t;
    uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
    u=uc(k);
end
end

% 3
for t=t1:m*T1:Tend
    if u>Ub
        t1=t;
        u=uc(k);
        break
    else
        k=k+1;
        time(k)=t;
        uc2=US*Rd2/(R1+Rd2);
        uc(k)=uc2+(Ue-uc2)*exp(-(t-t1)/T1);
        u=uc(k);
    end
end
% 4 
for t=t1:m*T1:Tend
if u<Ue
    t1=t;
    break
else
    U0=Ue-Rd2*Ie;
    uc3=(Rd2*US+R1*U0)/(R1+Rd2);
    k=k+1;
    time(k)=t;
    uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
    u=uc(k);
end
end


% 5
for t=t1:m*T1:Tend
    if u>Ub
        t1=t;
        u=uc(k);
        break
    else
        k=k+1;
        time(k)=t;
        uc2=US*Rd2/(R1+Rd2);
        uc(k)=uc2+(Ue-uc2)*exp(-(t-t1)/T1);
        u=uc(k);
    end
end

% 6
for t=t1:m*T1:Tend
if u<Ue
    t1=t;
    break
else
    U0=Ue-Rd2*Ie;
    uc3=(Rd2*US+R1*U0)/(R1+Rd2);
    k=k+1;
    time(k)=t;
    uc(k)=uc3+(Ud-uc3)*exp(-(t-t1)/T2);
    u=uc(k);
end
end

% 7
for t=t1:m*T1:Tend
    if u>Ub
        t1=t;
        u=uc(k);
        break
    else
        k=k+1;
        time(k)=t;
        uc2=US*Rd2/(R1+Rd2);
        uc(k)=uc2+(Ue-uc2)*exp(-(t-t1)/T1);
        u=uc(k);
    end
end


figure(1)
plot(time,uc)





