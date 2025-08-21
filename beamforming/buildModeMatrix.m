function Xi = buildModeMatrix(x, psi_m, theta_m, q_m, N)
%buildModeMatrix  Assemble modal response matrix Xi
Xi = [];

for n = -N:N
    varphi_m = theta_m - psi_m;
    c_omni = (1j^n) * besselj(n, x) .* exp(1j*n*(varphi_m));
    c_dip  = 1j^(n+1)/2 * (besselj(n+1,x).*exp(1j*(n+1)*(varphi_m)) - besselj(n-1,x).*exp(1j*(n-1)*(varphi_m)));
    row = ((1 - q_m).*c_omni + q_m.*c_dip) .* exp(-1j*n*theta_m);
    Xi = [Xi; row.'];
end
end
