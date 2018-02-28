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
%% WAITING TIME DISTRIBUTION
t = 0.1:10.1;
p = [0.2 0.4 0.7];
muMU = muL*F;
muServer = muL*F0;

w1 = zeros(1, length(t));
w2 = zeros(1, length(t));
w3 = zeros(1, length(t));
for i = 1:length(t)
    ro1_MU = (p(1)*lambda)/muMU;
    ro2_MU = (p(2)*lambda)/muMU;
    ro3_MU = (p(3)*lambda)/muMU;
    ro1_Server = ((1-p(1))*lambda)/muServer;
    ro2_Server = ((1-p(2))*lambda)/muServer;
    ro3_Server = ((1-p(3))*lambda)/muServer;
    
    wMU1 = 1 - (ro1_MU*exp(-(muMU-(p(1)*lambda))*t(i)));
    wMU2 = 1 - (ro2_MU*exp(-(muMU-(p(2)*lambda))*t(i)));
    wMU3 = 1 - (ro3_MU*exp(-(muMU-(p(3)*lambda))*t(i)));
    wServer1 = 1 - (erlangc(m,ro1_Server)*exp(-(muServer-(1-p(1))*lambda)*t(i)));
    wServer2 = 1 - (erlangc(m,ro2_Server)*exp(-(muServer-(1-p(2))*lambda)*t(i)));
    wServer3 = 1 - (erlangc(m,ro3_Server)*exp(-(muServer-(1-p(3))*lambda)*t(i)));
    
    w1(i)=p(1)*wMU1 + (1-p(1))*wServer1;
    w2(i)=p(2)*wMU2 + (1-p(2))*wServer2;
    w3(i)=p(3)*wMU3 + (1-p(3))*wServer3;
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
legend('Prob. 0.2','Prob. 0.4','Prob. 0.7');

    