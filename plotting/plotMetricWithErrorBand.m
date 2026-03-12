function plotMetricWithErrorBand(freq, mean_metric, std_metric, y_label, y_limits)
%plotMetricWithErrorBand Plot mean curve with a shaded one-standard-deviation band.
figure('Color', 'w');
hold on;
freq_kHz = freq / 1e3;

y_upper = mean_metric + std_metric;
y_lower = mean_metric - std_metric;

hBand = patch([freq_kHz fliplr(freq_kHz)], ...
    [y_upper fliplr(y_lower)], [0.7 0.7 0.7], 'LineStyle', 'none');
set(hBand, 'FaceAlpha', 0.5);

plot(freq_kHz, mean_metric, 'k', 'LineWidth', 1.5);
ylabel(y_label, 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Frequency [kHz]', 'Interpreter', 'latex', 'FontSize', 14);
grid on;
styleMetricAxes();
ylim(y_limits);
end
