function [a_N, b_2N] = supercardioidCoefficients(N)
%supercardioidCoefficients Compute the coefficients of an Nth-order supercardioid.
        
%Compute a_nN Coefficients-------------------------------------------------

        ns=0:N;
        
        cost=@(a_nN) -FrontToBackRatio(ns,a_nN);
        %initial guess
        initguess=ones(N+1,1)/(N+1);
        %equality constraints
        Aeq=ones(1,N+1);           %sum(an_all)=0
        Beq=1;
        %actual minimization
        a_N=fmincon(cost,initguess,[],[],Aeq,Beq);

end


function [FBR] = FrontToBackRatio(ns,coeffs)

fr_th_ax=0:pi/360:pi/2;
bk_th_ax=pi/2:pi/360:pi;

for th=1:length(fr_th_ax)
    theta_fr=fr_th_ax(th);
    theta_bk=bk_th_ax(th);
    fr_BP(th)=sum(coeffs.*cos(theta_fr).^ns.')^2;
    bk_BP(th)=sum(coeffs.*cos(theta_bk).^ns.')^2;
end

FBR=sum(fr_BP)/sum(bk_BP);

end

function [FBR] = FrontToBackRatio_b2N(ns,coeffs)

fr_th_ax=0:pi/360:pi/2;
bk_th_ax=pi/2:pi/360:pi;

for th=1:length(fr_th_ax)
    theta_fr=fr_th_ax(th);
    theta_bk=bk_th_ax(th);
    fr_BP(th)=sum(coeffs.*exp(1i*theta_fr.*ns.'))^2;
    bk_BP(th)=sum(coeffs.*exp(1i*theta_bk.*ns.'))^2;
end

FBR=real(sum(fr_BP)/sum(bk_BP));

end

