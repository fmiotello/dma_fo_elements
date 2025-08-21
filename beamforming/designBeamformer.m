function h = designBeamformer(r_m, psi_m, q_m, theta_m, omega, c, N, b2n, theta_s)
%designBeamformer  Compute frequency-dependent beamforming weights
M = numel(r_m);
nfreq = numel(omega);
h = zeros(M, nfreq);
indices = N:-1:-N;
Upsilon = diag(exp(1j*indices*theta_s));

for idx = 1:nfreq
    x = (omega(idx)/c) * r_m;
    Xi = buildModeMatrix(x, psi_m, theta_m, q_m, N);
    h(:,idx) = pinv(conj(Xi)) * conj(Upsilon) * b2n;
end
end
