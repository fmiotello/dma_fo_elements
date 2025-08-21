function [a_N] = dipoleCoefficients(N)
%% dipole0Coefficients(N) computes the N+1 coefficients of a Nth order 0 deg dipole.

%Compute a_nN Coefficients-------------------------------------------------
% Initialize comp with first element 1 and all others 0
a_N = zeros(N+1,1);
a_N(end) = 1;

end

