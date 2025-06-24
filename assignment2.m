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
legend('根軌跡', '開ループ極', 'Location', 'best');