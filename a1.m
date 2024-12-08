clc 
clear
close all

% решение задачи Коши для ономерного волнового уравнения на "прямой"
% с использованием символьных вычислений

syms x t;
a = 0.4;

y = t - x/a;
y1 = x + a*t;
y2 = x - a*t;

% Задача 1
U_initial  = piecewise( abs(x) <= 2 , 1 + cos(2*pi*(2*x+3)),  abs(x) > 2 , 0); 

%U = 1/2 * (subs(U_initial, y1) + subs(U_initial, y2));

% Задача 2
U_initial  = piecewise( abs(x) <= 2 , 1 + x * cos(2*pi*(2*x+3)),  abs(x) > 2 , 0); 

%U = 1/2 * (subs(U_initial, y1) + subs(U_initial, y2));


% Задача 3
Ut_initial = piecewise((x >= 3) & (x <= 4), 2, (x < 3) | (x > 4), 0);

U = 1/2 * (subs(U_initial, y1) + subs(U_initial, y2)) + ...
    1/(2*a) * int(Ut_initial, x, y2, y1);


% Визуализация
T_num = 20; % количество шагов по времени
T_mesh = linspace(0,10,T_num);
X = 10;
X_range = [-X,X];
T_range = [-1,5];

figure;
set(gcf, 'Position', [100, 100, 1200, 600]);

% Анимация
for i = 1:T_num
    f = fplot(subs(U,t,T_mesh(i)), X_range);
    axis([X_range, T_range]);
    title(['Кадр № ', num2str(i)]);
    pause(1);
end