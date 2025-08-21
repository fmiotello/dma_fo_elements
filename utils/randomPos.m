function [r_m, psi_m] = randomPos(M, max_rad)
% Generates M random points in a disk of radius max_rad
r_m = sqrt(rand(M,1)) * max_rad;
psi_m = 2*pi*rand(M,1);

end