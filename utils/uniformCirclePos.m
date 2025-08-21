function [r_m, psi_m] = uniformCirclePos(M, max_rad)
% Generates M regularly spaced points on a circle of radius max_rad
psi_m = linspace(0, 2*pi, M+1)';  
psi_m(end) = [];  % remove duplicate 2*pi

r_m = max_rad * ones(M,1);

end