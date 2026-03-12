function [r_m, psi_m] = randomPosWithSeparation(M, max_rad, min_sep)
%randomPosWithSeparation Sample points in a disk with a minimum spacing.
%
% The routine uses rejection sampling: candidate points are drawn uniformly
% in the disk until M valid positions are accepted or the trial budget is
% exhausted.

points = zeros(M, 2);
count = 0;
trials = 0;
max_trials = 1e6;

while count < M && trials < max_trials
    trials = trials + 1;
    r = sqrt(rand()) * max_rad;
    th = 2*pi * rand();
    x_c = r * cos(th);
    y_c = r * sin(th);

    if count == 0
        count = 1;
        points(count, :) = [x_c, y_c];
    else
        distances = sqrt(sum((points(1:count, :) - [x_c, y_c]).^2, 2));
        if all(distances >= min_sep)
            count = count + 1;
            points(count, :) = [x_c, y_c];
        end
    end
end

if count < M
    warning('Placed only %d of %d points.', count, M);
end

[psi_m, r_m] = cart2pol(points(1:count,1), points(1:count,2));
end
