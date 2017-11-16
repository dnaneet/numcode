%Demonstrates difference between linear and quadratic mesh

%% Plate with hole

model = createpde(1);

R1 = [3,4,-1,1,1,-1,-.4,-.4,.4,.4]';
C1 = [1,.5,0,.2]';
% Pad C1 with zeros to enable concatenation with R1
C1 = [C1;zeros(length(R1)-length(C1),1)];
geom = [R1,C1];
ns = (char('R1','C1'))';
sf = 'R1-C1';
gd = decsg(geom,sf,ns);

geometryFromEdges(model,gd);
pdegplot(model,'EdgeLabels','on')
xlim([-1.1 1.1])
axis equal

%%
% close all;
% clear all;
% model = createpde;
% geometryFromEdges(model,@lshapeg);
msh_sz=1;
generateMesh(model, 'Hmax',msh_sz,'GeometricOrder', 'linear');

subplot(2,2,1)
pdemesh(model)
subplot(2,2,2)
pdemesh(model,'NodeLabels','on')
[pLin,eLin,tLin] = meshToPet(model.Mesh);

subplot(2,2,3)
pdemesh(model)
generateMesh(model, 'Hmax',msh_sz,'GeometricOrder', 'quadratic');
subplot(2,2,4)
pdemesh(model,'NodeLabels','on')
[pQuad,eQuad,tQuad] = meshToPet(model.Mesh);

%% [p e t]:  
%p = 2 x Np where Np is the number of points.  The dimensions of this
%matrix could be 3 x Np for a 3D model.
%
%e = 7 x Ne where Ne is the number of edges.  This is the mesh
%associativity matrix
%
%t = 4 x Nt or 7 x Nt for 2D elements, for linear and quadratic
%representations, respectively.  For 3D elements, one would have 5 x Nt or
%11 x Nt.



