function plotWNGWithError(freq, mean_metric, std_metric)
%plotWNGWithError Plot the white-noise gain with an error band

plotMetricWithErrorBand(freq, mean_metric, std_metric, '$\mathcal{W}$ [dB]', [-80, 20]);
