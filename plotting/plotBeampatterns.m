function plotBeampatterns(BP, b2n, N, theta_s, theta, freq_idx, db_limit)
target_BP = computeTargetBeampattern(b2n, N, theta_s, theta);

% Create polar axes
fig = figure('Color', 'w');
pax = createPolarAxes(fig, db_limit);

bp_db = max(20*log10(abs(BP(freq_idx,:))), db_limit);
target_bp_db = max(20*log10(abs(target_BP)), db_limit);
polarplot(pax, theta, bp_db, 'LineWidth', 2);
polarplot(pax, theta, target_bp_db, '--', 'LineWidth', 2);
rlim(pax, [db_limit, 10])
legend('$\mathcal{B}[\mathbf{h}(\omega),\theta]$','$\bar{\mathcal{B}}(\mathbf{b}_{2N}, \theta, \theta_s)$','Location','best','Interpreter','latex');
