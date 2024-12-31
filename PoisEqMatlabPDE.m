% https://www.mathworks.com/help/pde/ug/solve-poissons-equation-on-a-unit-disk.html
tic
%% Create PDE model and include geometry
model = createpde();
geometryFromEdges(model,@squareg); % Changed from @circleg

%%

figure
pdegplot(model,"EdgeLabels","on"); 
axis equal

%% Dirichlet BC
applyBoundaryCondition(model,"dirichlet", ...
                             "Edge",1:model.Geometry.NumEdges, ...
                             "u",0);

%% Make it Poisson
specifyCoefficients(model,"m",0,"d",0,"c",1,"a",0,"f",1);

%% Mesh
hmax = 0.1;
generateMesh(model,"Hmax",hmax);
figure
pdemesh(model); 
axis equal

%% Solve
results = solvepde(model);
u = results.NodalSolution;
pdeplot(model,"XYData",u)
title("Numerical Solution");
xlabel("x")
ylabel("y")

%%
pdeplot(results.Mesh,XYData=u,ZData=u)
tiktok = toc;