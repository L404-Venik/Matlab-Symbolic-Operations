clc 
clear
close all

% решение задачи Коши для ономерного волнового уравнения на "полупрямой"
% с использованием символьных вычислений

syms x t;
a = 2;

U_left_bound = sin(t);
U_initial  = piecewise((x >= 4) & (x <= 8), 1 + 2 * cos(2*pi*(2*x+3)), (x < 4) | (x > 8), 0); 
Ut_initial = piecewise((x >= 3) & (x <= 4), 2, (x < 3) | (x > 4), 0);

y = t - x/a;
y1 = x + a*t;
y2 = x - a*t;

U_1 = 1/2 * (subs(U_initial, y1) + subs(U_initial, y2)) + ...
      1/(2*a) * int(Ut_initial, x, y2, y1);

U_2 = subs(U_left_bound, y) + U_1;

U = piecewise( x > a * t, U_1, (x >= 0) & (x <= a*t), U_2);

T_num = 20; % количество шагов по времени
T_mesh = linspace(0,10,T_num);
X = 20;

figure;
set(gcf, 'Position', [100, 100, 1200, 600]);

% анимация
for i = 1:T_num
    f = fplot(subs(U,t,T_mesh(i)), [0,X]);
    axis([[0,X], [-1,5]]);
    title(['Кадр № ', num2str(i)]);
    pause(0.01);
end