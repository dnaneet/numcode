%CB9
%3-4 A rigid tank contains 10 kg of water at 90 degC.  If 8kg of the water
%is in liquid form and the rest is in vapor form, determine (a) the
%pressure in the tank and (b) the volume of the tank.
%
%Aneet Narendranath, PhD (c) 2018
%

%Preamble to clear screen and any variables in the workspace:
%------------------------------------------------------------
clc; %clear console
clear all;

%Given info:
%-----------
m_tot = 10; %kg
m_f = 8; %liquid water mass, kg
m_g = m_tot - m_f; %water vapor mass, kg
T = 90; %degC

%To find:
%--------
%(a)pressure in the tank and 
%(b) the volume of the tank.
% Note that the tank contains a saturated mixture.

% (a) Pressure in the tank:
%  ------------------------
%P = Psat @T=90 degC
P = xsteam('pSat_t',T); %in Bar
P_kpa = P*100 %in kPa

% (b) Volume of the tank:
%  ----------------------
% V_total = m_f*v_f + m_g*v_g
%

v_f = xsteam('vL_t',T); %m3/kg
v_g = xsteam('vV_t',T); %m3/kg
V_total = m_f*v_f + m_g*v_g %m3

%Alternate method to find volume of tank:
%---------------------------------------
%Calculate quality, x, of mixture and use that to find volume
%V_total = m_tot*(v_f + x*v_fg)
%

x = m_g/m_tot;
V_total = m_tot*(v_f + x*(v_g - v_f)) %m3


%eof