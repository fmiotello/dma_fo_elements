function [BP, WNG, DF] = computeMetrics(h, r_m, psi_m, q_m, theta_m, omega, c, theta, theta_s)
%computeMetrics  Evaluate beampattern, WNG, and directivity factor
nfreq = numel(omega);
ntheta = numel(theta);
BP  = zeros(nfreq, ntheta);
WNG = zeros(nfreq,1);
DF  = zeros(nfreq,1);

for f = 1:nfreq
    for t = 1:ntheta
        T = diag((1-q_m) + q_m.*cos(theta(t)-theta_m));
        D = exp(1j*(omega(f)/c) * r_m .* cos(theta(t)-psi_m));
        BP(f,t) = h(:,f)' * T * D;
    end
    % Steering vector metrics
    T_s = diag((1-q_m) + q_m.*cos(theta_s-theta_m));
    D_s = exp(1j*(omega(f)/c) * r_m .* cos(theta_s-psi_m));
    bp_s = h(:,f)' * T_s * D_s;
    WNG(f) = abs(bp_s)^2 / (h(:,f)'*h(:,f));
    DF(f)  = abs(bp_s)^2 / abs(mean(BP(f,:))).^2;
end
end
