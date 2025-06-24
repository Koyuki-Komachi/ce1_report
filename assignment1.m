clear all; close all; clc;

fprintf('=== P1(s) = (s + 200) / (s(s + 10)) の解析 ===\n');

num1 = [1 200];
den1 = [1 10 0];
P1 = tf(num1, den1);

omega_z1 = 200;
omega_p1 = 0;
omega_p2 = 10;

fprintf('零点: omega = %g [rad/s]\n', omega_z1);
fprintf('極点: omega = 0 [rad/s] (積分要素)\n');
fprintf('極点: omega = %g [rad/s]\n', omega_p2);

w = logspace(-2, 4, 1000);

K_dc = 20;

mag_approx1 = zeros(size(w));
for i = 1:length(w)
    omega = w(i);

    integral_gain = -20 * log10(omega);

    if omega < omega_z1
        zero_gain = 0;
    else
        zero_gain = 20 * log10(omega / omega_z1);
    end

    if omega < omega_p2
        pole_gain = 0;
    else
        pole_gain = -20 * log10(omega / omega_p2);
    end

    mag_approx1(i) = 20*log10(K_dc) + integral_gain + zero_gain + pole_gain;
end

[mag1, phase1, w_bode1] = bode(P1, w);
mag1_db = 20 * log10(squeeze(mag1));
phase1_deg = squeeze(phase1);

figure(1);
subplot(2,1,1);
semilogx(w, mag_approx1, 'r--', 'LineWidth', 2, 'DisplayName', '折れ線近似');
hold on;
semilogx(w_bode1, mag1_db, 'b-', 'LineWidth', 1.5, 'DisplayName', 'MATLAB bode');
grid on;
xlabel('Frequency [rad/s]');
ylabel('Magnitude [dB]');
title('P1(s) = (s + 200) / (s(s + 10)) - 振幅特性');
legend('Location', 'best');
xlim([1e-2, 1e4]);

subplot(2,1,2);
semilogx(w_bode1, phase1_deg, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Frequency [rad/s]');
ylabel('Phase [deg]');
title('P1(s) - 位相特性');
xlim([1e-2, 1e4]);

fprintf('\n=== P2(s) = (s + 100) / (s^2 + 0.1s + 1) の解析 ===\n');

num2 = [1 100];
den2 = [1 0.1 1];
P2 = tf(num2, den2);

omega_n = 1;
zeta = 0.1 / (2 * omega_n);
omega_z2 = 100;

fprintf('零点: omega = %g [rad/s]\n', omega_z2);
fprintf('固有角周波数: omega_n = %g [rad/s]\n', omega_n);
fprintf('減衰定数: zeta = %g\n', zeta);

DC_gain2 = 100 / 1;
fprintf('DC gain = %g =%g dB\n', DC_gain2, 20*log10(DC_gain2));

mag_approx2 = zeros(size(w));
for i = 1:length(w)
    omega = w(i);

    gain = 20 * log10(DC_gain2);

    if omega < omega_z2
        zero_gain = 0;
    else 
        zero_gain = 20 * log10(omega / omega_z2);
    end

    if omega < omega_n
        pole_gain = 0;
    else
        pole_gain = -40 * log10(omega / omega_n);
    end

    mag_approx2(i) = gain + zero_gain + pole_gain;
end

[mag2, phase2, w_bode2] = bode(P2, w);
mag2_db = 20 * log10(squeeze(mag2));
phase2_deg = squeeze(phase2);

figure(2);
subplot(2,1,1);
semilogx(w, mag_approx2, 'r--', 'LineWidth', 2, 'DisplayName', '折れ線近似');
hold on;
semilogx(w_bode2, mag2_db, 'b-', 'LineWidth', 1.5, 'DisplayName', 'MATLAB bode');
grid on;
xlabel('Frequency [rad/s]');
ylabel('Magnitude [dB]');
title('P2(s) = (s + 100) / (s^2 + 0.1s + 1) - 振幅特性');
legend('Location', 'best');
xlim([1e-1, 1e3]);

subplot(2,1,2);
semilogx(w_bode2, phase2_deg, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Frequency [rad/s]');
ylabel('Phase [deg]');
title('P2(s) - 位相特性');
xlim([1e-1, 1e3]);
