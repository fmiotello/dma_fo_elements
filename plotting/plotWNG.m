function plotWNG(freq, WNG)
figure('Color','w');
plot(freq/1e3, 10*log10(WNG),'LineWidth',1.5);
ylabel('$\mathcal{W}$ [dB]', 'Interpreter','latex', 'FontSize', 14);
xlabel('Frequency [kHz]', 'Interpreter','latex', 'FontSize', 14);
grid on;
ax = gca;
ax.FontSize = 12;
ax.TickLabelInterpreter = 'latex';
ylim([-80,20])
