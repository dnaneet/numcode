%% REA 3-3
% A container which has a volume of 0.1 cubic meter is fitted with a plunger
% enclosing 0.5 kg of steam at 0.4 MPa.  Calculate the amount of heat
% transfered and the work done when the steam is heated to 300 C at
% constant pressure.
%
% Narendranath (c) 2019 
%
%% Initialization cell
clc;
clear;
V_1 = 0.1; %cubic meter
m = 0.5; %kg
conv_bar = 0.1; %1 Bar = 0.1 MPa
P_1_MPa = 0.4; %MPa
P_1 = 0.4/conv_bar;
P_2 = P_1;
T_2 = 300; %Celcius
%% Calculation/processing
%Properties at state 1
v_1 = V_1/m;
h_1 = xsteam('h_prho',P_1, 1/v_1);
x_1 = xsteam('x_ph', P_1, h_1);
u_1 = xsteam('u_ph', P_1, h_1);

%Properties at state 2
h_2 = xsteam('h_pT', P_2, T_2);
u_2 = xsteam('u_ph', P_2, h_2);

%First law of thermodynamics for a closed system
% dU = dQ - dW or du = dq - dw

%Heat transfer during a constant pressure process: dQ = dH or dq = dh
dq = h_2 - h_1; %kJ/kg
dQ = m*dq; %kJ

%Boundary work done during the constant pressure process:
%dW = dQ - dU or dw = dq - du
dw = dq - (u_2 - u_1);
dW = m*dw;
%% Postprocessing/Plot
%% T-v diagram, water
close all;
T = linspace(0,500,1000); % range of temperatures
figure; hold on;

for P = [0.001 0.01 0.1 1 10 100 225] % bar
    %xsteam is not vectorized, so here is an easy way to compute a
    %vector of entropies
    v = arrayfun(@(t) xsteam('v_pT',P,t),T);
    plot(v,T,'b-')
    text(v(end),T(end),sprintf('%1.1f bar',P),'rotation',90)
end

set(gca,'Position',[0.13 0.11 0.775 0.7])
%saturated vapor and liquid specific volume lines
vvap = arrayfun(@(t) xsteam('vV_T',t),T);
vliq = arrayfun(@(t) xsteam('vL_T',t),T);

plot(vvap,T,'k-', 'LineWidth', 2)
plot(vliq,T,'k-', 'LineWidth', 2)
set(gca, 'XScale', 'log')
set(gca, 'FontSize', 14);
xlabel('Specific Volume (m^3/kg)', 'FontSize', 15)
ylabel('Temperature (^\circC)','FontSize', 15)
xlim([0 250]);
hold on;
%% Locating states on T-v diagram
T_1 = xsteam('T_ph', P_1, h_1);
plot(v_1, T_1, 'rs', 'MarkerSize',8, 'MarkerFaceColor','r');
text(v_1+0.01, T_1,sprintf('State-1','rotation',60), 'FontSize', 16)

v_2 = xsteam('v_ph',P_2, h_2);
plot(v_2, T_2, 'rs', 'MarkerSize',8, 'MarkerFaceColor','r')
text(v_2+0.01, T_2 ,sprintf('State-2','rotation',60), 'FontSize', 16)

%eof
