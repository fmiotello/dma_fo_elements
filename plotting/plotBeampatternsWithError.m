function plotBeampatternsWithError(mean_BP, std_BP, b2n, N, theta_s, theta, freq_idx, db_limit)

% Build target beampattern
target_BP = computeTargetBeampattern(b2n, N, theta_s, theta);
target_db = max(20*log10(abs(target_BP)), db_limit);

mu_db = mean_BP(freq_idx, :);
upper_db = mean_BP(freq_idx, :) + std_BP(freq_idx, :);
lower_db = mean_BP(freq_idx, :) - std_BP(freq_idx, :);

% Create polar axes
fig = figure('Color', 'w');
pax = createPolarAxes(fig, db_limit);

hMean = polarplot(pax, theta, mu_db, 'b-', 'LineWidth', 2);
hTarget = polarplot(pax, theta, target_db, 'r--', 'LineWidth', 2);
rlim(pax, [db_limit, 10]);

% Show standard deviation as two lines around the mean, fill is not
% supported for polarplot in older matlab versions
polarplot(pax, theta, lower_db, '-', 'LineWidth', 0.5, 'Color', 'black');
polarplot(pax, theta, upper_db, '-', 'LineWidth', 0.5, 'Color', 'black');

% fill(pax, thetaAll, rAll, [0.7 0.7 0.7], 'FaceAlpha', 0.5, 'EdgeColor',
% 'none'); % Only works with newer matlab versions

hold(pax,'off');

legend(pax, [hMean, hTarget],{'$\mathcal{B}[\mathbf{h}(\omega),\theta]$', '$\bar{\mathcal{B}}(\mathbf{b}_{2N}, \theta, \theta_s)$'},'Location','southwest', 'Interpreter', 'latex')
