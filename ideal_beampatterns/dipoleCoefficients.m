function [a_N] = dipoleCoefficients(N)
%dipoleCoefficients Compute the coefficients of an Nth-order dipole.

%Compute a_nN Coefficients-------------------------------------------------
% Initialize comp with first element 1 and all others 0
a_N = zeros(N+1,1);
a_N(end) = 1;

end
