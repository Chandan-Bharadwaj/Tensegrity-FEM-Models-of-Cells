clc;
clear;
close all
addpath('Scripts')
%% properties and boundry conditions of tensegrity structure (input)

% canceroes cell
Radius_cell = 15.91e-6;  % radius of cell
Radius_nucleus =  6.45e-6;     % radius of nucleus

% non cancerous cell
% Radius_cell =  6.80e-6;  % radius of cell 
% Radius_nucleus = 4.41e-6;     % radius of nucleus

% Osteblast cell
% Radius_cell = 9e-6;         % radius of cell
% Radius_nucleus = 1.7e-6;     % radius of nucleus

a1 = 190e-18; %area of cytoskeleton struts
a2 = 38.48e-18;  %area of cytoskeleton cables
a3 = 63.62e-18;  %area of interfilaments
a4 = 10e-18; %area of nucleus struts
a5 = 4e-18;   %area of nucleus cables

d1 = 125; %density of all cytoskeleton struts
d2 = 125; %density of all cytoskeleton cables
d3 = 125; %density of all interfilaments
d4 = 125; %density of all nucleus struts
d5 = 125; %density of all nucleus cables

E1 = 1.2e9; %modulus of elasticity of cytoskeleton struts
E2 = 2.6e9; %modulus of elasticity of cytoskeleton cables
E3 = 2.6e9; %modulus of elasticity of interfilaments
E4 = 10e9;  %modulus of elasticity of nucleus struts
E5 = 4.3e9; %modulus of elasticity of nucleus cables

% boundary conditions 
prescribedDof = [1 2 3 7 8 9 13 14 15 25 12*3+[1:9]];

numMode = 3;  % number of mode shapes required

%% Model Generation
% Uncomment the required tensegrity model

% initialization of Model data
% the following variables store the data of the tensegrity/Cell model
nodeCoordinates = [];elementNodes = [];struts = [];cables = [];interfil = [];
cytoStruts = [];cytoCables = [];nucleoStruts = [];nucleoCables = []; 

%  six strut Spherical tensegrity ((, , 1) for spread cell configuration) 
%     [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_6_strut_tensegrity(Radius_cell,0,0);
% cytoStruts = 1:length(struts);cytoCables = 1:length(cables);
%     fixed_nodes = [1 3 5];

%  cell model 6 - 6 strut tensegrity ((, , 1) for spread cell configuration) 
%     [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_type_1_6strut(Radius_cell,Radius_nucleus,1);
% fixed_nodes = [1 3 5];

%  cell model 12 - 12 strut tensegrity
%     [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_type_1_12strut(Radius_cell,Radius_nucleus);
% fixed_nodes = [1 9 21];

%  cell model 30 - 30 strut tensegrity
%     [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_type_1_30strut(Radius_cell,Radius_nucleus,1);
% fixed_nodes = [1 14 44];

%  cell model 30 to 6 strut tensegrity
    [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_30_to_6(Radius_cell,Radius_nucleus,0);
fixed_nodes = [1 14 44];

%  cell model 6 to 30 strut tensegrity
%     [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_6_to_30(Radius_cell,Radius_nucleus);
% fixed_nodes = [1 3 5];

%  cell model 12 to 6 strut tensegrity
%     [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_12_to_6(Radius_cell,Radius_nucleus,0);
% fixed_nodes =  [1 9 21];

numberElements = length(elementNodes); % number of elements
numberNodes = length(nodeCoordinates); % number of nodes
GDof = 3*numberNodes;

prescribedDof = 3*fixed_nodes-[2 1 0]';
prescribedDof = prescribedDof(:)';
    
print_model_cell(nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables,Radius_cell);

% display fixed nodes (Boundary conditions)
for nn = fixed_nodes
     scatter3(nodeCoordinates(nn,1),nodeCoordinates(nn,2),nodeCoordinates(nn,3),200,'.k')
%      text(nodeCoordinates(nn,1),nodeCoordinates(nn,2),nodeCoordinates(nn,3),"  "+nn,'FontSize',10)
     hold on
end

%% Main program

% assigning areas of struts and cables
A = zeros(numberElements,1);
A(struts(cytoStruts)) = a1;
A(cables(cytoCables)) = a2;
A(interfil) = a3;
A(struts(nucleoStruts)) = a4;
A(cables(nucleoCables)) = a5;

% assigning the densities of various sections
rho = zeros(numberElements,1);
rho(struts(cytoStruts)) = d1;
rho(cables(cytoCables)) = d2;
rho(interfil) = d3;
rho(struts(nucleoStruts)) = d4;
rho(cables(nucleoCables)) = d5;

% assigning the modulus of elasticities of various sections
E = zeros(numberElements,1);
E(struts(cytoStruts)) = E1;
E(cables(cytoCables)) = E2;
E(interfil) = E3;
E(struts(nucleoStruts)) = E4;
E(cables(nucleoCables)) = E5;

[elLengths,mids] = check_elements(nodeCoordinates,elementNodes,Radius_cell);
cytoskel = [struts(cytoStruts) cables(cytoCables)];
nucleus = [struts(nucleoStruts) cables(nucleoCables)];
cyto_mass = sum(A(cytoskel).*elLengths(cytoskel).*rho(cytoskel))
nucleo_mass = sum(A(nucleus).*elLengths(nucleus).*rho(nucleus))
%%
% stiffness matrix
[stiffness] = formStiffness3Dtruss1(GDof,numberElements, elementNodes,nodeCoordinates,E,A);

% mass matrix
[mass] = formMass3Dtruss1(GDof,numberElements, elementNodes,nodeCoordinates,rho,A);

% free vibration problem
[modes,eigenvalues] = eigenvalue(GDof,prescribedDof,stiffness,mass,0);

% natural frequencies
omega = sqrt(eigenvalues)/(2*pi);

%% outputs

% magnification = 0.2;
 magnification = 2.2e-15;
plot_mode_shapes_tensegrity(elementNodes,modes,nodeCoordinates,numMode,numberElements,magnification)   %plot the tensegrity

% print the apdl macro codes for coordinates and connectivities
APDL_print_coord_cell(nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables,prescribedDof,Radius_cell,Radius_nucleus)
% Copy Paste the output onto APDL macro script to generate the tensegrity line model In ANsys Mechanical APDL 

% plot_model(nodeCoordinates,elementNodes,struts,cables,interfil,0)
print_model_cell(nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables,Radius_cell);

check_nodes(nodeCoordinates,elementNodes,Radius_cell);
[elLengths,mids] = check_elements(nodeCoordinates,elementNodes,Radius_cell);


