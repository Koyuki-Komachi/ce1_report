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
    num = K * wn;
    den = [1, 2*zeta*wn, wn^2];
    sys = tf(num, den);
    [y_matlab, t_matlab] = step(sys, t);
    
    % 2) 手計算による逆ラプラス変換
    if zeta < 1  % 振動系 (underdamped)
        wd = wn * sqrt(1 - zeta^2);
        y_manual = K * (1 - exp(-zeta*wn*t) .* (cos(wd*t) + (zeta*wn/wd)*sin(wd*t)));
    elseif zeta == 1  % 臨界減衰 (critically damped)
        y_manual = K * (1 - exp(-wn*t) .* (1 + wn*t));
    else  % 過減衰 (overdamped)
        r1 = -zeta*wn + wn*sqrt(zeta^2 - 1);
        r2 = -zeta*wn - wn*sqrt(zeta^2 - 1);
        y_manual = K * (1 - (r2*exp(r1*t) - r1*exp(r2*t))/(r2 - r1));
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