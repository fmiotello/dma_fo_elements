function plotDF(freq, DF)
figure('Color','w');
plot(freq/1e3, 10*log10(DF),'LineWidth',1.5);
ylabel('$\mathcal{D}$ [dB]', 'Interpreter','latex', 'FontSize', 14);
xlabel('Frequency [kHz]', 'Interpreter','latex', 'FontSize', 14);
grid on;
styleMetricAxes();
ylim([-80,20])
