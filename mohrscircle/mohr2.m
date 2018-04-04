%% State of stress
clear;
close all;
clc;
sxx = 4000.;
syy = 0;
txy = 8000.;
x = [sxx; -txy];
y = [syy; txy];
t = 10; %degree. Negative=clockws, positive=counterc/w
         %MATLAB needs angles in radian.  
twoTheta=deg2rad(2*t);
th = 0:pi/50:2*pi;
r=sqrt((0.5*(sxx-syy))^2 + txy^2)

x_cen=0.5*(sxx + syy);
y_cen=0.;
%% Mohrs circle with original state of stress
r=sqrt((0.5*(sxx-syy))^2 + txy^2)

x_cen=0.5*(sxx + syy);
y_cen=0.;
xunit = r * cos(th) + x_cen;
yunit = r * sin(th) + y_cen;
hold on;
plot(xunit, yunit, 'k', 'Linewidth', 2);
scatter(x_cen, y_cen, 'go' , 'Linewidth', 5);
scatter(x(1), x(2), 'r*', 'Linewidth', 5)
scatter(y(1), y(2), 'r*', 'Linewidth', 5)
line([x(1), y(1)],[x(2), y(2)],'LineWidth',2,...
   'Color',[1,0,0],'LineStyle','-.')

line([-5*sxx,5*sxx],[0,0],'LineStyle','-.')
% pbaspect([1 1 1]) %[1 2 1] causes 1:1 aspect ratio
%% 
% pv_x = [x(1)-x_cen, x(2)-y_cen];
% pv_y = [y(1)-x_cen, y(2)-y_cen];
t=twoTheta;
% r_matrix = [cos(t), -sin(t); sin(t), cos(t)];
% 
% pv_x_prime = pv_x*r_matrix;
% pv_y_prime = pv_y*r_matrix;
% hold on;
% scatter(pv_x_prime(1), pv_x_prime(2), 'b*', 'Linewidth', 5)
% scatter(pv_y_prime(1),pv_y_prime(2), 'b*', 'Linewidth', 5)
x_1 = x(1)*cos(t) - x(2)*sin(t);
y_1 = x(1)*sin(t) + x(2)*cos(t);

x_2 = y(1)*cos(t) - y(2)*sin(t);
y_2 = y(1)*sin(t) + y(2)*cos(t);
hold on;
scatter(x_1,y_1,'b*','Linewidth', 5)
scatter(x_2,y_2,'b*','Linewidth', 5)



