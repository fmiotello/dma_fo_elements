function [a_N] = omnidirectionalCoefficients(N)
%omnidirectionalCoefficients Compute the coefficients of an omnidirectional response.

%Compute a_nN Coefficients-------------------------------------------------
% Initialize comp with first element 1 and all others 0
a_N = zeros(N+1,1);
a_N(1) = 1;

end

