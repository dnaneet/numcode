% Euler's method to solve the first order differential equation y'=y as an
% initial value problem.  y' = dy/dt.  The initial condition is y(0) = 1.
%
% Aneet D. Narendranath, PhD (c) 2019
%
%% Initialization
clear;
clc;

dt = 1; %step size
tEnd=5; %last time step
n = tEnd/dt; %Number of steps
y = zeros(n,1); % Solution array initialized with "n" zeros for memory allocation purposes
%% Solution
y(1,1) = 1; %initial condition

%Soultion loop
for i=2:1:n
   y(i,1) = y(i-1,1) + dt*y(i-1,1) ;
end
%% Visualization to compare numerical solution with exact solution
expfun = @(x) exp(x); %Exact solution as a function of x
tArray=linspace(0,tEnd,n); %Evenly spaced time vector for exact solution
yexact=expfun(tArray); %Exact solution for plotting an comparison with numerical solution
figure;
plot(y, 'r*', 'MarkerSize',15)
hold on;
plot(yexact, 'b+', 'MarkerSize',15)

%eof
