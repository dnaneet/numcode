function [y] = link_fea(e_size)
%close all;
%clear all;
N = 3;
model = createpde('structural','static-solid');
importGeometry(model,'Link2.STL');

E = 200e9; % elastic modulus of steel in Pascals
nu = 0.3; % Poisson's ratio
structuralProperties(model,'Cell',1,'YoungsModulus',E, ...
                                    'PoissonsRatio',nu);
                                
structuralBC(model,'Face',8,'Constraint','fixed');
distributedLoad = 1e4; % Applied load in Pascals
structuralBoundaryLoad (model,'Face',7,'SurfaceTraction',[distributedLoad,0,0]);

hmax = e_size; % Thickness of horizontal plate with hole, meters
generateMesh(model,'Hmax',hmax,'GeometricOrder','linear'); %GeometricOrder can be 'quadratic'

result = solve(model);
y = min(result.Displacement.uz);