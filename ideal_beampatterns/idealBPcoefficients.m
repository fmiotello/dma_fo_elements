function [a_N, b_2N] = idealBPcoefficients(pattern, N, form)
%idealBPcoefficients Compute ideal beampattern coefficients for a target pattern
%
% The output coefficients can be returned in either cosine power-series or harmonic-series form

switch pattern
    case 'omnidirectional'
        a_N = omnidirectionalCoefficients(N);

    case 'dipole'
        a_N = dipoleCoefficients(N);
        L = eye(N + 1);
        L(:, 2:end) = 0.5 * L(:, 2:end);
        L = [flipud(L); L(2:end, :)];
        b_2N = L * a_N;
        return;

    case 'cardioid'
        a_N = cardioidCoefficients(N);

    case 'hypercardioid'
        a_N = hypercardioidCoefficients(N);

    case 'supercardioid'
        a_N = supercardioidCoefficients(N);
end

switch form
    case 'power_series'
        b_2N = zeros(2 * N + 1, 1);

    case 'harmonic_series'
        a_N = pow2harmCoeffs(N) * a_N;
        L = eye(N + 1);
        L(:, 2:end) = 0.5 * L(:, 2:end);
        L = [flipud(L); L(2:end, :)];
        b_2N = L * a_N;
end
end

function P = pow2harmCoeffs(N)
%pow2harmCoeffs Convert power-series coefficients to harmonic-series form.

switch N
    case 1
        P = eye(2);
    case 2
        P = [1 0 1/2;
             0 1 0;
             0 0 1/2];
    case 3
        P = [1 0 1/2 0;
             0 1 0 3/4;
             0 0 1/2 0;
             0 0 0 1/4];
    case 4
        P = [1 0 1/2 0 3/8;
             0 1 0 3/4 0;
             0 0 1/2 0 1/2;
             0 0 0 1/4 0;
             0 0 0 0 1/8];
    case 5
        P = [1 0 1/2 0 3/8 0;
             0 1 0 3/4 0 5/8;
             0 0 1/2 0 1/2 0;
             0 0 0 1/4 0 5/16;
             0 0 0 0 1/8 0;
             0 0 0 0 0 1/16];
end
end
