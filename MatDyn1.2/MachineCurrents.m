function [Id,Iq,Pe,Qe] = MachineCurrents(PG,QG,V)

% [Id,Iq,Pe] = MachineCurrents(Xgen, Pgen, U, theta, gentype)
% 
% Calculates currents and electric power of generators
% 
% INPUTS
% Xgen = state variables of generators
% Pgen = parameters of generators
% U = generator voltages
% gentype = generator models
% 
% OUTPUTS
% Id = d-axis stator current
% Iq = q-axis stator current
% Pe = generator electric power

% MatDyn
% Copyright (C) 2009 Stijn Cole
% Katholieke Universiteit Leuven
% Dept. Electrical Engineering (ESAT), Div. ELECTA
% Kasteelpark Arenberg 10
% 3001 Leuven-Heverlee, Belgium

%% Init
[ngen,~] = size(PG);
Id = zeros(ngen,1);
Iq = zeros(ngen,1);
Pe = zeros(ngen,1);
Qe = zeros(ngen,1);

Id=2/3*PG./V;
Iq=-2/3*QG./V;
Pe=PG;

Qe=QG;



%% Generator type 1: classical model
% delta = Xgen(type1,1);%电压的初始相角 即为功率角吧？！
% Eq_tr = Xgen(type1,3);%转子的电势
% 
% xd = Pgen(type1,6);%直轴自感系数
% 
% Pe(type1) = 1./xd.*abs(U(type1,1)).*abs(Eq_tr).*sin(delta-angle(U(type1,1)));
% Qe(type1) = 1./xd.*abs(U(type1,1)).*abs(Eq_tr).*cos(delta-angle(U(type1,1)));%这个是chatgpt给出的无功计算公式，


%% Generator type 2: 4th order model

% delta = Xgen(type2,1);
% Eq_tr = Xgen(type2,3);
% Ed_tr = Xgen(type2,4);
% 
% xd_tr = Pgen(type2,8);
% xq_tr = Pgen(type2,9);
% 
% theta=angle(U);
% 
% % Tranform U to rotor frame of reference
% vd = -abs(U(type2,1)).*sin(delta-theta(type2,1));
% vq = abs(U(type2,1)).*cos(delta-theta(type2,1));
% 
% Id(type2) = (vq - Eq_tr)./xd_tr;
% Iq(type2) =-(vd - Ed_tr)./xq_tr;
% 
% Pe(type2) = Eq_tr.*Iq(type2,1) + Ed_tr.*Id(type2,1) + (xd_tr - xq_tr).*Id(type2,1).*Iq(type2,1);
% Qe(type2) = vd.*Iq(type2)-vq.*Id(type2);  %
% pt(type2) = vd.*Id(type2)+vq.*Iq(type2); %经验证，上下这两种计算结果相同
% qt(type2) = vd.*Iq(type2)-vq.*Id(type2);

return;