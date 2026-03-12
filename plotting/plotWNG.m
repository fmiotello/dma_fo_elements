function plotWNG(freq, WNG)
%plotWNG Plot the white-noise gain over frequency

figure('Color','w');
plot(freq/1e3, 10*log10(WNG),'LineWidth',1.5);
ylabel('$\mathcal{W}$ [dB]', 'Interpreter','latex', 'FontSize', 14);
xlabel('Frequency [kHz]', 'Interpreter','latex', 'FontSize', 14);
grid on;
styleMetricAxes();
ylim([-80,20])
