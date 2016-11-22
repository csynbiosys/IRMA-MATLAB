                                 %IRMA5.m
%                      Smith predictor/FeedBack Control/Relay
%=========================================================================
%|                   Code written by Gianfranco Fiore                     |
%|                       gianfrancofiore@inwind.it                        | 
%=========================================================================      
%|                     Stand Alone Control Algorithm                      |
%|                            code version 0.0.3                          |
%|                               24/07/2011                               |
%=========================================================================

% %=========================================================================
% %  Script to simulate the revised toplogy IRMA as in (Marucci et al, 2009)
% %                                  ---
% %                   Filippo Menolascina - 22/11/2016
% %=========================================================================
% 
% clear;clc;
% load K
% load y0glu
% 
% tt=linspace(0,3000,20)
% sol = dde23(@(t,sol,Z) IRMA(t,sol,Z,K,1,1,t), [100] ,y0,[0 3000]);
% 
% out=[sol.x;sol.y]';
% plot(out(:,1),out(:,2));
% axis([0 3000 0 0.05])
% %=========================================================================

function dy = IRMA5(t,y,Z,K,u,pend,tlast)
%fprintf('Pend = %f and tlast = %f\n',pend,tlast);
%IRMA
%alfa=teta(2);
%K=[0,0.0404324055000000,1,0.0356000000000000,0.0221812275000000,0.000149286100000000,0.000882735200000000,0.0372000000000000,0.0477845334000000,0.201360986100000,0.00297081400000000,0.00223775600000000,0.200000000000000,0.0937500000000000,0.421662678000000,0.000740000000000000,0.0146950000000000,1.81400000000000,0.0980450000000000,0.167615000000000,0.000610000000000000,0.0181941480000000,1.81400000000000,0.0500000000000000,9,3,9;];
%variabili da minimizzare con il Simulated annealing
% K(28)= 0.0900;
% K(29)= 0.0154;
% K(30)= 0.0154;

%u=u(1)+(t-K(29))*K(28);
% var=load('galtime.mat');
% galtime=var.galtime;
% u=1/2*(sign(t+galtime*60)-sign(t-galtime*60));

%u=1;

v=1;
deg=1;
alfa3=1;
deg3=1;
alfa4=1;
deg4=1;
alfa6=1;
deg6=1;
dec=1;
% CBF1 mRNA
% dy(1,1)= ((K(1)+ v*K(2)* (Z(3).^K(31)./( (K(3).^K(31)+Z(3).^K(31)) *( 1+((y(5).^K(32))/(K(4).^K(32))))  ))  -deg* K(5)*y(1))); 
dy(1,1) = K(1) + K(2) * (K(4)^K(32)/(K(4)^K(32)+y(5)^K(32))) - K(5)*y(1);
% GAL4 mRNA
dy(2,1) = (K(6)+K(7)*(y(1).^K(33) /(K(8).^K(33) +y(1).^K(33)) ) -  K(9) *y(2));
% SWI5 mRNA (note that the values of 3 parameters change depending on the medium, galactose
% or glucose)
dy(3,1) =(K(11)*alfa3+ (K(12)*(1-u)+u*(K(12)*K(25)) )  *(y(2).^K(34)./(  (K(14)*(1-u)+u*(K(14)/K(27)) ).^K(34) +y(2).^K(34)  .*( 1+(y(4).^K(37)./(   (K(13)*(1-u)+u*(K(13)*K(26)) ).^K(37))  ))  )    ) -deg3*K(15)*y(3));
% GAL80 mRNA
dy(4,1) =(K(16)+K(17)*(y(3).^K(35)/(K(18).^K(35)+y(3).^K(35)) )- K(19) *y(4) );
% ASH1 mRNA
dy(5,1) =(K(21)*alfa4+ K(22)*(y(3).^K(36)/(K(23).^K(36)+y(3).^K(36)))-K(24)*deg4*y (5));

end