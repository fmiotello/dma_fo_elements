function plotDFWithError(freq, mean_metric, std_metric)
% plotDFWithError  Plot directivity factor with shaded error band
figure('Color','w'); hold on;
freq_kHz = freq / 1e3;

y_mean = mean_metric;
y_upper = mean_metric + std_metric;
y_lower = mean_metric - std_metric;

% Draw shaded error band
hBand = patch([freq_kHz fliplr(freq_kHz)], [y_upper fliplr(y_lower)],[0.7 0.7 0.7],'LineStyle', 'none');
set(hBand, 'FaceAlpha', 0.5);  % 50% transparency

% Plot mean on top
plot(freq_kHz, y_mean, 'k', 'LineWidth', 1.5);

% Labels and grid
ylabel('$\mathcal{D}$ [dB]', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('Frequency [kHz]', 'Interpreter', 'latex', 'FontSize', 14);
grid on;

ax = gca;
ax.FontSize = 12;
ax.TickLabelInterpreter = 'latex';
ylim([0, 20]);
