function [Xgen0,Vgen0,Qe0,Vexc0,Id,Iq,Vod,Voq,wn,vn,wref,vref,kp,kq,stepsize] = multiagentconsensus(Xgen0,Vgen0,Qe0,stepsize,wn,vn,wref,vref,Vexc0,I0,freq)
% 本函数实现有功和无功的比例分配，二次控制得到下垂控制的额定电压和角频率，
% 然后进行电压和频率的下垂，最后将得到的电压，功率通过RLC滤波电路得到PCC
% 处的值，然后更行bus矩阵，为后面的解网络做好准备
%   
%自己定义电压的基准值
baseMVA=100;
baseV=380;
baseI=baseMVA/baseV;
% baseR=baseV^2/(baseMVA*10^6);
% baseL=baseV^2/(baseMVA*10^6*2*pi*freq);
baseR=baseMVA*10^6/(baseI^2);
baseX=baseMVA*10^6/(baseI^2);
baseL=baseX;
dt=stepsize;c1=10;c2=8;c4=6;c6=5.5;
P=Vgen0(:,3);
Q=Qe0;
theta=Xgen0(:,1);  %单位是弧度
v0=Vexc0.*cos(theta)+j*Vexc0.*sin(theta);  
%给出线路的阻抗，转化为标幺值，和成比例的下垂系数
r=[0.00003;0.000025;0.000024]./baseR;% 30:25:24
kp=[1;1.2;1.25];      
l=[0.00000084;0.0000007;0.0000006]./baseL;%8.4:7:6
kq=[1;1.2;1.4];
% 定义通信网络的拉普拉斯矩阵
D=eye(3);B=[1;1;0];
A=[0,0,1;1,0,0;0,1,0];
L=D-A;
% p,q的比例一致性
% for t=1:stepsize/dt
    P=P-(c1./kp.*(L*(kp.*P)))*dt;
    Q=Q-(c2./kq.*(L*(kq.*Q)))*dt;
% end
% 一致性算法得到频率和电压的额定值

% for t=1:stepsize/dt
    wn=wn+(-c1*L*wn-c4*(B.*(wn-wref-kp.*P)))*dt;
    vn=vn+(-c2*L*vn-c6*(B.*(vn-vref-kq.*Q)))*dt;

% end
% 下垂控制
w=wn-kp.*Vgen0(:,3);  %这里使用相对值有没有问题，本地控制，使用测量值，而非一致性之后的PQ
v=vn-kq.*Qe0;
% 积分得到电压的相角差
vi=v;
%有RLC电路和两端电压V0，Vi(那一瞬间V0还没变）得到i，可以全部使用标幺值
di=((v0-vi)./l-j.*w.*I0-r./l.*I0)*stepsize;  %
i=I0+di;
Id=real(i);
Iq=imag(i);
%积分得到θ
theta=theta+w*(freq*2*pi*stepsize);
% 
%RL滤波电路 压降后得到PCC处的电压
z=r+j.*w.*l;%标幺值
du=i.*z;   %
vi=vi.*cos(theta)+j*vi.*sin(theta);
v0=vi+du;
Vod=real(v0);
Voq=imag(v0);
%计算PCC处的有功和无功功率
Po=3/2*(Vod.*Id+Voq.*Iq);
Qo=3/2*(-Vod.*Iq+Voq.*Id);
%将得到的P，Q，V, θ更新到bus中并返回
Xgen0(:,1)=theta;
Xgen0(:,2)=w.*2*pi*freq;
Vgen0(:,3)=Po;
Qe0=Qo;
Vexc0=abs(v0);

return








