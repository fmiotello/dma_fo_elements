%% main_montecarlo.m

clear; clc; close all;
addpath("utils");         
addpath("beamforming");   
addpath("plotting");      
addpath("ideal_beampatterns")

%% Parameters

c = 343;                                
freq = 50:50:4000;                     
omega = 2*pi*freq;
theta = deg2rad(-180:180);             
db_limit = -50;
plot_freq_idx = 20;
save_path = '~/Downloads/';

% Fixed parameters
n_exp = 10;
M = 9; max_rad = 0.02; min_sep = 0.008;
N = 2; shape = 'supercardioid'; theta_s = deg2rad(60);

% Target BP coefficients
[an, b2n] = idealBPcoefficients(shape, N, 'harmonic_series');

% Storage
BP_all = zeros(n_exp, length(freq), length(theta));
WNG_all = zeros(n_exp, length(freq));
DF_all  = zeros(n_exp, length(freq));

fprintf("Starting Monte Carlo simulation with %d experiments...\n", n_exp);
tic;

%% Monte Carlo loop
for i = 1:n_exp
    % Randomize positions and element properties
    [r_m, psi_m] = randomPosWithSeparation(M, max_rad, min_sep);

    q_m = rand(M,1); 
    theta_m = 2*pi*rand(M,1) - pi;

    % Design weights
    h = designBeamformer(r_m, psi_m, q_m, theta_m, omega, c, N, b2n, theta_s);

    % Compute metrics
    [BP, WNG, DF] = computeMetrics(h, r_m, psi_m, q_m, theta_m, omega, c, theta, theta_s);

    % Store
    BP_all(i,:,:) = max(20*log10(abs(BP)), db_limit);  % magnitude only
    WNG_all(i,:) = 10*log10(WNG);
    DF_all(i,:) = 10*log10(DF);

    fprintf("Completed %4d/%4d simulations\n", i, n_exp);
end

elapsedTime = toc;
fprintf("All simulations completed in %.2f seconds.\n", elapsedTime);

%% Compute mean and std
mean_BP = squeeze(mean(BP_all, 1));
std_BP  = squeeze(std(BP_all, 1, 1));

mean_WNG = mean(WNG_all, 1);
std_WNG  = std(WNG_all, 1, 1);

mean_DF = mean(DF_all, 1);
std_DF  = std(DF_all, 1, 1);

%% Plotting
plotBeampatternsWithError(mean_BP, std_BP, b2n, N, theta_s, theta, plot_freq_idx, db_limit);
plotWNGWithError(freq, mean_WNG, std_WNG);
plotDFWithError(freq, mean_DF, std_DF);
