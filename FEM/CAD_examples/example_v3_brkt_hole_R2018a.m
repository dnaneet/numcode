%'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''%
% "Crane Link" problem in R2018a
%
% Author: Aneet Dharmavaram Narendranath, PhD (c) 2018
%
%'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''%
close all; %preamble
clear all; %preamble
clc; %preamble
model = createpde('structural','static-solid');
importGeometry(model,'Link2.stl'); %Geometry file.

%% Visualization, initial
figure %New figure
pdegplot(model,'FaceLabels','on')
view(30,30); %isometric view
title('Link with Face Labels')

%% Material Properties
structuralProperties(model,'Cell',1,'YoungsModulus',200e9, ...
                                    'PoissonsRatio',0.3); %consistent units need to be used!
                                
%% Boundary conditions
structuralBC(model,'Face',8,'Constraint','fixed');
distributedLoad = 1e4; %Consistent units need to be used
structuralBoundaryLoad (model,'Face',7,'SurfaceTraction',[0,0,-distributedLoad]);

%% Discretization
hmax = 0.25; % Thickness of horizontal plate with hole, meters
generateMesh(model,'Hmax',hmax,'GeometricOrder','linear'); %GeometricOrder can be 'quadratic'
figure %New figure
pdeplot3D(model)
title('Mesh with Tetrahedral Elements');

%% Solution
result = solve(model);

%% Postprocessing

minUz = min(result.Displacement.uz);
fprintf('Maximal deflection in the z-direction is %g meters.', minUz)

%Deflexion
figure
pdeplot3D(model,'ColorMapData',result.Displacement.ux)
title('x-displacement')
colormap('jet')

figure
pdeplot3D(model,'ColorMapData',result.Displacement.uy)
title('y-displacement')
colormap('jet')

figure
pdeplot3D(model,'ColorMapData',result.Displacement.uz)
title('z-displacement')
colormap('jet')

%% Von Mises stress
figure
pdeplot3D(model,'ColorMapData',result.VonMisesStress)
title('von Mises stress')
colormap('jet')

% Axial stress (s_xx)
% This section is incomplete
%
%% 
% [X,Y] = meshgrid(linspace(-0.015,0.015,50));
% Z = ones(size(X))*0.025;
% 
% intrpStress = interpolateStress(result,X,Y,Z);
% surf(X,Y,reshape(intrpStress.sxx,size(X)))

querypoints = [X(:),Y(:),Z(:)]';
intrpStress = interpolateStress(result,querypoints);
surf(X,Y,reshape(intrpStress.szz,size(X)))

% figure
% pdeplot(model,'XYData',result.Stress.sxx,'ColorMap','jet')
