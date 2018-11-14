%CB9
%3-3 A mass of 200 gram of saturated liquid water is completely vaporized at
%a constant pressure of 100 kPa.  Determine (a) the volume change and
%(b) the  total amount of energy transferred to the water
%
%Aneet Narendranath, PhD (c) 2018
%

%Preamble to clear screen and any variables in the workspace:
%------------------------------------------------------------
clc; %clear console
clear all;

%Given info:
%-----------
m=0.2; %kg
P=100/100; %Bar. 1 Bar = 100 kPa.  Numerator is in kPa. Denominator is the 
           %conversion factor.

%To find:
%--------
%(a) volume change and
%(b) total amount of energy transferred to the water

%Solution:
%---------
%(a) Volume change during the process of vaporization is given by the
%difference in volume of the saturated vapor final state and the saturated
%liquid initial state, at P=100 kPa (1 Bar).

v_g = xsteam('vV_P',P); %m3/kg
v_f = xsteam('vL_p',P); %m3/kg
v = m*(v_g - v_f) %v_g, v_f are the sat vapor and the sat liquid specific
                   %volume values for water, at 1Bar.
                   %
                   %v is in m3
                   
%(b) Amount of energy transferred to the water is given by the enthalpy
%of vaporization MULTIPLIED by the mass.

h_g = xsteam('hV_p',P); %kJ/kg
h_f = xsteam('hL_p',P); %kJ/kg
h_fg = h_g - h_f; 
E = m*h_fg %Energy transfer to water in kJ
                   
%eof