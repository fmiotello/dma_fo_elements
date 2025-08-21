function [a_N, b_2N] = idealBPcoefficients(pattern, N, form)
%{
idealBPcoefficients(pattern, N, form) computes the ideal beampattern
coefficients given a desired beampattern, its order N, and the notation 
used to express the beampattern.
%}

%-------------------------PART I-------------------------------------------
%COMPUTE BEAMPATTERN COEFFICIENTS USING THE STANDARD COSINE POWER SERIES
% BEAMPATTERN FORM

switch pattern

    case 'omnidirectional'
        [a_N]=omnidirectionalCoefficients(N);

    case 'dipole'
        [a_N]=dipoleCoefficients(N);
        L=eye(N+1);
        L(:,2:end)=0.5*L(:,2:end);
        L=[flipud(L);L(2:end,:)];
        b_2N=L*a_N;
        return

    case 'cardioid'
        [a_N]=cardioidCoefficients(N);
%         plotBP_b2N(N,b_2N);
%         plotBP(N,a_N);

    case 'hypercardioid'
        [a_N]=hypercardioidCoefficients(N);
%         plotBP_b2N(N,b_2N);
%         plotBP(N,a_N);

    case 'supercardioid'
        [a_N]=supercardioidCoefficients(N);
%         plotBP_b2N(N,b_2N);
%         plotBP(N,a_N);

end

%-------------------------PART II------------------------------------------
%CONVERT PATTERN COEFFICIENTS TO BE USED pattern coefficients to be used 
% with the harmonic series 

switch form
    case 'power_series'

        b_2N=zeros(2*N+1,1);

    case 'harmonic_series'
        a_N=pow2harmCoeffs(N)*a_N;
        %derive b_2N coefficients from a_N coefficients
        L=eye(N+1);
        L(:,2:end)=0.5*L(:,2:end);
        L=[flipud(L);L(2:end,:)];
        b_2N=L*a_N;
end

end

%==========================================================================
%% FUNCTIONS
%==========================================================================

function plotBP(N,a_nN)

%COMPUTE Nth ORDER BEAMPATTERN from coefficients
ns=0:N;
th_ax=0:pi/360:2*pi;
for th=1:length(th_ax)
    theta=th_ax(th);
    IdealBP(th)=sum(a_nN.*cos(theta).^ns.');
end

%PLOT BEAMPATTERN
PolarPlotFloor=-50;
BP=20*log10(IdealBP);
BP(BP<PolarPlotFloor)=PolarPlotFloor;

figure(1)
polarplot(th_ax, BP);
rlim([PolarPlotFloor 5]);

end

function plotBP_b2N(N,b_2N)

%COMPUTE Nth ORDER BEAMPATTERN from coefficients
ns=-N:N;
th_ax=0:pi/360:2*pi;
for th=1:length(th_ax)
    theta=th_ax(th);
    IdealBP(th)=sum(b_2N.*exp(1i*theta.*ns'));
end

%PLOT BEAMPATTERN
PolarPlotFloor=-50;
BP=20*log10(IdealBP);
BP(BP<PolarPlotFloor)=PolarPlotFloor;

figure(2)
polarplot(th_ax, real(BP));
rlim([PolarPlotFloor 5]);

end

function P = pow2harmCoeffs(N)
%{
pow2harmCoeffs(N) is used to Convert beampattern coefficients from
the power series form to the harmonic series form
%}

switch N
    case 1
        P=eye(2);
    case 2
        P=[1  0  1/2;
            0  1   0 ;
            0  0  1/2];
    case 3
        P=[1  0  1/2   0;
            0  1   0   3/4;
            0  0  1/2   0;
            0  0   0   1/4];
    case 4
        P=[1  0  1/2   0   3/8;
            0  1   0   3/4   0;
            0  0  1/2   0   1/2;
            0  0   0   1/4   0;
            0  0   0    0   1/8];
    case 5
        P=[1  0  1/2   0   3/8   0;
            0  1   0   3/4   0   5/8;
            0  0  1/2   0   1/2   0;
            0  0   0   1/4   0   5/16;
            0  0   0    0   1/8   0;
            0  0   0    0    0   1/16];
end
end