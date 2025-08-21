function [a_N] = omnidirectionalCoefficients(N)
%% omnidirectionalCoefficients(N) computes the N+1 coefficients of a Nth order omni.

%Compute a_nN Coefficients-------------------------------------------------
% Initialize comp with first element 1 and all others 0
a_N = zeros(N+1,1);
a_N(1) = 1;

end


