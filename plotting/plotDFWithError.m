function plotDFWithError(freq, mean_metric, std_metric)
%plotDFWithError Plot the directivity factor with error band

plotMetricWithErrorBand(freq, mean_metric, std_metric, '$\mathcal{D}$ [dB]', [0, 20]);
