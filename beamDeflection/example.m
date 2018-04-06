x =linspace(0,3,25);
% 
% % V = -1000*lin_sf(x, -3)+8000*step_sf(x, 0) +1000*lin_sf(x, 3) ...
% % -5000*step_sf(x, 6) + 9000*step_sf(x, 9) - 4000*lin_sf(x, 9) +(2000/3)*quad_sf(x,9);
% 
% % d=(1/fr)*(-150e3*quad_sf(x,0)-(20e3/6)*cubic_sf(x,15));
% Ra=5e3;
% Fy=-35e3;
% d = (1/fr)*((Ra/6)*lin_sf(x,0) + (Fy/6)*cubic_sf(x,6) -(20e3/6)*cubic_sf(x,15) + 180e3);
% d =(1/fr)*( -(4/3)*cubic_sf(x,0) + cubic_sf(x,10) + x - 12000);
%% Turcotte and Wilson, pg 209
fr=10e6; %flexural rigidity
d = (-50/24)*quartic_sf(x,0) + (50/24)*quartic_sf(x,36) + (2400/6)*cubic_sf(x,60)+...
     (24000/2)*quad_sf(x,96) - (75/(120*72))*quintic_sf(x,120)+x.^3+x.^2 + x
plot(x,d)
pbaspect([4 1 1])

%% E J Hearn, page 127-128.
x=linspace(0,3,25);
fr = 0.65e6; %flexural rigidity, E*I
y = -20*x.^3/6+...
    (62/6)*cubic_sf(x,0.6)...
    -(30/24)*quartic_sf(x,0.6)...
    +(30/24)*quartic_sf(x,1.8)...
    -20*cubic_sf(x,1.8)...
    -3.72*x...
    +2.952;

plot(x,y*1e3/fr,'r','Linewidth',1.25)
xlabel('x[m]','FontSize',15)
ylabel('deflection, y[m]','FontSize',15)
title('Deflection from Macaulays method','FontSize',18)

pbaspect([4 1 1])

%% E J Hearn, page 124-125
L=5;%span in meter
ndivs=100;%number of discrete divisions of span
x=linspace(0,L,ndivs);
fr = 200e9*83e-6; %flexural rigidity, E*I
y = 60*x.^2/2 ...
    -20/2*quad_sf(x,1) ...
    -50/2*quad_sf(x,3) ...
    -60/6*cubic_sf(x,3) ...
    -186*x;
   
% -20/2*quad_sf(x,1)...
%     

plot(x,y*1e3/fr,'r','Linewidth',1.25)
xlabel('x[m]','FontSize',15)
ylabel('deflection, y[m]','FontSize',15)
title('Deflection from Macaulays method','FontSize',18)

pbaspect([4 1 1])
