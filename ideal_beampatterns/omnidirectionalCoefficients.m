function [a_N] = omnidirectionalCoefficients(N)
%omnidirectionalCoefficients Compute the coefficients of an omnidirectional response

a_N = zeros(N + 1, 1);
a_N(1) = 1;
end
