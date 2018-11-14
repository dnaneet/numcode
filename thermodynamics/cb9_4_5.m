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
m_water = 25e-3; %kg
P = 300/100; %bar (300 kPa = 3bar)
i = 0.2; %Ampere
V_p = 120; %voltage

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
% E_in - E_out = W_electric,in - Q_out - W_boundary = DeltaU (internal
% energy change)
%
% W_electric,in - Q_out = DeltaU + W_boundary
% W_electric,in - Q_out = DeltaH
% For a constant pressure situation, the fluid must expand

fprintf('\nThis problem is incomplete\n****************************\n');

%eof