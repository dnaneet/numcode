% Newton-Raphson Iterative method for 2 nonlinear springs
clc;
clear; %careful with this! 
%% Initialization
tol=1e-9; % Error tolerance.  The lower the tolerance value, the higher the
          % accuracy but likely longer computational time to convergence.
u=[1000; 0.001]; %Initial guess value (for displacement vector)
          %Try (1000; 0.001)  
uold=u;

f=[0;100]; %Force vector, in Newton
%% Calculations
P = [ 300*u(1) + 400*u(1)*u(2) - 200*u(2)^2 + 150*u(1) - 100*u(2)
      200*u(1) - 400*u(1)*u(2) + 200*u(2)^2 - 100*u(1) + 100*u(2)]; 
    %P(u)=K(u)*{u}
R = f - P; %Residual, difference between force vector and P(u_guess)
conv = (R(1)^2 + R(2)^2)/(1 + f(1)^2 + f(2)^2);%Convergence "value"
iter=1; %Iteration number
convMatrix=zeros(1,1); %Accumulate convergence value to plot later
deluMatrix=zeros(1,1); %Step increment value

%% Iteration
while conv>tol
   Jm = [ 600*u(1) + 400*u(2) + 150 400*(u(1)-u(2)) - 100
          400*(u(1) - u(2)) - 100 400*u(2) - 400*u(1) + 100];
      %Jacobian Matrix
   delu = Jm\R; %Inversion operation to find delta u or step size
   u = uold + delu; %Step increment to find new displacement, u
   deluMatrix = [deluMatrix; delu(1)]; %Accumulate delu(1)
   
   P = [ 300*u(1)^2 + 400*u(1)*u(2) - 200*u(2)^2 + 150*u(1) - 100*u(2)
      200*u(1)^2 - 400*u(1)*u(2) + 200*u(2)^2 - 100*u(1) + 100*u(2)];
   R = f - P; %Recalculate residual with new displacement
   conv = (R(1)^2 + R(2)^2)/(1 + f(1)^2 + f(2)^2); 
   
   convMatrix=[convMatrix; conv];
   uold = u;
   iter = iter + 1;
end

%eof