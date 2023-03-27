clc;clear;close all
dt=0.001;c1=0.4;c2=0.8;c4=0.6;c6=0.55;stepsize=10;
P=[0.7164;1.6300;0.8500];time(1)=0;p1(1)=0.7164;p2(1)=1.63;p3(1)=0.85;
Q=[1.2;1.1;1.0];q1(1)=1.2;q2(1)=1.1;q3(1)=1;
theta=[6;3;-1];  %单位是弧度
%给出线路的阻抗，和成比例的下垂系数
r=[0.03;0.025;0.024];% 30:25:24
kp=[1;1.2;1.25];       %下垂系数的数量级在e-5~e-4
l=[0.0084;0.007;0.006];%8.4:7:6
kq=[1;1.2;1.4];
% 定义通信网络的拉普拉斯矩阵
D=eye(3);B=[1;1;0];
A=[0,0,1;1,0,0;0,1,0];
L=D-A;i=1;
% p,q的比例一致性
for t=1:stepsize/dt
    i=i+1;
    P=P-(c1./kp.*(L*(kp.*P)))*dt;
    Q=Q-(c2./kq.*(L*(kq.*Q)))*dt;
    p1(i)=P(1);
    p2(i)=P(2);
    p3(i)=P(3);
    q1(i)=Q(1);
    q2(i)=Q(2);
    q3(i)=Q(3);
    time(i)=time(i-1)+dt;
end
% 一致性算法得到频率和电压的额定值
wn=3*[1;1.3;0.2];wn1(1)=3*1;wn2(1)=3*1.3;wn3(1)=3*0.2; %均采用相对值
vn=3*[0.2;1.22;1.39];vn1(1)=3*0.2;vn2(1)=3*1.22;vn3(1)=3*1.39;
wref=[1;1;1];vref=[1;1;1];j=1;
for t=1:stepsize/dt
    j=j+1;
    wn=wn+(-c1*L*wn-c4*(B.*(wn-wref-kp.*P)))*dt;
    vn=vn+(-c2*L*vn-c6*(B.*(vn-vref-kq.*Q)))*dt;
    w=wn-kp.*P;
    v=vn-kq.*Q;
    wn1(j)=w(1);
    wn2(j)=w(2);
    wn3(j)=w(3);
    vn1(j)=v(1);
    vn2(j)=v(2);
    vn3(j)=v(3);
   
end

figure 
plot(time,kp(1)*p1,time,kp(2)*p2,time,kp(3)*p3,'LineWidth',2)
xlabel('time')
ylabel('Power')
legend('DG1','DG2','DG3')
figure 
plot(time,kq(1)*q1,time,kq(2)*q2,time,kq(3)*q3,'LineWidth',2)
xlabel('time')
ylabel('Reactive Power')
legend('DG1','DG2','DG3')
figure
plot(time,wn1,time,wn2,time,wn3,'LineWidth',2)
xlabel('time')
ylabel('Speed')
legend('DG1','DG2','DG3')
figure 
plot(time,vn1,time,vn2,time,vn3,'linewidth',2)
xlabel('time')
ylabel('Voltage')
legend('DG1','DG2','DG3')
