function [a_N,b_2N] = cardioidCoefficients(N)
%cardioidCoefficients Compute the coefficients of an Nth-order cardioid.

%Compute a_nN Coefficients-------------------------------------------------

comp=[];
for k=0:N
    comp=[comp; nchoosek(N,k)];
end
%actual minimization
a_N=(1/2^N)*comp;

%Compute b_nN Coefficients-------------------------------------------------

L=eye(N+1);
L(:,2:end)=0.5*L(:,2:end);
L=[flipud(L);L(2:end,:)];

b_2N=L*a_N;


end


