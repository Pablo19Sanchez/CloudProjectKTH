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
p = 0.4;
%% WAITING TIME DISTRIBUTION
t = 0.1:10.1;
lambda = [0.1 0.8 1.5];
muMU = muL*F;
muServer = muL*F0;

w1 = zeros(1, length(t));
w2 = zeros(1, length(t));
w3 = zeros(1, length(t));
for i = 1:length(t)
    ro1_MU = (p*lambda(1))/muMU;
    ro2_MU = (p*lambda(2))/muMU;
    ro3_MU = (p*lambda(3))/muMU;
    ro1_Server = ((1-p)*lambda(1))/muServer;
    ro2_Server = ((1-p)*lambda(2))/muServer;
    ro3_Server = ((1-p)*lambda(3))/muServer;
    
    wMU1 = 1 - (ro1_MU*exp(-(muMU-(p*lambda(1)))*t(i)));
    wMU2 = 1 - (ro2_MU*exp(-(muMU-(p*lambda(2)))*t(i)));
    wMU3 = 1 - (ro3_MU*exp(-(muMU-(p*lambda(3)))*t(i)));
    wServer1 = 1 - (erlangc(m,ro1_Server)*exp(-(muServer-(1-p)*lambda(1))*t(i)));
    wServer2 = 1 - (erlangc(m,ro2_Server)*exp(-(muServer-(1-p)*lambda(2))*t(i)));
    wServer3 = 1 - (erlangc(m,ro3_Server)*exp(-(muServer-(1-p)*lambda(3))*t(i)));
    
    w1(i)=p*wMU1 + (1-p)*wServer1;
    w2(i)=p*wMU2 + (1-p)*wServer2;
    w3(i)=p*wMU3 + (1-p)*wServer3;
end

%% PLOT FIGURES
figure(1)
hax=axes; 
plot(t,w1);
hold on 
plot(t,w2,'g');
plot(t,w3,'k');
SP=2.1; %your point goes here 
line([SP SP],get(hax,'YLim'),'Color',[1 0 0])
hold off
xlabel('Time (s)'); ylabel('Fw(t)');
legend('\lambda 0.1','\lambda 0.8','\lambda 1.5');