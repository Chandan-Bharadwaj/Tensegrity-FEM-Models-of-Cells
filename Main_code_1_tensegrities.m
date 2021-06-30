clc;
clear ; 
close all

%% properties and boundry conditions of tensegrity structure (input)

Radius = (18e-6)/2;  % radius of cell - Osteoblast (bone cell)

a1 = 190e-18; %area of struts
a2 = 18e-18;  %area of cables
a3 = 18e-18;  %area of interfilaments

d1 = 125; %density of all struts
d2 = 125; %density of all cables
d3 = 125; %density of all interfilaments

E1 = 1.2e9; %modulus of elasticity of struts
E2 = 2.6e9; %modulus of elasticity of cables
E3 = 2.6e9; %modulus of elasticity of interfilaments

% boundary conditions 8 18 7 24     47 48          9 19 20 21   51 60
% prescribedDof = [1 2 3 7 8 9 13 14 15];
fixed_nodes = [1 3 5 12 44];
prescribedDof = 3*fixed_nodes-[2 1 0]';
prescribedDof = prescribedDof(:)';

numMode = 3;  % number of mode shapes required to be plotted (all NF are caculated)

%% Model Generation

% initialization of Model data
% the following variables store the data of the tensegrity/Cell model
nodeCoordinates = [];elementNodes = [];struts = [];cables = [];interfil = [];

% Uncomment the required choice of tensegrity structure

%  six strut Spherical tensegrity ((, , 1) for spread cell configuration) 
%     [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_6_strut_tensegrity(Radius,0,0);
% fixed_nodes = [1 3 5];

% twelve strut spherical cuboctahedron tensegrity
      [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_cuboctahedron_tensegrity(Radius,1);
fixed_nodes = [1 9 21];

% thirty strut spherical icosidodecahedron tensegrity
%       [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_30_strut_icosidodecahedron_tensegrity(Radius,1);
% fixed_nodes = [1 14 44];

% other tensegrities

% cylindrical tensegrity
% n = 3;    % number of struts for cylindrical tensegrity
%      [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_prismatic_tensegrity(Radius,n,1);
% fixed_nodes = [1 3 5];
     
% twelve strut spherical rhombicuboctadodecahedron tensegrity
%      [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_rhombicuboctadodecahedron_tensegrity(Radius);
% fixed_nodes = [1 3 5];

% twelve strut spherical tensegrity - built form [prismatic tensegrities
%       [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_tensegrity(Radius);
% fixed_nodes = [1 3 5];

numberElements = length(elementNodes); % number of elements
numberNodes = length(nodeCoordinates); % number of nodes
GDof = 3*numberNodes;

print_model_tens(nodeCoordinates,elementNodes,struts,cables,interfil,Radius);

% display fixed nodes (Boundary conditions)
for nn = fixed_nodes
     scatter3(nodeCoordinates(nn,1),nodeCoordinates(nn,2),nodeCoordinates(nn,3),400,'.k')
%      text(nodeCoordinates(nn,1),nodeCoordinates(nn,2),nodeCoordinates(nn,3),"  "+nn,'FontSize',10)
     hold on
end

%% Main program

% assigning areas of struts and cables
A = zeros(numberElements,1);
A(struts) = a1;
A(cables) = a2;
A(interfil) = a3;

% assigning the densities of various sections
rho = zeros(numberElements,1);
rho(struts) = d1;
rho(cables) = d2;
rho(interfil) = d3;

% assigning the modulus of elasticities of various sections
E = zeros(numberElements,1);
E(struts) = E1;
E(cables) = E2;
E(interfil) = E3;

% stiffness matrix
[stiffness] = formStiffness3Dtruss1(GDof,numberElements, elementNodes,nodeCoordinates,E,A);

% mass matrix
[mass] = formMass3Dtruss1(GDof,numberElements, elementNodes,nodeCoordinates,rho,A);

% free vibration problem
[modes,eigenvalues] = eigenvalue(GDof,prescribedDof,stiffness,mass,0);
omega = sqrt(eigenvalues)/(2*pi);


 elLengths = check_elements(nodeCoordinates,elementNodes,Radius);
 cyto_mass = sum(A.*elLengths.*rho)

%% outputs

magnification = 1e-15;
plot_mode_shapes_tensegrity(elementNodes,modes,nodeCoordinates,numMode,numberElements,magnification)   %plot the tensegrity
  
% print the apdl macro codes for coordinates and connectivities
APDL_print_coord(nodeCoordinates,elementNodes,struts,cables,interfil,prescribedDof,Radius)  % print the apdl code for coordinates and connectivities
% Copy Paste the output onto APDL macro script to generate the tensegrity line model In ANsys Mechanical APDL 

plot_model(nodeCoordinates,elementNodes,struts,cables,interfil,Radius);
 
% check_nodes(nodeCoordinates,elementNodes,Radius);
% deltas = check_dip_angles(nodeCoordinates,elementNodes,struts,cables,Radius)
% elLengths = check_elements(nodeCoordinates,elementNodes,Radius)

% print_model(nodeCoordinates,elementNodes,struts,cables,interfil,Radius,A,100);
