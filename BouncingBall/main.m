%MATLAB demo writted by Dr.Narendranath to solve the EOM for a bouncing
%ball
%
%(c) 2019, Aneet Narendranath, Ph.D.
%
%% Parameters
h0=5;
v0=0;
tEnd=1;

%% Solution
[t, y] = ode23(@bb, [0, tEnd], [h0, v0]);

%% Plot results
plot(t, y(:,1), '-o', t, y(:,2), '-o')
title('Numerical solution to the Bouncing Ball EOMs');
xlabel('Time, t');
ylabel('Solution, y');
legend('height','velocity');

%Notice that the ball does not bounce.  This is because the coefficient of
%restitution has not been included in this code.  Each time the ball
%contacts the floor, it's velocity must change direction and magnitude
%(v_after_contact = -c*v_before_contact).  With these new values of
%velocity, the equations of motion need to be solved again.
%
%eof