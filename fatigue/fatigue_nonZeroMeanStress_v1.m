%''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''%
% Fatigue: Goodman diagram
% Non-zero mean stress situation
% 
% s_mean = 1/2(s_max + s_min), 
% s_a = s_amplitude/2
%
%
% Author: Aneet Narendranath, PhD
%
%''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''%
%
%Problem solved: Goodman diagram, Ohio University, Dr.Clyde.
%
%% Select material
clear;
close all;
clc;
fos=3; %For fatigue.
P_mean=2540; %From problem statement, lbF
P_alternating=1260; %From problem statement, lbF

s_ut=125e3;%Ultimate stress, psi
s_y=102e3; %Yield stress, psi
surf_finish = 63; %micro-inch
temperature = 75; %Fahrenheit... room temperature

%% Pick a shape
% In this example, a cylindrical pin is chosen.
%
% A static design is performed to provide a stress "in the neighbourhood of
% a good solution".
% Use a larger FOS for the static case than the provided FOS to achieve.
% It is a good idea to use a static FOS that is twice the fatigue FOS to
% achieve.  The idea is, build some "over-design" in your static case so
% that your fatigue situation is better protected.
%
%
% s_y/fos_static = 4*P_max/pi()*d^2;
% d = sqrt(4*fos_static*P_max/(pi()*s_y))
%
% Given the axial loading situation, the simplest failure theory is chosen
% to calculate the diameter, d.  In essence, the yield stress is compared
% to the uniaxial stress (which would also be the larger principal stress)
% to determine the diameter.
%
P_max = 3800;
fos_static = 2*fos;
d = sqrt(4*fos_static*P_max/(pi()*s_y));
area = 0.25*pi()*d.^2;
s_m = P_mean/area; %psi
s_a = P_alternating/area; %psi
%At this point, it is useful to recognize that if one is to create an S-N
%curve, there would be NO MEAN STRESS, s_m.  One would use the alternating
%stress value, s_a and proceed with the S-N diagram creation.
%
%% Fatigue loading
s_m = zeros(1,1);
s_actual = 25e6;; %Actual design stress from, say, mechanics of materials
N_min=10^3;
N_max=10^6;
N_des=720000; %Cycles to design for
% response = input('Bending or axial loading? ') %User input
response=2; %1=bending, 2=Axial loading
matrl = 1; %1=steel, 2=Aluminium

%Loading type
if(response==1)%bending
    s_m = 0.9*s_ut;
else %axial
    s_m = 0.75*s_ut;
end

%Material type
if(matrl==1) %steel
    s_e_prime = 0.5*s_ut; %endurance limit
else %Aluminium
    s_e_prime = 0.4*s_ut; %endurance limit
end

%Coefficients to introduct correction to s_e_prime (endurance limit)
%These coefficients need to be chosen from design data-handbooks.
%The values below may be arbitrary.
c_load=0.7;
c_size=1.0;
c_surf=0.9;
c_temp=1.0; %temperature
c_reliability=0.868;
sa_uncorrected = s_e_prime;
sa_corrected = s_e_prime * c_load * c_size * c_surf * c_temp * c_reliability;
p_1 = [N_min, s_m];
p_2 = [N_max, sa_uncorrected];
p_3 = [N_max, sa_corrected];

%The line joining p_1 and p_3 is our design envelope and takes into account
%the various correction factors.
scatter(p_1(1), p_1(2), 'k', 'filled')
hold on;
scatter(p_2(1), p_2(2), 'r', 'filled')
scatter(p_3(1), p_3(2), 'k', 'filled')
set(gca, 'xscale', 'log');
set(gca, 'yscale', 'log');
xlabel('Cycles', 'FontSize',15)
ylabel('Stress', 'FontSize',15)

%Uncorrected design envelope
xData=[p_1(1) p_2(1)];
yData=[p_1(2) p_2(2)];
line(xData, yData,'Color','red','LineStyle','-.','LineWidth',0.5);
%extension beyond N_max cycles:
xData=[N_max 2*N_max];
yData=[p_2(2) p_2(2)];
line(xData, yData,'Color','red','LineStyle','-.','LineWidth',0.5);


%Corrected design env.
xData=[p_1(1) p_3(1)];
yData=[p_1(2) p_3(2)];
line(xData, yData,'Color','black','LineStyle','-','LineWidth',2);
%extension beyond N_max cycles:
xData=[N_max 2*N_max];
yData=[p_3(2) p_3(2)];
line(xData, yData,'Color','black','LineStyle','-','LineWidth',2);

y_2 = s_m;
y_1 = sa_corrected;
x_2 = N_min;
x_1 = N_max;
m = (y_2 - y_1)./(x_2-x_1);
b=s_m; %bias or intercept on Y(S) axis.
% 
% Given a "design cycles", what is the max alternating stress?
s_design_max = m*N_des + b;
line([N_des, N_des],[0, 1.1*s_m],'Color','blue','LineStyle','-.','LineWidth',2)
scatter(N_des, s_design_max, 'k', 'filled');
str = {'Design', 'maximum stress'};
text(N_min, 1.05*s_design_max, str,'Color','blue','FontSize',10);

% Diameter based on s_design_max
d_max = sqrt(4*fos*P_max/(pi()*s_design_max));


% 
% Given an actual alternating stress, where are we in the design envelope?
% str = {'Actual stress'};
% text(N_min, 1.25*s_actual, str,'Color','blue','FontSize',8);
% line([N_min, 2*N_max],[s_actual, s_actual],'Color',[0 1 0],'LineStyle','-.','LineWidth',1.1)
% 
% Overload factor available:
% fos = s_design_max/s_actual;
% str = {'FOS is',num2str(fos)};
% text(N_max, 0.8*s_m, str,'Color','black','FontSize',14);



%% 
%
%Note: If the material is not a steel, one calculates the fatigue limit,
%denoted by s_f_prime.  In the above if statement, the Aluminium material
%has an s_e_prime calculated.  Please read this as a "fatigue limit".
%Future versions of this code may make a discrimination between s_e_prime
%and s_f_prime.  
%

%Alternating component
%sa=s_e_prime; %uncorrected (without coefficients)

%Coefficients to introduct correction to s_e_prime (endurance limit)
c_load=0.8;
c_size=0.8;
c_surf=0.8;
c_temp=0.9;
c_reliability=0.5;
sa_uncorrected = s_e_prime;
sa_corrected = s_e_prime * c_load * c_size * c_surf * c_temp * c_reliability;
p_1 = [N_min, s_m];
p_2 = [N_max, sa_uncorrected];
p_3 = [N_max, sa_corrected];

%The line joining p_1 and p_3 is our design envelope and takes into account
%the various correction factors.
scatter(p_1(1), p_1(2), 'k', 'filled')
hold on;
scatter(p_2(1), p_2(2), 'r', 'filled')
scatter(p_3(1), p_3(2), 'k', 'filled')
xlabel('Cycles', 'FontSize',15)
ylabel('Stress', 'FontSize',15)

%Uncorrected design envelope
xData=[p_1(1) p_2(1)];
yData=[p_1(2) p_2(2)];
line(xData, yData,'Color','red','LineStyle','-.','LineWidth',0.5);
%extension beyond N_max cycles:
xData=[N_max 2*N_max];
yData=[p_2(2) p_2(2)];
line(xData, yData,'Color','red','LineStyle','-.','LineWidth',0.5);


%Corrected design env.
xData=[p_1(1) p_3(1)];
yData=[p_1(2) p_3(2)];
line(xData, yData,'Color','black','LineStyle','-','LineWidth',2);
%extension beyond N_max cycles:
xData=[N_max 2*N_max];
yData=[p_3(2) p_3(2)];
line(xData, yData,'Color','black','LineStyle','-','LineWidth',2);

%Slope of line between 1000 and N_max cycles is found next.
%m=(y_2 - y_1)/(x_2-x_1)
%
y_2 = s_m;
y_1 = sa_corrected;
x_2 = N_min;
x_1 = N_max;
m = (y_2 - y_1)./(x_2-x_1);
b=s_m; %bias or intercept on Y(S) axis.

%Given a "design cycles", what is the max alternating stress?
s_design_max = m*N_des + b;
line([N_des, N_des],[0, 1.1*s_m],'Color','blue','LineStyle','-.','LineWidth',2)
scatter(N_des, s_design_max, 'k', 'filled');
str = {'Design', 'maximum stress'};
text(N_min, 1.05*s_design_max, str,'Color','blue','FontSize',10);

%Given an actual alternating stress, where are we in the design envelope?
str = {'Actual stress'};
text(N_min, 1.25*s_actual, str,'Color','blue','FontSize',8);
line([N_min, 2*N_max],[s_actual, s_actual],'Color',[0 1 0],'LineStyle','-.','LineWidth',1.1)

%Overload factor available:
fos = s_design_max/s_actual;
str = {'FOS is',num2str(fos)};
text(N_max, 0.8*s_m, str,'Color','black','FontSize',14);
%eof
