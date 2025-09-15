function [r_m, psi_m] = linearPos(M, d)
% Generates a symmetric linear array geometry (along x-axis).
% 
% INPUTS:
%   M - number of elements
%   d - inter-element spacing
%
% OUTPUTS:
%   r_m   - radial coordinates of elements
%   psi_m - angular coordinates of elements (in radians)

    % Element indices centered around zero
    if mod(M,2) == 0
        % Even number of elements: symmetric about 0 (no element at origin)
        idx = -(M/2 - 0.5) : (M/2 - 0.5);
    else
        % Odd number of elements: one element at origin
        idx = -(M-1)/2 : (M-1)/2;
    end

    % Cartesian coordinates (linear array along x-axis)
    x = idx * d;
    y = zeros(size(x));

    % Convert to polar coordinates
    [psi_m, r_m] = cart2pol(x, y);
    
    psi_m = psi_m';
    r_m = r_m';
end
