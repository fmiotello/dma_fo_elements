function [a_N] = dipoleCoefficients(N)
%dipoleCoefficients Compute the coefficients of an Nth-order dipole

a_N = zeros(N + 1, 1);
a_N(end) = 1;
end
