clear;clc;
load K
load y0glu

y0=repmat(10^-7,[1 5]);
tt=linspace(0,3000,20)
K(18)=1.814;
K(23)=0.0477;
K(7)=0.026;
K(32)=4;
K(36)=4;
sol = dde23(@(t,sol,Z) IRMA(t,sol,Z,K,1,0,t), [100] ,y0,[0 3000]);

out=[sol.x;sol.y]';
plot(out(:,1),out(:,2:6));
axis([200 1200 0 max(max(out(:,2:6)))*1.1])
legend('CBF1','GAL4','SWI5','GAL80','ASH1');