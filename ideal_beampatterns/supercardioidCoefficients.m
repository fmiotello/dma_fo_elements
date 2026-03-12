function [a_N, b_2N] = supercardioidCoefficients(N)
%supercardioidCoefficients Compute the coefficients of an Nth-order supercardioid.

ns = 0:N;
cost = @(a_nN) -frontToBackRatio(ns, a_nN);
initguess = ones(N + 1, 1) / (N + 1);
Aeq = ones(1, N + 1);
Beq = 1;

a_N = fmincon(cost, initguess, [], [], Aeq, Beq);
b_2N = [];
end

function FBR = frontToBackRatio(ns, coeffs)
fr_th_ax = 0:pi/360:pi/2;
bk_th_ax = pi/2:pi/360:pi;
fr_BP = zeros(size(fr_th_ax));
bk_BP = zeros(size(bk_th_ax));

for th = 1:length(fr_th_ax)
    theta_fr = fr_th_ax(th);
    theta_bk = bk_th_ax(th);
    fr_BP(th) = sum(coeffs .* cos(theta_fr).^ns.')^2;
    bk_BP(th) = sum(coeffs .* cos(theta_bk).^ns.')^2;
end

FBR = sum(fr_BP) / sum(bk_BP);
end
