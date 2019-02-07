%CB9
%4-5 A piston-cylinder device contains 25 gram of saturated water wave that
%is maintained at constant pressure of 300 kPa.  A resistance heater within
%the cylinder is turned on and passes a current of 0.2 Ampere for 5 minute,
%from a 120-Volt source.  At the same time, a heat loss of 3.7 kJ occurs.
%(a) Show that for a closed system, the boundary work W_b and the change in
%internal energy, DeltaU, in the first-law relation can be combined into
%the one term, DeltaH, for a constant-pressure process.  (b) Determine the
%final temperature of the steam.
%
%Aneet Narendranath, PhD (c) 2018
%

%Preamble to clear screen and any variables in the workspace:
%------------------------------------------------------------
clc; %clear console
clear all;

%NOTE: For part (a), please refer to the textbook
%----

%Given info:
%-----------
m_water = 0.025; %kg
P_1 = 300/100; %bar (300 kPa = 3bar)
i = 0.2; %Ampere
V_p = 120; %voltage
dt = 300; %seconds
Q_out = -3700; %Joule of heat lost 

%To find:
%--------
%(b) Final temperature of the steam.
%The closed system energy balance is given by:
% DeltaE_system = E_in - E_out. 
%
% A closed system allows work and heat interactions with it's surroundings;
% it is the ISOLATED system that does not have these interactions, with
% it's surroundings.
%
% LHS => E_in - E_out =  W_electric,in - Q_out - W_boundary 
% RHS => DeltaU (internal energy change)
% The reason the W_boundary term is being subtracted is because, as heat is
% lost, to maintain a constant pressure, the fluid will be compressed.
% Loss of heat roughly translates to "less agitated" fluid. 
%
% W_electric,in - Q_out = DeltaU + W_boundary
% W_electric,in - Q_out = DeltaH, where DeltaH = m*(h_2 - h_1)
% Once we solve for h_2, knowing the pressure, we can find the temperature
% via interpolation from tables
% 
W_electric_in = -V_p * i * dt %Joule
fprintf('\nThis problem is incomplete\n****************************\n');
h_1 = xsteam('hV_p',P_1)
%DeltaH = m*(h_2 - h_1);

h_2 = h_1*1000 + (Q_out - W_electric_in)/m_water ;  %The *1000 is to ensure
                                                    %all energy terms have
                                                    %the same units of
                                                    %J/kg.
fprintf('\nThis problem is incomplete\n****************************\n');

T_2 = xsteam('T_ph',P_1, h_2/1000) %The division by 1000 ensures that correct
                               %units are used as arguments to xsteam.
%% Plot
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
%% 
hold on
clear v_1
T_1 = sprintf('%.2f', xsteam('Tsat_p', P_1))

v_1 = xsteam('v_pt', 3, T_1)
plot(v_1, T_1, 'rs', 'MarkerSize',8, 'MarkerFaceColor','r')
%text(xsteam('v_pT',1, 100), 100,sprintf('  %3.4f m^3/kg',xsteam('v_pT',1, 100)),'rotation',60)
%eof