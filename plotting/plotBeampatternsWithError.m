function plotBeampatternsWithError(mean_BP, std_BP, b2n, N, theta_s, theta, freq_idx, db_limit)

% Build target beampattern
indices    = N:-1:-N;
Upsilon    = diag(exp(1j*indices*theta_s));
pVec       = exp(-1j*indices' * theta);
target_BP  = b2n' * Upsilon * pVec;
target_db  = max(20*log10(abs(target_BP)), db_limit);

mu_db = mean_BP(freq_idx, :);
upper_db = mean_BP(freq_idx, :) + std_BP(freq_idx, :);
lower_db = mean_BP(freq_idx, :) - std_BP(freq_idx, :);

% Create polar axes
fig = figure('Color', 'w');
pax = polaraxes(fig); hold(pax, 'on');
pax.FontSize          = 12;
pax.ThetaTick         = 0:30:330;
pax.ThetaTickLabels   = arrayfun(@(x) sprintf('$%d^\\circ$', x), pax.ThetaTick, 'UniformOutput', false);
pax.TickLabelInterpreter = 'latex';

rticks = db_limit+10 : 20 : 0;    
pax.RTick      = rticks;
pax.RTickLabel = arrayfun(@(r) sprintf('%d dB', r), rticks,'UniformOutput', false);

hold on

hMean = polarplot(pax, theta, mu_db, 'b-', 'LineWidth', 2);
hTarget = polarplot(pax, theta, target_db, 'r--', 'LineWidth', 2);
rlim(pax, [db_limit, 10]);

% Show standard deviation as two lines around the mean, fill is not
% supported for polarplot in older matlab versions
polarplot(pax, theta, lower_db, '-', 'LineWidth', 0.5, 'Color', 'black');
polarplot(pax, theta, upper_db, '-', 'LineWidth', 0.5, 'Color', 'black');

thetaAll = [theta, fliplr(theta)];
rAll     = [lower_db, fliplr(upper_db)];
% fill(pax, thetaAll, rAll, [0.7 0.7 0.7], 'FaceAlpha', 0.5, 'EdgeColor',
% 'none'); % Only works with newer matlab versions

hold(pax,'off');

legend(pax, [hMean, hTarget],{'$\mathcal{B}[\mathbf{h}(\omega),\theta]$', '$\bar{\mathcal{B}}(\mathbf{b}_{2N}, \theta, \theta_s)$'},'Location','southwest', 'Interpreter', 'latex')