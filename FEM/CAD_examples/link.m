close all;
clear all;
N = 3;
model = createpde(N);
importGeometry(model,'Link2.STL');

%% Visualization
% Plot the geometry and turn on face labels. You will need the face
% labels to define the boundary conditions.
figure
pdegplot(model,'FaceLabels','on')
%pdegplot(model,'EdgeLabels','on')
view(30,30);
title('Link')

%% Define the Coefficients in Toolbox Syntax
% Define the elastic modulus of steel and Poisson's ratio for this material.
E = 200e9; % elastic modulus of steel in Pascals
nu = 0.3; % Poisson's ratio
%%
% Incorporate these coefficients in toolbox syntax.
c = elasticityC3D(E,nu); %Overall matrix for both plane stress and plane strain
                         %This is a 6x6 matrix of which 3x3 is for plane stress
                         %and 3x3 is for plane strain. *this is an 
                         %undocumented function*
a = 0; %Coefficient
f = [0;0;0]; % Assume all body forces are zero

%% Specify PDE Coefficients
specifyCoefficients(model,'m',0,'d',0,'c',c,'a',a,'f',f);

%The equations for linear elasticity are merely derived from Newton's
%second law.  They are:
%m \ddot{u} + \delta \dot{u} - \nabla\cdot(c \nabla u) + a u = f
%Here, m is the mass matrix, \delta is the damping matrix, a is a
%coefficient necessary to induce some sort of pre-strain, f is a force
%vector while \ddot{u} and \dot{u} are acceleration and velocity, both of
%which are absent for linear elastic problems (static equilibrium).

%% Define the Boundary Conditions
% The problem has two boundary conditions: the back face is immobile and
% the front face has an applied load. All other boundary conditions, by
% default, are free Neumann boundaries.
%
% Constrain all three displacements to |0| on the back face, face 4.
applyBoundaryCondition(model,'dirichlet','Face',8,'u',[0,0,0]);

% Apply a distributed load in the negative $z$-direction to the front face,
% face 8.
distributedLoad = 1e4; % Applied load in Pascals
applyBoundaryCondition(model,'neumann','Face',7,'g',[0,0,-distributedLoad]);

%% Create a Mesh
% Create a mesh that uses 10-node tetrahedral elements with quadratic
% interpolation functions. This element type is significantly more accurate
% than the linear interpolation (four-node) elements, particularly in
% elasticity analyses that involve bending.
bracketThickness = 1; % Thickness of horizontal plate with hole, meters
hmax = bracketThickness; % Maximum element length for a moderately fine mesh
generateMesh(model,'Hmax',hmax,'GeometricOrder','linear');
figure
pdeplot3D(model)
title('Mesh with linear Tetrahedral Elements');

[p,e,t] = meshToPet(model.Mesh);

%% Calculate the Solution
% Use |solvepde| to calculate the solution.
result = solvepde(model);

%% Examine the Solution
% For plotting and analysis, extract the |NodalSolution| property.
rs = result.NodalSolution;
%%
% Find the greatest calculated deflection of the bracket. The deflection in
% the $z$ direction, meaning the third component of the solution.
minUz = min(rs(:,3));
fprintf('Largest deflection in the z-direction is %g meters.\n', minUz)


labels = ['x','y','z'];
for i=1:3
  figure
  pdeplot3D(model,'ColorMapData',rs(:,i))
  title([labels(i),'-displacement'])
end

%% Stress interpolation

[X,Y] = meshgrid(linspace(-0.015,0.015,50));
Z = ones(size(X))*0.025;

intrpStress = interpolateStress(result,X,Y,Z);
surf(X,Y,reshape(intrpStress.szz,size(X)))


