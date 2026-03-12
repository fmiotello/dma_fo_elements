function [r_m, psi_m] = uniformCirclePos(M, max_rad)
%uniformCirclePos Generate M equally spaced points on a circle.
psi_m = linspace(0, 2*pi, M+1)';
psi_m(end) = [];

r_m = max_rad * ones(M,1);
end
