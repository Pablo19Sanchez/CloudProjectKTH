clc
clear all
%% DATA
K = 10;
F0 = 45e9;
m = 15;
muD = 1/1e6;
muL = 1/0.5e9;
F = 0.6e9;
R = 4e6;
%% MEAN NUMBER OF USERS AND TIME IN SYSTEM
lambda = 0.1:0.1:1.5;
pl = [0.2 0.7];

usersMU_1 = zeros(1,length(lambda));
usersMU_2 = zeros(1,length(lambda));
usersServer_1 = zeros(1,length(lambda));
usersServer_2 = zeros(1,length(lambda));
usersLink_1 = zeros(1,length(lambda));
usersLink_2 = zeros(1,length(lambda));

for j=1:length(lambda)
    rho_MU_1 = (lambda(j)*pl(1))/(F*muL);
    rho_MU_2 = (lambda(j)*pl(2))/(F*muL);
    rho_Server_1 = (lambda(j)*m*K*(1-pl(1)))/(F0*muL);
    rho_Server_2 = (lambda(j)*m*K*(1-pl(2)))/(F0*muL);
    rho_Link_1 = (lambda(j)*(1-pl(1)))/(R*muD);
    rho_Link_2 = (lambda(j)*(1-pl(2)))/(R*muD);
    
    usersMU_1(j) = rho_MU_1/(1-rho_MU_1);
    usersMU_2(j) = rho_MU_2/(1-rho_MU_2);
    usersServer_1(j) = rho_Server_1 + ((rho_Server_1*erlangc(m,rho_Server_1))/(m-rho_Server_1));
    usersServer_2(j) = rho_Server_2 + ((rho_Server_2*erlangc(m,rho_Server_2))/(m-rho_Server_2));
    usersLink_1(j) = rho_Link_1/(1-rho_Link_1);
    usersLink_2(j) = rho_Link_2/(1-rho_Link_2);
end

usersSystem1_1 = pl(1)*usersMU_1 + ((1-pl(1))/K)*usersServer_1;
usersSystem1_2 = pl(2)*usersMU_2 + ((1-pl(2))/K)*usersServer_2;
timeSystem1_1 = usersMU_1./lambda + usersServer_1./(K*lambda);
timeSystem1_2 = usersMU_2./lambda + usersServer_2./(K*lambda);

usersSystem2_1 = pl(1)*usersMU_1 + (1-pl(1))*((usersServer_1/K) + usersLink_1);
usersSystem2_2 = pl(2)*usersMU_2 + (1-pl(2))*((usersServer_2/K) + usersLink_2);
timeSystem2_1 = usersMU_1./lambda + usersServer_1./(K*lambda) + usersLink_1./lambda;
timeSystem2_2 = usersMU_2./lambda + usersServer_2./(K*lambda) + usersLink_2./lambda;

figure(1)
plot(lambda,usersSystem1_1);
hold on
plot(lambda,usersSystem2_1,'r');
plot(lambda,usersSystem1_2,'g');
plot(lambda,usersSystem2_2,'k');
hold off
xlabel('Arrival rate (tasks/s)'); ylabel('Mean number of tasks in system');
legend('Model1 - Prob. 0.2','Model2 - Prob. 0.2', 'Model1 - Prob. 0.7','Model2 - Prob. 0.7');

figure(2)
plot(lambda,timeSystem1_1);
hold on
plot(lambda,timeSystem2_1,'r');
plot(lambda,timeSystem1_2,'g');
plot(lambda,timeSystem2_2,'k');
hold off
xlabel('Arrival rate (tasks/s)'); ylabel('Mean time of tasks in system (s)');
legend('Model1 - Prob. 0.2','Model2 - Prob. 0.2', 'Model1 - Prob. 0.7','Model2 - Prob. 0.7');
