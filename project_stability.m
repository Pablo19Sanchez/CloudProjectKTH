%% DATA
K = 10;
F0 = 45e9;
m = 15;
muD = 1/1e6;
muL = 1/0.5e9;
F = 0.6e9;
R = 4e6;
%% STABILITY
pl = 0:0.1:1;
lambda_MU = (muL*F)./pl;
lambda_S = (muL*F0)./(K*(1-pl));
lambda_Link = (muD*R)./(1-pl);
lambda_S1 = zeros(1,length(pl));
lambda_S2 = zeros(1,length(pl));
for i=1:length(pl)
    lambda_S1(i)=min([lambda_MU(i),lambda_S(i)]);
    lambda_S2(i)=min([lambda_MU(i),lambda_S(i),lambda_Link(i)]);
end
figure(1)
plot(pl,lambda_MU);
hold on
plot(pl,lambda_S,'r');
plot(pl,lambda_Link,'g');
hold off
xlabel('Probability task goes to the MU'); ylabel('Maximum arrival rate');
legend('MU','Server','Trans. Link');

figure(2)
plot(pl,lambda_S1);
hold on
plot(pl,lambda_S2,'r');
hold off
xlabel('Probability task goes to the MU'); ylabel('Maximum arrival rate');
legend('Model1','Model2');