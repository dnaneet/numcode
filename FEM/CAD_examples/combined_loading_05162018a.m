close all;
clear all;
N = 3;
model = createpde('structural','static-solid');
importGeometry(model,'combined_loading_05162018a.stl');

%% Visualization
% Plot the geometry and turn on face labels. You will need the face
% labels to define the boundary conditions.
figure
% subplot(3,2,1)
pdegplot(model,'FaceLabels','on')
%pdegplot(model,'EdgeLabels','on')
view(30,80);
% title('Link, Face-8 is fixed and Face-7 has uniform load.')

%% Define the Coefficients in Toolbox Syntax
% Define the elastic modulus of steel and Poisson's ratio for this material.
E = 210; % elastic modulus of steel in Pascals
% E=1.77e9
nu = 0.35; % Poisson's ratio
structuralProperties(model,'Cell',1,'YoungsModulus',E, ...
                                    'PoissonsRatio',nu);

%%
% Incorporate these coefficients in toolbox syntax.
% c = elasticityC3D(E,nu); %Overall matrix for both plane stress and plane strain
%                          %This is a 6x6 matrix of which 3x3 is for plane stress
%                          %and 3x3 is for plane strain. *this is an 
%                          %undocumented function*
% a = 0; %Coefficient
% f = [0;0;0]; % Assume all body forces are zero

%% Specify PDE Coefficients
% specifyCoefficients(model,'m',0,'d',0,'c',c,'a',a,'f',f);

%The equations for linear elasticity are merely derived from Newton's
%second law.  They are:
%m \ddot{u} + \delta \dot{u} - \nabla\cdot(c \nabla u) + a u = f
%Here, m is the mass matrix, \delta is the damping matrix, a is a
%coefficient necessary to induce some sort of pre-strain, f is a force
%vector while \ddot{u} and \dot{u} are acceleration and velocity, both of
%which are absent for linear elastic problems (static equilibrium).

%% BCs

structuralBC(model,'Face',8,'Constraint','fixed');
% distributedLoad = 1e4; % Applied load in Pascals
% distributedLoad=222.41;
distributedLoad = -5.0926e-3;
%structuralBoundaryLoad (model,'Face',7,'SurfaceTraction',[distributedLoad,0,0]);
structuralBoundaryLoad (model,'Face',9,'SurfaceTraction',[0,0,distributedLoad]);

%% Discretization
hmax = 2.5; % Thickness of horizontal plate with hole, meters
generateMesh(model,'Hmax',hmax,'GeometricOrder','quadratic'); %GeometricOrder can be 'quadratic'
% figure %New figure
figure
pdeplot3D(model)
title('Mesh with Tetrahedral Elements');

%% Solution

result = solve(model);

%% Postprocessing

minUz = min(result.Displacement.uz);
fprintf('Maximal deflection in the z-direction is %g meters.', minUz)

%Deflexion
% 
%  figure
% % subplot(3,2,3)
% pdeplot3D(model,'ColorMapData',result.Displacement.ux)
% title('x-displacement')
% colormap('jet')
% 
%  figure
% % subplot(3,2,4)
% pdeplot3D(model,'ColorMapData',result.Displacement.uy)
% title('y-displacement (due to Generalized Hookes law)')
% colormap('jet')

 figure
% subplot(3,2,5)
pdeplot3D(model,'ColorMapData',result.Displacement.uz)
title('z-displacement (due to Generalized Hookes law)')
colormap('jet')

%Normal stress
figure 
pdeplot3D(model,'ColorMapData',result.Stress.sxx)
title('Normal stress, X-direction')
colormap('jet')
%Von-Mises stress
figure
%  subplot(3,2,6)
pdeplot3D(model,'ColorMapData',result.VonMisesStress)
title({'von Mises stress'; '(Measure of strain energy accumulation'; 'due to mechanical loads)'})
colormap('jet')



