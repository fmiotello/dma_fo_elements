function [a_N] = hypercardioidCoefficients(N)
%hypercardioidCoefficients Compute the coefficients of an Nth-order hypercardioid

ns = 0:N;
cost = @(a_nN) -directivityFactor(ns, a_nN);
initguess = ones(N + 1, 1) / (N + 1);
Aeq = ones(1, N + 1);
Beq = 1;

a_N = fmincon(cost, initguess, [], [], Aeq, Beq);
end

function DF = directivityFactor(ns, coeffs)
th_ax = 0:pi/360:pi;
idealBP = zeros(size(th_ax));

for th = 1:length(th_ax)
    idealBP(th) = sum(coeffs .* cos(th_ax(th)).^ns.');
end

DF = pi / sum(idealBP.^2);
end
