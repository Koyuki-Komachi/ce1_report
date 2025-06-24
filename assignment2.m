% 根軌跡の描画 - 最小限版
% P3(s) = 1/((s+2)(s^2+2s+2))

clear; close all; clc;

% 伝達関数の定義
num = 1;                    % 分子
den = [1 4 6 4];           % 分母: s^3 + 4s^2 + 6s + 4
P3 = tf(num, den);

% 根軌跡の描画
figure;
rlocus(P3);
grid on;
title('根軌跡 - P_3(s) = 1/((s+2)(s^2+2s+2))');
xlabel('実部 (Real Part)');
ylabel('虚部 (Imaginary Part)');

% 開ループ極の表示
poles = pole(P3);
hold on;
plot(real(poles), imag(poles), 'rx', 'MarkerSize', 10, 'LineWidth', 2);

% 漸近線の描画
% 漸近線の中心：σ = -4/3, 角度：60°, 180°, 300°
sigma_a = -4/3;
x_range = xlim;
y_range = ylim;

% 60°の漸近線
angle1 = 60 * pi/180;
x_vals = x_range;
y_vals = (x_vals - sigma_a) * tan(angle1);
plot(x_vals, y_vals, 'g--', 'LineWidth', 1.5);

% 180°の漸近線（水平線）
plot(x_range, [0 0], 'g--', 'LineWidth', 1.5);

% 300°（-60°）の漸近線
angle3 = -60 * pi/180;
y_vals = (x_vals - sigma_a) * tan(angle3);
plot(x_vals, y_vals, 'g--', 'LineWidth', 1.5);

% 虚軸との交点の表示
% s = ±j√6, K = 20
sqrt6 = sqrt(6);
plot(0, sqrt6, 'bo', 'MarkerSize', 8, 'LineWidth', 2);
plot(0, -sqrt6, 'bo', 'MarkerSize', 8, 'LineWidth', 2);

% 交点での値を表示
text(0.2, sqrt6, sprintf('s = j√6\nK = 20'), 'FontSize', 10, 'BackgroundColor', 'white');
text(0.2, -sqrt6-0.3, sprintf('s = -j√6\nK = 20'), 'FontSize', 10, 'BackgroundColor', 'white');

legend('根軌跡', '開ループ極', '漸近線', '虚軸交点', 'Location', 'best');