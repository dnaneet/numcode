%% Problem statement
% 
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
V_1 = 0.1; %Volume in cubic meter, state 1
m = 0.5; %mass in kg
p_conv_bar = 0.1; %Pressure conversion factor; 1 Bar = 0.1 MPa
P_1_MPa = 0.4; %Pressure in MPa
P_1 = 0.4/p_conv_bar; %xsteam needs pressure in bar. State 1
P_2 = P_1; %Pressure at state 2.  1->2 is Isobaric process
T_2 = 300; %Temperature in Celcius, state 2
%% Calculation/processing
%Properties at state 1
v_1 = V_1/m; %Sp. volume in m^3/kg
h_1 = xsteam('h_prho',P_1, 1/v_1); %sp. enthalpy, kJ/kg
x_1 = xsteam('x_ph', P_1, h_1); %quality of steam
u_1 = xsteam('u_ph', P_1, h_1); %sp. internal energy, kJ/kg

%Properties at state 2
h_2 = xsteam('h_pT', P_2, T_2);
u_2 = xsteam('u_ph', P_2, h_2);

%First law of thermodynamics for a closed system
% dU = dQ - dW or du = dq - dw (specific values)

%Heat transfer during a constant pressure process: dQ = dH or dq = dh
dq = h_2 - h_1; %kJ/kg
dQ = m*dq; %kJ

%Boundary work done during the constant pressure process:
%dW = dQ - dU or dw = dq - du
dw = dq - (u_2 - u_1);
dW = m*dw;

%% Save data to file
%Save as table
T = table(dW, dQ, 'VariableNames', { 'W12', 'Q12'} );
writetable(T, 'Aneet_Narendranath_MATLAB_2x1.txt');

%save a comma separated data file
fid=fopen('Aneet_Narendranath_MATLAB_2x2.csv','w');
fprintf(fid, '%f, %f \n', [dQ dW]');
fclose(fid);
%% Postprocessing/Plot
%T-v diagram, water
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
