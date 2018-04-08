%% State of stress
clear;
close all;
clc;
%% Original state of stress, (sxx, txy, syy)
prompt=input('Mohr stress circle(1) or strain circle(2)?: ')
% sxx = -720e-6;
% syy = 0;
% txy = 150e-6;
sxx = input('xx value: ')
syy = input('yy value: ')
txy = input('xy value: ')
t = input('theta for rotation (enter 0 for none): ')
x = [sxx; -txy];
y = [syy; txy];
% t = -30; %Angle through which original state of stress is rotated
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
plot(xunit, yunit, 'k', 'Linewidth', 1.25);
scatter(x_cen, y_cen, 'bx' , 'Linewidth', 1.25);
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
scatter(x(1), x(2), 'kx', 'Linewidth', 1.25)
scatter(y(1), y(2), 'kx', 'Linewidth', 1.25)
line([x(1), y(1)],[x(2), y(2)],'LineWidth',1.25,...
   'Color',[0,0,1],'LineStyle','-')

% line([-1.15*min(s_1,s_2), 1.05*max(s_1,s_2)],[0,0],'LineStyle','-','LineWidth',0.2)
pbaspect([1 1 1])
%% Rotation of original state of stress through theta (twoTheta in "Mohr's circle world").
if(t~=0)
    x_prime_x = (x(1)-x_cen)*cosd(twoTheta) - (x(2) - y_cen)*sind(twoTheta) + x_cen;
    x_prime_y = (x(1)-x_cen)*sind(twoTheta) + (x(2) - y_cen)*cosd(twoTheta) + y_cen;
    
    y_prime_x = (y(1)-x_cen)*cosd(twoTheta) - (y(2) - y_cen)*sind(twoTheta) + x_cen;
    y_prime_y = (y(1)-x_cen)*sind(twoTheta) + (y(2) - y_cen)*cosd(twoTheta) + y_cen;
    
    hold on;
    scatter(x_prime_x, x_prime_y, 'k*')
    scatter(y_prime_x, y_prime_y, 'k*')
    
    line([x_prime_x, y_prime_x],[x_prime_y, y_prime_y],'LineWidth',1.25,...
        'Color',[1,0,1],'LineStyle','--')
end

% str='T=$\begin{array}{cc}0 & 0 \\ 0 & 972 \end{array}$'; %state of stress
%                                                            printed on
%                                                            plot, for
%                                                            reference
% text(0.8*max(s_1,s_2),0.9*r,str, 'Interpreter', 'latex', 'FontSize', 16,'Color', 'blue')

%% Saving plot as pdf
h=gcf;
str='Blue: Original state of stress';
text(0.8*s_1, 0.8*r, str);
sxxstr=num2str(sxx);
syystr=num2str(syy);
sxystr=num2str(txy);
str={'sxx, syy, txy',sxxstr, syystr, sxystr};
text(0.95*s_1, 0.65*r, str);

set(h,'PaperPositionMode','auto');         
set(h,'PaperOrientation','landscape');
print('mohr_stress_6b','-dpdf','-fillpage')



%eof