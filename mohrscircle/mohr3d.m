%% State of stress
clear;
close all;
clc;
%% Original state of stress, (sxx, txy, syy)
%prompt=input('Mohr stress circle(1) or strain circle(2)? This value decides the axis labels... ')
prompt = 1;
sxx = 100;
syy = 35;
txy = 0;
x = [sxx; -txy];
y = [syy; txy];
t = 0; %Angle through which original state of stress is rotated
         %in degree. Negative=clockws, positive=counterc/w
         % MATLAB needs angles in radian.  This can be circumvented by
         % using sind() or cosd()....
% twoTheta=deg2rad(2*t);
twoTheta = 2*t; %degree
th = 0:pi/50:2*pi;
r=sqrt((0.5*(sxx-syy))^2 + txy^2);
%Average value of stress OR center of circle
x_cen=0.5*(sxx + syy);
y_cen=0.;
s_ave = x_cen;
%% Mohrs circle with original state of stress
r=sqrt((0.5*(sxx-syy))^2 + txy^2); %Radius of Mohr's circle
s_1 = s_ave+r; %principal stress
s_2 = s_ave-r; %principal stress
%Creating the circle
xunit = r * cos(th) + x_cen;
yunit = r * sin(th) + y_cen;
hold on;
plot(xunit, yunit, 'r', 'Linewidth', 3);
scatter(x_cen, y_cen, 'rx' , 'Linewidth', 4);
%Labeling and font
if(prompt==1)
   xlabel('\sigma','FontSize',22)
   ylabel('\tau','FontSize',22)
else
   xlabel('\epsilon','FontSize',22)
   ylabel('0.5\gamma','FontSize',22)
end
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'FontSize', 16)

%Plotting the original plane of stress on the circle
scatter(x(1), x(2), 'rx', 'Linewidth', 2)
scatter(y(1), y(2), 'rx', 'Linewidth', 2)
line([x(1), y(1)],[x(2), y(2)],'LineWidth',2.5,...
   'Color',[1,0,0],'LineStyle','-')

% line([-1.15*min(s_1,s_2), 1.05*max(s_1,s_2)],[0,0],'LineStyle','-','LineWidth',0.2)

axis([-1.1*s_1 1.1*s_1 -1.1*r 1.1*r])
% pbaspect([1 1 1])
hold on;

%% Rotation of original state of stress through theta (twoTheta in "Mohr's circle world").
x_prime_x = (x(1)-x_cen)*cosd(twoTheta) - (x(2) - y_cen)*sind(twoTheta) + x_cen;
x_prime_y = (x(1)-x_cen)*sind(twoTheta) + (x(2) - y_cen)*cosd(twoTheta) + y_cen;

y_prime_x = (y(1)-x_cen)*cosd(twoTheta) - (y(2) - y_cen)*sind(twoTheta) + x_cen;
y_prime_y = (y(1)-x_cen)*sind(twoTheta) + (y(2) - y_cen)*cosd(twoTheta) + y_cen;

hold on;
scatter(x_prime_x, x_prime_y, 'r*')
scatter(y_prime_x, y_prime_y, 'r*')

line([x_prime_x, y_prime_x],[x_prime_y, y_prime_y],'LineWidth',2,...
   'Color',[1,0,0],'LineStyle','--')

%% Second circle
s_3 = 0;
x_cen = 0.5*(s_2 - s_3);
y_cen=0.;
r=abs(0.5*(s_2-s_3)); %Radius of second circle
%Creating the circle
xunit = r * cos(th) + x_cen;
yunit = r * sin(th) + y_cen;
hold on;
plot(xunit, yunit, 'b', 'Linewidth', 2.5);
scatter(x_cen, y_cen, 'bx' , 'Linewidth', 4);
%Labeling and font
% if(prompt==1)
%    xlabel('\sigma','FontSize',22)
%    ylabel('\tau','FontSize',22)
% else
%    xlabel('\epsilon','FontSize',22)
%    ylabel('0.5\gamma','FontSize',22)
% end
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(gca, 'FontSize', 16)

%Plotting the original plane of stress on the circle
% scatter(x(1), x(2), 'rx', 'Linewidth', 2)
% scatter(y(1), y(2), 'rx', 'Linewidth', 2)
% line([x(1), y(1)],[x(2), y(2)],'LineWidth',2.5,...
%    'Color',[0,0,1],'LineStyle','-')

% line([-1.15*min(s_1,s_2), 1.05*max(s_1,s_2)],[0,0],'LineStyle','-','LineWidth',0.2)
% axis([-1.1*s_1 1.1*s_1 -1.1*r 1.1*r])


%% Third circle for MAX SHEAR STRESS
hold on;
if(s_2>=0)
    x_cen = 0.5*(s_1 - s_3);
    y_cen=0.;
    r=abs(0.5*(s_1-s_3)); %Radius of second circle
    %Creating the circle
    xunit = r * cos(th) + x_cen;
    yunit = r * sin(th) + y_cen;
    hold on;
    plot(xunit, yunit, 'k', 'Linewidth', 2.5);
    scatter(x_cen, y_cen, 'kx' , 'Linewidth', 4);
    %Labeling and font
    % if(prompt==1)
    %    xlabel('\sigma','FontSize',22)
    %    ylabel('\tau','FontSize',22)
    % else
    %    xlabel('\epsilon','FontSize',22)
    %    ylabel('0.5\gamma','FontSize',22)
    % end
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    set(gca, 'FontSize', 16)
    
    %Plotting the original plane of stress on the circle
    scatter(x(1), x(2), 'rx', 'Linewidth', 2)
    scatter(y(1), y(2), 'rx', 'Linewidth', 2)
    % line([x(1), y(1)],[x(2), y(2)],'LineWidth',2.5,...
    %    'Color',[0,0,1],'LineStyle','-')
    
    % line([-1.15*min(s_1,s_2), 1.05*max(s_1,s_2)],[0,0],'LineStyle','-','LineWidth',0.2)
    axis([-1.1*s_1 1.1*s_1 -1.1*r 1.1*r])
    
    line([x_cen, x_cen], [-r, r],'LineWidth',2.5,...
        'Color',[0,0,0],'LineStyle','-.')
end
    

%% Saving plot as pdf
h=gcf;
set(h,'PaperPositionMode','auto');         
set(h,'PaperOrientation','landscape');
print('mohr_3','-dpdf','-fillpage')



%eof