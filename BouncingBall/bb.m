function dydt = bb(t, y)
%Evaluate the bouncing ball problem for g=-9.81 m/s^2
%
dydt = [y(2); -9.81];