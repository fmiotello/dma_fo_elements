function plotBeampatternsFrequency(BP, b2n, N, theta_s, theta, freq, db_limit)

% target beampattern in dB and normalize
target_BP = computeTargetBeampattern(b2n, N, theta_s, theta);
target_BP_db = max(20*log10(abs(target_BP)), db_limit);
min_tdb = min(target_BP_db, [], 'all');
max_tdb = max(target_BP_db, [], 'all');

% wrap and normalize data
thetaWrap   = [theta, theta(1)+2*pi];
BPwrap      = max(20*log10(abs([BP, BP(:,1)])), db_limit);
BPwrap_ = (BPwrap - min_tdb) ./ (max_tdb - min_tdb);

% Flip frequencies (lowest first)
freq_flipped = fliplr(freq(:)');

% Build cylindrical coordinates
[TH, Fgrid] = meshgrid(thetaWrap, freq_flipped);
Rwall = BPwrap_;
Xwall = Rwall .* cos(TH);
Ywall = Rwall .* sin(TH);
Zwall = Fgrid;

% Plot surface
figure('Color','w');
hSurf = surf(Xwall, Ywall, Zwall/1e3, BPwrap, 'EdgeColor','none', 'FaceAlpha',1, 'HandleVisibility','off');
shading interp; colormap(jet);
cb = colorbar;
caxis([db_limit, 0]);
cb.Ticks = db_limit:10:0;
cb.TickLabels = arrayfun(@(x) sprintf('$%d\\,\\mathrm{dB}$', x), cb.Ticks, 'UniformOutput',false);
cb.TickLabelInterpreter = 'latex';

hold on

% Top polar cap: rendered vs target
rTop_rendered = Rwall(1,1:end-1);
Xcap = rTop_rendered .* cos(theta);
Ycap = rTop_rendered .* sin(theta);
Zcap = (freq_flipped(1)/1e3) * ones(size(Xcap));
patch(Xcap, Ycap, Zcap, 'w', 'LineWidth',2,'HandleVisibility','off','EdgeColor','b');

rTop_target = (target_BP_db - min_tdb) ./ (max_tdb - min_tdb);
Xcap2 = rTop_target .* cos(theta);
Ycap2 = rTop_target .* sin(theta);
patch(Xcap2, Ycap2, Zcap, 'w', 'LineStyle','--','LineWidth',2, 'FaceAlpha',0, 'HandleVisibility','off','EdgeColor','r');

% Grid and unit circles
t = linspace(0,2*pi,400);
xc = cos(t); yc = sin(t);
z_top = Zcap(1);
z_bot = freq_flipped(end)/1e3;
plot3(xc, yc, z_top*ones(size(t)), 'Color',[0.85 0.85 0.85], 'LineStyle','-', 'LineWidth',0.5, 'HandleVisibility','off');
plot3(xc, yc, z_bot*ones(size(t)), 'Color',[0.85 0.85 0.85], 'LineStyle','-', 'LineWidth',0.5, 'HandleVisibility','off');
zlim([freq_flipped(end)/1e3, Zcap(1)]);

% Polar grid lines (radial lines)
numRadialLines = 12;  % every 30°
theta_grid = linspace(0, 2*pi, numRadialLines + 1);  % +1 to close the loop
radii = [0.5];  % draw at these radii

for k = 1:numRadialLines
    x_line = [0, cos(theta_grid(k))];
    y_line = [0, sin(theta_grid(k))];
    z_top  = Zcap(1);  % z-level for top
    z_bot  = freq_flipped(end)/1e3;  % z-level for bottom

    % Vertical radial lines (top cap)
    plot3(x_line, y_line, z_top*ones(1,2), ...
        'Color', [0.85 0.85 0.85], 'LineStyle', '-', 'LineWidth', 0.5, 'HandleVisibility','off');

    % Vertical radial lines (bottom cap)
    plot3(x_line, y_line, z_bot*ones(1,2), ...
        'Color', [0.85 0.85 0.85], 'LineStyle', '-', 'LineWidth', 0.5, 'HandleVisibility','off');
end

% More concentric rings at intermediate radii
for r = radii
    x_ring = r * cos(t);
    y_ring = r * sin(t);
    
    plot3(x_ring, y_ring, Zcap(1)*ones(size(t)),'Color',[0.85 0.85 0.85], 'LineStyle', '-', 'LineWidth', 0.5, 'HandleVisibility','off');

    plot3(x_ring, y_ring, freq_flipped(end)/1e3*ones(size(t)),'Color',[0.85 0.85 0.85], 'LineStyle', '-', 'LineWidth', 0.5, 'HandleVisibility','off');
end

% Legend for LaTeX articles
hLine1 = plot3(NaN,NaN,NaN,'b-','LineWidth',2,  'DisplayName','$\mathcal{B}[\mathbf{h}(\omega),\theta]$');
hLine2 = plot3(NaN,NaN,NaN,'r--','LineWidth',2,'DisplayName','$\bar{\mathcal{B}}(\mathbf{b}_{2N}, \theta, \theta_s)$');
legend('show','Location','northwest','Interpreter','latex','FontSize',12)

view(45,25); grid on;
az = gca;
az.FontName = 'Times New Roman'; az.FontSize = 12; az.Box='on'; az.XTickLabel=[]; az.YTickLabel=[];
daspect([1 1 2.6]);
zticks([0,1,2,3,4]);
zticklabels([]);
zticklabels(string(freq(end:-20:1)/1e3));
zlabel('$f\,[\mathrm{kHz}]$','Interpreter','latex','FontSize',14);
