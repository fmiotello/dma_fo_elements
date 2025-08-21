function [a_N] = hypercardioidCoefficients(N)
%% hypercardioidCoeffs(N) computes the N+1 coefficients of a Nth order
% hypercardioid. Hypercardioid pattern is here defined as the pattern which
% maximizes the Directivity factor (assuming cylindrically isotropic noise field)
        
%Compute a_nN Coefficients-------------------------------------------------
        ns=0:N;
        
        cost=@(a_nN) -DirectivityFactor(ns,a_nN);
        %initial guess
        initguess=ones(N+1,1)/(N+1);
        %equality constraints
        Aeq=ones(1,N+1);           %sum(an_all)=0
        Beq=1;
        %actual minimization
        a_N=fmincon(cost,initguess,[],[],Aeq,Beq);

end


function [DF] = DirectivityFactor(ns,coeffs)

%compute beampattern
th_ax=0:pi/360:pi;
for th=1:length(th_ax)
    IdealBP(th)=sum(coeffs.*cos(th_ax(th)).^ns.');
end
%compute the directivity factor
DF=pi/sum(IdealBP.^2);

end

