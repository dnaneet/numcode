%% State of stress
sxx = 100.;
syy = -200.;
txy = 0.;
%% Circle
hold on
th = 0:pi/50:2*pi;
r=0.5*(sxx + syy) + sqrt(0.25(sxx-syy)^2 + txy^2)
x_cen=0.5*(sxx + syy);
y_cen=0.;
xunit = r * cos(th) + x_cen;
yunit = r * sin(th) + y_cen;
h = plot(xunit, yunit, 'k', 'Linewidth', 2);
%plot([-1 0], [1 3], 'r', 'Linewidth', 2) %Line segment
pbaspect([1 2 1]) %[1 2 1] causes 1:1 aspect ratio

hold off