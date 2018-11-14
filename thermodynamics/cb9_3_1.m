%CB9
%3-1 A rigid tank ocntains 50 kg of saturated liquid water at 90 degC.
%Determine the pressure in the tank and the volume of the tank.
%
%Aneet Narendranath, PhD (c) 2018
%

%Preamble to clear screen and any variables in the workspace:
%------------------------------------------------------------
clc; %clear console
clear all;

%Given info:
%-----------
m=50; %kg
T=90; %degC

%To find:
%--------
%Pressure in the tank and the volume of the tank (volume occupied by water)

%Solution:
%---------
%Traditionally, a T-v diagram or a T-v table could be used to isolate
%pressure and the specific volume of saturated water at 90 degC.  After
%this, the mass of water may be used to calculate the volume of
%water(tank).

%xsteam is used to solve this problem:
%-------------------------------------
P=xsteam('pSat_t',T);
P_kpa=P*100 %in kPa

%To evaluate specific volume, it is recognized from the problem statement
%that the water is a "Saturated liquid".
format shortEng %display format
v_specific=xsteam('vL_t', T) %m3/kg
v = m*v_specific %m3

%eof
