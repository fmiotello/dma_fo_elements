%% main.m
% Author: Federico Miotello (Politecnico di Milano)
% Email: federico.miotello@polimi.it
% Date: March 2026
% Reference: F. Miotello, D. Albertini and A. Bernardini, "On the Extension of Differential Beamforming Theory to Arbitrary Planar Arrays of First-Order Elements," in IEEE Transactions on Audio, Speech and Language Processing.

clear; clc; close all;
addpath("utils");
addpath("beamforming");
addpath("plotting");
addpath("ideal_beampatterns")

%% Parameters
rng(123456789);
c = 343;                                   % Speed of sound [m/s]
freq = 50:50:4000;                         % Frequencies [Hz]
omega = 2*pi*freq;
theta = deg2rad(-180:180);                 % Angles [rad]

db_limit = -50;                            % dB plot limit
plot_freq_idx = 20;                        % Frequency idx to plot

%% Array geometry
M = 9; max_rad = 0.02; min_sep = 0.008;
[r_m, psi_m] = randomPosWithSeparation(M, max_rad, min_sep);

%% Element directivities
q_m = rand(M,1); theta_m = 2*pi*rand(M,1) - pi;

%% Target beampattern
N = 2; shape = 'hypercardioid'; theta_s = deg2rad(60);
[~, b2n] = idealBPcoefficients(shape, N, 'harmonic_series');

%% Design beamformer
h = designBeamformer(r_m, psi_m, q_m, theta_m, omega, c, N, b2n, theta_s);

%% Compute metrics
[BP, WNG, DF] = computeMetrics(h, r_m, psi_m, q_m, theta_m, omega, c, theta, theta_s);

%% Plot results
plotArrayGeometry(r_m, psi_m, q_m, theta_m, theta, max_rad);
plotBeampatterns(BP, b2n, N, theta_s, theta, plot_freq_idx, db_limit);
plotBeampatternsFrequency(BP, b2n, N, theta_s, theta, freq, db_limit);
plotWNG(freq, WNG);
plotDF(freq, DF);
