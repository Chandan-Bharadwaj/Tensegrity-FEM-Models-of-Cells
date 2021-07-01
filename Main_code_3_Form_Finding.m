%================================================
% Form Finding
%   - refine the node structure using numerical form finding technique 
%   - any combination of element connections and tensegion cefficients can be given as an input 
%   - the corresponding node coordinates of a stable tensegrity structure is obatined
%   - G. Gomez Estrada, H.-J. Bungartz, C. Mohrdieck, Numerical form-finding of tensegrity structures, I
%     nternational Journal of Solids and Structures, Volume 43, https://doi.org/10.1016/j.ijsolstr.2006.02.012.   
%================================================

% 2 ways of observing functionality of function findform()
%  1) generate a standard tensegrity -> randomize its nodes -> get back the original form through form finding (using elements data)
%  2) Make a new tensegrity structure - make your own elements connections
%       and obtain a stable form of the new tensegrity

% 1) Using standard tensegrities
Radius = 10;

% % cylindrical tensegrity
% n = 8;    % number of struts for cylindrical tensegrity
%      [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_prismatic_tensegrity(Radius,n,0);

%     [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_6_strut_tensegrity(Radius,1,0);

% twelve strut spherical cuboctahedron tensegrity
      [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_cuboctahedron_tensegrity(Radius,1);

%  Randomizing tensegrity nodes
 nodeCoordinates = rand(size(nodeCoordinates));  
 
% ------------------------------------ OR ---------------------------------

% 2) Make a new tensegrity structure

    % Make your own element connections 
% ex. planar tensegrity
% nodeCoordinates = [1 2 3 4 15 6;9 0 18 7 6 -10;0 0 0 0 0 0]';
% elementNodes = [1 4; 2 5 ; 3 6; 1 2 ; 2 3; 3 4; 4 5; 5 6; 6 1];
% struts = [1 2 3];
% cables = [ 4 5 6 7 8 9];  
% interfil = [];

%%
% Form Finding - Obtaining a stable set of node coordinates 

% initial guess of tension coeffecien for struts (can be improved)
qc = -1.22405;   

[nodeCoordinates_new] = findform(nodeCoordinates,elementNodes,struts,cables,qc);

%initial model
print_model_tens(nodeCoordinates,elementNodes,struts,cables,interfil,0);
title(" Inital Model");

% stable structure after Form Finding
print_model_tens(nodeCoordinates_new,elementNodes,struts,cables,interfil,0);
title(" Stable Form");