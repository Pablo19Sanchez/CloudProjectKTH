clc
clear all
%% DATA
lambda = 1;
F0 = 45e9;
m = 15;
muD = 1/1e6;
muL = 1/0.5e9;
F = 0.6e9;
R = 4e6;
%% MEAN TIME IN SYSTEM
pl = 0:0.1:1;
K = [5 15 25];

usersMU = zeros(1,length(pl));
usersServer_1 = zeros(1,length(pl));
usersServer_2 = zeros(1,length(pl));
usersServer_3 = zeros(1,length(pl));
usersLink = zeros(1,length(pl));

for j=1:length(pl)
    rho_MU = (lambda*pl(j))/(F*muL);
    rho_Server_1 = (lambda*m*K(1)*(1-pl(j)))/(F0*muL);
    rho_Server_2 = (lambda*m*K(2)*(1-pl(j)))/(F0*muL);
    rho_Server_3 = (lambda*m*K(3)*(1-pl(j)))/(F0*muL);
    rho_Link = (lambda*(1-pl(j)))/(R*muD);
    
    usersMU(j) = rho_MU/(1-rho_MU);
    usersServer_1(j) = rho_Server_1 + ((rho_Server_1*erlangc(m,rho_Server_1))/(m-rho_Server_1));
    usersServer_2(j) = rho_Server_2 + ((rho_Server_2*erlangc(m,rho_Server_2))/(m-rho_Server_2));
    usersServer_3(j) = rho_Server_3 + ((rho_Server_3*erlangc(m,rho_Server_3))/(m-rho_Server_3));
    usersLink(j) = rho_Link/(1-rho_Link);
end

timeSystem1_1 = usersMU + usersServer_1/K(1);
timeSystem1_2 = usersMU + usersServer_2/K(2);
timeSystem1_3 = usersMU + usersServer_3/K(3);
timeSystem2_1 = usersMU/lambda + usersServer_1/(K(1)*lambda) + usersLink/lambda;
timeSystem2_2 = usersMU/lambda + usersServer_2/(K(2)*lambda) + usersLink/lambda;
timeSystem2_3 = usersMU/lambda + usersServer_3/(K(3)*lambda) + usersLink/lambda;

figure(1)
plot(pl,timeSystem1_1);
hold on
plot(pl,timeSystem1_2,'r');
plot(pl,timeSystem1_3,'g')
plot(pl,timeSystem2_1,'k');
plot(pl,timeSystem2_2,'y');
plot(pl,timeSystem2_3,'m');
hold off
xlabel('Prob. task goes to MU'); ylabel('Mean time of tasks in system (s)');
legend('Model1 - K = 5','Model1 - K = 15', 'Model1 - K = 25','Model2 - K = 5','Model2 - K = 15','Model2 - K = 25');