function Xi = buildModeMatrix(x, psi_m, theta_m, q_m, N)
%buildModeMatrix  Assemble modal response matrix Xi
M = numel(q_m);
Xi = zeros(2*N + 1, M);
varphi_m = theta_m - psi_m;

for n = -N:N
    c_omni = (1j^n) * besselj(n, x) .* exp(1j*n*(varphi_m));
    c_dip  = 1j^(n+1)/2 * (besselj(n+1,x).*exp(1j*(n+1)*(varphi_m)) - besselj(n-1,x).*exp(1j*(n-1)*(varphi_m)));
    row = ((1 - q_m).*c_omni + q_m.*c_dip) .* exp(-1j*n*theta_m);
    Xi(n + N + 1, :) = row.';
end
end
