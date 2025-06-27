% 標準2次系のステップ応答比較
% パラメータ設定
K = 1;
wn = 1;
zeta_values = [0.2, 0.7, 1, 2];
t = 0:0.01:10;  % 時間ベクトル

figure;
colors = ['r', 'g', 'b', 'm'];

for i = 1:length(zeta_values)
    zeta = zeta_values(i);
    
    % 1) MATLABによるステップ応答
    num = K * wn^2;
    den = [1, 2*zeta*wn, wn^2];
    sys = tf(num, den);
    [y_matlab, t_matlab] = step(sys, t);
    
    % 2) 手計算で求めた具体的な式
    if zeta == 0.2
        y_manual = 1 - exp(-0.2*t) .* (cos(0.9798*t) + 0.2041*sin(0.9798*t));
    elseif zeta == 0.7
        y_manual = 1 - exp(-0.7*t) .* (cos(0.7141*t) + 0.9801*sin(0.7141*t));
    elseif zeta == 1
        y_manual = 1 - exp(-t) .* (1 + t);
    elseif zeta == 2
        y_manual = 1 - (3.7321*exp(-0.2679*t) - 0.2679*exp(-3.7321*t))/3.4641;
    end
    
    % プロット
    subplot(2, 2, i);
    plot(t_matlab, y_matlab, colors(i), 'LineWidth', 2, 'DisplayName', 'MATLAB step');
    hold on;
    plot(t, y_manual, '--', 'Color', colors(i), 'LineWidth', 2, 'DisplayName', '手計算');
    
    title(sprintf('ζ = %.1f', zeta));
    xlabel('Time [s]');
    ylabel('Amplitude');
    legend('Location', 'best');
    grid on;
end

sgtitle('標準2次系のステップ応答比較 (K=1, ωn=1)');