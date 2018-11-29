%Sonntag
%6.4 Steam at 0.6 MPa and 200 degree C enters an insulated nozzle with a
%velocity of 50 m/s.  It leaves at a pressure of 0.15 MPa amd a velocity of
%600 m/s.  Determine the final temeprature if the steam is superheated in
%the final state and the quality if it is saturated.
%
%Aneet Narendranath, PhD (c) 2018
%

%Preamble to clear screen and any variables in the workspace:
%------------------------------------------------------------
clc; %clear console
clear all;

%Given info:
%-----------
% Insulated Nozzle: Work term does not exist while insulation leads to the
% neglect of the heat transfer term.
%
P_1 = 0.6;%MPa 
P_1_bar = P_1*10; %1 MPa = 10 Bar
T_1 = 200; %C
vel_1 = 50; % m/s
P_2 = 0.15; %Mpa
P_2_bar = P_1*10; %1 MPa = 10 Bar
vel_2 = 600; %m/s

%To find:
%--------
%(a) Final temperature if the steam is superheated
%(b) Quality if the steam is saturated (vapour)
%

%SOLUTION:
%---------
%Open system energy balance (SFEE):
% dEdt = Q_dot - W_dot + m_dot_in*(h_1 + 0.5*vel_1^2 + g*z_1) - m_dot_in*(h_1 + 0.5*vel_1^2 + g*z_1)
%
%Elevation change is neglected. Q_dot = W_dot = 0 (per problem statement)
%
% h_1 + 0.5*vel_1^2 = h_2 + 0.5*vel_2^2
%
h_1 = xsteam('h_pT', P_1_bar, T_1); %kJ/kg

%From the open system energy balance equation:
h_2 = h_1 + 0.5*vel_1^2/1000 - 0.5*vel_2^2/1000 ; %Division by 1000 to convert to kJ/kg

%The value of h_2 and P_2 would be aligned to triangulate a temperature
T_2 = xsteam('T_ph', P_2_bar, h_2) %Exit temperature in Celcius

%eof