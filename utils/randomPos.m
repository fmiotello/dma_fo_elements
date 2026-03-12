function [r_m, psi_m] = randomPos(M, max_rad)
%randomPos Generate random positions uniformly distributed in a circular area

r_m = sqrt(rand(M,1)) * max_rad;
psi_m = 2*pi*rand(M,1);
end
