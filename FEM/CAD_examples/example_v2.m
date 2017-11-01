close all;
%% Creating a model space for static-structural analysis
N = 3;
model = createpde(N);
importGeometry(model,'L.stl');

figure
pdegplot(model,'FaceLabels','on')
view(30,30);
title('L-shape')

%% Define the Coefficients in Toolbox Syntax
% Define the elastic modulus of steel and Poisson's ratio for this material.
E = 200e9; % elastic modulus of steel in Pascals
nu = 0.3; % Poisson's ratio

% Incorporate these coefficients in toolbox syntax.
c = elasticityC3D(E,nu);
a = 0;
f = [0;0;0]; % Assume all body forces are zero

specifyCoefficients(model,'m',0,'d',0,'c',c,'a',a,'f',f);

%% Boundary conditions 
% (fixed) applied to face 4
applyBoundaryCondition(model,'dirichlet','Face',4,'u',[0,0,0]);

% Apply a distributed load in the negative $z$-direction to the front face,
% face 8.
distributedLoad = 1e4; % Applied load in Pascals
applyBoundaryCondition(model,'neumann','Face',2,'g',[distributedLoad,0,0]);

%% Create a mesh

bracketThickness = 1e-3; % Thickness of horizontal plate with hole, meters
hmax = 5; % Maximum element length for a moderately fine mesh
generateMesh(model,'Hmax',hmax,'GeometricOrder','quadratic');
figure
pdeplot3D(model)
title('Mesh with Quadratic Tetrahedral Elements');

%% Calculate the Solution
% Use |solvepde| to calculate the solution.
result = solvepde(model);

%% Examine the Solution
% For plotting and analysis, extract the |NodalSolution| property.
rs = result.NodalSolution;

% Find the greatest calculated deflection of the bracket. The deflection in
% the $z$ direction, meaning the third component of the solution.
minUz = min(rs(:,3));
fprintf('Largest deflection in the z-direction is %g meters.\n', minUz);

labels = ['x','y','z'];
for i=1:3
  figure
  pdeplot3D(model,'ColorMapData',rs(:,i))
  title([labels(i),'-displacement'])
end

%Von mises stresses
% Complete this.  Calculated from Nodal solution values.

