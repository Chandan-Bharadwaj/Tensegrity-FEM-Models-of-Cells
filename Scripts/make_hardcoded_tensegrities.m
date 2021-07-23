clc
close all
clear

format longe

% d = pi/2;
% g = sin(d/2)^2;
% Radius =  sqrt((1+3*g)/(16*g));% Radius = 0.55;
% [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_6_strut_tensegrity(Radius,1,0);

d = pi/3;
g = sin(d/2)^2;
Radius =  sqrt((1+3*g)/(16*g));% Radius = 0.6614;
[nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_cuboctahedron_tensegrity(1,1);

% d = pi/5;
% g = sin(d/2)^2;
% Radius =  sqrt((1+3*g)/(16*g)); % Radius = 0.9176;
% [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_30_strut_icosidodecahedron_tensegrity(1,1);


plot_model(nodeCoordinates,elementNodes,struts,cables,interfil,0);

check_nodes(nodeCoordinates,elementNodes,Radius);
[deltas,gaps,dips] = check_dip_angles(nodeCoordinates,elementNodes,struts,cables,Radius)
[elLengths,mids] = check_elements(nodeCoordinates,elementNodes,Radius);
elLengths'

NC = num2str(nodeCoordinates,15) + " ;... ";
EN = num2str(elementNodes) + " ;... ";

for ii = 1:size(nodeCoordinates,1)
disp(NC(ii))
end

for ii = 1:size(elementNodes,1)
disp(EN(ii))
end
