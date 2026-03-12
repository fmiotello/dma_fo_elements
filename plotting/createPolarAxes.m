function pax = createPolarAxes(fig, db_limit)
%createPolarAxes Create polar axes.
if nargin < 1 || isempty(fig)
    fig = figure('Color', 'w');
end

pax = polaraxes(fig);
hold(pax, 'on');
pax.FontSize = 12;
pax.FontName = 'Times New Roman';
pax.ThetaTick = 0:30:330;
pax.ThetaTickLabels = arrayfun(@(x) sprintf('$%d^\\circ$', x), ...
    pax.ThetaTick, 'UniformOutput', false);
pax.TickLabelInterpreter = 'latex';
pax.RColor = 'k';
pax.ThetaColor = 'k';

if nargin >= 2 && ~isempty(db_limit)
    rticks = db_limit + 10 : 20 : 0;
    pax.RTick = rticks;
    pax.RTickLabel = arrayfun(@(r) sprintf('%d dB', r), rticks, ...
        'UniformOutput', false);
end
end
