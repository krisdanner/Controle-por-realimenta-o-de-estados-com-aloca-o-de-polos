%===============================================================
% Controle por realimentação de estados com alocação de polos
%===============================================================
% Autor: Christian Danner Ramos de Carvalho
%===============================================================


close all
clear;
clc;

A = [0 6666.67;-1000 -1000];
B = [0;1000];
C = [1 0];
D = [0];
planta = ss(A,B,C,D);

eig(A)

polos_desejados = [-2582 -2582];
K = acker(A,B,polos_desejados);

M = ctrb(A,B);
rank(M)
eig(A-B*K)

Amf = A-B*K;
Bmf = zeros(2,1);
Cmf = C;
Dmf = D;
plantaMF = ss(Amf, Bmf, Cmf, Dmf);

x0 = [10;0];

t = linspace(0,0.02,1000);
[YMA tplotMF] = initial(planta,x0,t);
[YMF tplotMF] = initial(plantaMF,x0,t);

figure;
subplot(2,1,1);
plot(t,YMA,'linewidth',2);
xlabel('t(s)');
ylabel('Vc(t)');
legend('Malha Aberta');

subplot(2,1,2);
plot(t,YMF,'linewidth',2);
xlabel('t(s)');
ylabel('Vc(t)');
legend('Malha Fechada');
