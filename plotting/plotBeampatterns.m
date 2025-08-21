function plotBeampatterns(BP, b2n, N, theta_s, theta, freq_idx, db_limit)
indices = N:-1:-N;
Upsilon = diag(exp(1j*indices*theta_s));
p = exp(1j*(-indices')*theta);
target_BP = b2n' * Upsilon * p;

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


bp_db   = max(20*log10(abs(BP(freq_idx,:))), db_limit);
target_bp_db  = max(20*log10(abs(target_BP)), db_limit);
p1 = polarplot(theta, bp_db,'LineWidth',2);
hold on;
p2 = polarplot(theta, target_bp_db, '--','LineWidth',2);
rlim([db_limit, 10])
legend('$\mathcal{B}[\mathbf{h}(\omega),\theta]$','$\bar{\mathcal{B}}(\mathbf{b}_{2N}, \theta, \theta_s)$','Location','best','Interpreter','latex');
