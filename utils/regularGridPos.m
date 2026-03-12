function [r_m, psi_m] = regularGridPos(N_side, elem_sep)
%regularGridPos Generate a square grid of points centered at the origin

    % Generate symmetric coordinates
    if mod(N_side,2) == 0
        % Even number → symmetric but no element exactly at 0
        axisVals = (-(N_side/2) + 0.5 : N_side/2 - 0.5) * elem_sep;
    else
        % Odd number → includes origin
        axisVals = (-(N_side-1)/2 : (N_side-1)/2) * elem_sep;
    end

    % Build full grid
    [X, Y] = meshgrid(axisVals, axisVals);
    x_l = X(:);
    y_l = Y(:);

    % Convert to polar
    [psi_m, r_m] = cart2pol(x_l, y_l);
end
