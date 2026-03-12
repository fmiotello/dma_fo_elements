function target_BP = computeTargetBeampattern(b2n, N, theta_s, theta)
%computeTargetBeampattern Evaluate the target beampattern on angle grid theta.
indices = N:-1:-N;
Upsilon = diag(exp(1j*indices*theta_s));
p = exp(-1j*indices' * theta);
target_BP = b2n' * Upsilon * p;
end
