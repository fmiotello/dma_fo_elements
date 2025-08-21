function plotArrayGeometry(r_m, psi_m, q_m, theta_m, theta, max_rad)
figure('Color','w');
pax = polaraxes; hold(pax,'on');

% Configure axes appearance
pax.FontName = 'Times New Roman';
pax.FontSize = 12;
pax.RColor = 'k';
pax.ThetaColor = 'k';

% Define theta ticks
pax.ThetaTick = 0:30:330;

labels = arrayfun(@(x) sprintf('$%d^\\circ$', x), pax.ThetaTick, 'UniformOutput', false);
pax.ThetaTickLabels = labels;
pax.TickLabelInterpreter = 'latex';

% Plot array geometry elements
for ll = 1:numel(r_m)
    T = (1 - q_m(ll)) + q_m(ll)*cos(theta - theta_m(ll));
    [dx, dy] = pol2cart(theta, 0.003*abs(T));
    [x0, y0] = pol2cart(psi_m(ll), r_m(ll));
    [th, r] = cart2pol(x0+dx, y0+dy);
    polarplot(pax, th, r, 'k','LineWidth',1);
end
polarscatter(pax, psi_m, r_m, 30, 'k','filled');

pax.RLim   = [0, max_rad+0.004];
rticks     = pax.RTick;            

labels     = repmat({''}, size(rticks));
[~,idx]    = min(abs(rticks - max_rad));
labels{idx} = sprintf('$%.2f\\,$m', rticks(idx));

pax.RTick       = rticks;
pax.RTickLabels = labels;
pax.RAxis.Label.Interpreter = 'latex';