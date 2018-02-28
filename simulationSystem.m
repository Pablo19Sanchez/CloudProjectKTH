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
lambda = 1;
pl = 0.1:0.01:0.9;
muMU = muL * F;
muLink = muD * R;
muServer = ((1/muL)*F0)/m;
time = 10;
%% PARAMETERS FOR THE SIMULATION FROM SIMEVENTS
waitingTime = zeros(1, length(pl));
timeTask = zeros(1, length(pl));
for i=1:length(pl)
    p = pl(i);
    lambdaMU = lambda*p;
    lambdaLink = lambda*(1-p);
    lambdaServer = (K-1)*lambda*(1-p);
    sim('system.mdl',time);
    waitingTime(i) = W_MU(end) + W_Link(end) + W_Server(end);
    timeTask(i) = TimeSystem(end);
end
%% PRINT RESULTS
figure(1)
plot(pl,waitingTime);
hold on
plot(pl,timeTask,'r');
hold off
ylabel('Time (s)'); xlabel('Probability task goes to terminal');
legend('Mean Waiting','Served Task Time');
