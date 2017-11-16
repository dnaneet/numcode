close all;
clear all;
N = 3;
model = createpde(N);
importGeometry(model,'washer2.stl');

%% Visualization
% Plot the geometry and turn on face labels. You will need the face
% labels to define the boundary conditions.
figure
%pdegplot(model,'FaceLabels','on')
pdegplot(model,'EdgeLabels','on')
view(30,30);
title('Washer with Face Labels')

