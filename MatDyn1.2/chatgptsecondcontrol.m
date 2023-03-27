% 设置模拟参数
T = 10; % 模拟时间
dt = 0.01; % 时间步长
N = 3; % 智能体数量
c1 = 1; % 常数
c2 = 1; % 常数
b = 1; % 常数

% 初始化智能体状态
x = zeros(N, T/dt+1); % 位置
v = zeros(N, T/dt+1); % 速度
a = zeros(N, T/dt+1); % 加速度
x(:, 1) = rand(N, 1); % 初始位置随机分布
v(:, 1) = rand(N, 1); % 初始速度随机分布

% 初始化邻接矩阵
A = ones(N, N) - eye(N); % 对角线元素为0

% 开始模拟
for t = 1:T/dt
    % 计算平均位置
    x_avg = sum(x(:, t))/N;
    
    % 计算加速度
    for i = 1:N
        u = 0;
        for j = 1:N
            u = u - A(i, j)*(x(i, t)-x(j, t));
        end
        a(i, t) = -c1*v(i, t) - c2*(x(i, t)-x_avg) + u - b*v(i, t);
    end
    
    % 更新状态
    for i = 1:N
        x(i, t+1) = x(i, t) + v(i, t)*dt + 0.5*a(i, t)*dt^2;
        v(i, t+1) = v(i, t) + a(i, t)*dt;
    end
end

% 绘制结果
figure;
for i = 1:N
   
    plot(0:dt:T, x(i, :));
    hold on
    xlabel('时间');
    ylabel(sprintf('智能体的位置'));
    legend(sprintf('智能体%d ', i))
end
