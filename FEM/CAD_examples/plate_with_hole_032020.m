clc;
close all;
clear all;
model = createpde('structural','static-planestress');

%% Geometric features of a plate with a hole
radius = 20.0;
width = 50.0;
totalLength = 4*width;

R1 = [3 4 0 totalLength/2 totalLength/2 ...
      0 0 0 width width]';
C1 = [1 0 0 radius 0 0 0 0 0 0]'; 
gm = [R1 C1];
%% Boolean operation to create geometry

sf = 'R1-C1';
ns = char('R1','C1');
g = decsg(gm,sf,ns');
geometryFromEdges(model,g);
figure
pdegplot(model,'EdgeLabel','on');
axis equal
title 'Symmetric Quadrant with Edge Labels';


%% Material properties
structuralProperties(model,'YoungsModulus',200E3, ...
                              'PoissonsRatio',0.25);
%% Boundary conditions
structuralBC(model,'Edge',[3 4],'Constraint','symmetric');
structuralBoundaryLoad(model,'Edge',1,'SurfaceTraction',[100;0]);
%% Mesh
mesh_order = 'quadratic';
mesh_size = radius/2;
generateMesh(model,'Hmax',mesh_size, 'GeometricOrder', mesh_order);
figure
pdemesh(model,'NodeLabels','on')
title('Quadratic triangles (linear strain triangle) representation')
set(gca, 'FontSize', 16)

%% Solution

R = solve(model);

%% Stress contours

figure
pdeplot(model,'XYData',R.VonMisesStress,'ColorMap','jet')
axis equal
title 'Von-Mises Stress';
