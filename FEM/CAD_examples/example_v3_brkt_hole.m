N = 3;
model = createpde(N);
importGeometry(model,'BracketWithHole.stl');

%%
% Plot the geometry and turn on face labels. You will need the face
% labels to define the boundary conditions.
figure
pdegplot(model,'FaceLabels','on')
view(30,30);
title('Bracket with Face Labels')
% figure
% pdegplot(model,'FaceLabels','on')
% view(-134,-32)
% title('Bracket with Face Labels, Rear View')
%% Define the Coefficients in Toolbox Syntax
% Define the elastic modulus of steel and Poisson's ratio for this material.
E = 200e9; % elastic modulus of steel in Pascals
nu = 0.3; % Poisson's ratio
%%
% Incorporate these coefficients in toolbox syntax.
c = elasticityC3D(E,nu);
a = 0;
f = [0;0;0]; % Assume all body forces are zero

%% Specify PDE Coefficients
specifyCoefficients(model,'m',0,'d',0,'c',c,'a',a,'f',f);

%% Define the Boundary Conditions
% The problem has two boundary conditions: the back face is immobile and
% the front face has an applied load. All other boundary conditions, by
% default, are free Neumann boundaries.
%
% Constrain all three displacements to |0| on the back face, face 4.
applyBoundaryCondition(model,'dirichlet','Face',4,'u',[0,0,0]);
%%
% Apply a distributed load in the negative $z$-direction to the front face,
% face 8.
distributedLoad = 1e4; % Applied load in Pascals
applyBoundaryCondition(model,'neumann','Face',8,'g',[0,0,-distributedLoad]);


%% Create a Mesh
% Create a mesh that uses 10-node tetrahedral elements with quadratic
% interpolation functions. This element type is significantly more accurate
% than the linear interpolation (four-node) elements, particularly in
% elasticity analyses that involve bending.
bracketThickness = 1e-1; % Thickness of horizontal plate with hole, meters
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

%% Plot the Solution
% To see the solution, plot the components of the solution vector. The
% maximum deflections are in the $z$-direction. Because the part and the
% loading are symmetric, the $x$-displacement and $z$-displacement are
% symmetric and the $y$-displacement is antisymmetric about the part
% centerline.
%
% By default, the plotting routine uses the |'jet'| colormap, which has
% blue as the color representing the lowest value and red representing the
% highest value. The bracket loading causes face 8 to dip down, so the
% maximum $z$-displacement appears blue.
labels = ['x','y','z'];
for i=1:3
  figure
  pdeplot3D(model,'ColorMapData',rs(:,i))
  title([labels(i),'-displacement'])
end



