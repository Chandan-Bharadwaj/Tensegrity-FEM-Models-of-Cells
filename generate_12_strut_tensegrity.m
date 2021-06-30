function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_tensegrity(Radius)

interfil = [];
elementNodes = [];
struts = [];
cables = [];

factor = 1.8; % h = factor*r i.e.,  h=4*r

r = Radius/sqrt(factor^2+1);
h = 2*factor*(Radius/sqrt(factor^2+1));

[nodeCoordinates,elementNodes,struts,cables] = generate_prismatic_tensegrity_variation2(r,r,h,4);
X = nodeCoordinates(:,1)'; 
Y = nodeCoordinates(:,2)'; 
Z = nodeCoordinates(:,3)'; 
A = [X(1) Y(1) Z(1)]';
B = [X(2) Y(2) Z(2)]';
C = [X(3) Y(3) Z(3)]';

V01 = [1 0 0]';
V02 = [0 1 0]';

[X1,Y1,Z1] = Reorient(X,Y,Z,A,B,C,V01);
CG1 = [mean(X1) mean(Y1) mean(Z1)];
[X2,Y2,Z2] = Reorient(X,Y,Z,A,B,C,V02);
CG2 = [mean(X2) mean(Y2) mean(Z2)];
CG3 = [mean(X) mean(Y) mean(Z)];

nodeCoordinates1 = [ X1'-CG1(1) Y1'-CG1(2) Z1'-CG1(3)];
nodeCoordinates2 = [ X2'-CG2(1) Y2'-CG2(2) Z2'-CG2(3)];
nodeCoordinates3 = [ X'-CG3(1) Y'-CG3(2) Z'-CG3(3)];

nodeCoordinates = [nodeCoordinates1;nodeCoordinates2;nodeCoordinates3];
numNodes1 = size(nodeCoordinates1,1);
numElems1 = size(elementNodes,1);
elementNodes = [elementNodes; elementNodes+numNodes1 ; elementNodes+2*numNodes1];
struts = [struts (struts+numElems1) (struts+2*numElems1)];
cables = [[1:2*4] ([1:2*4]+numElems1) ([1:2*4]+2*numElems1)];
elementNodes = [elementNodes ; 1 11; 1 18; 11 18; 2 10; 2 23; 10 23; 3 15; 3 24; 15 24; 4 16; 4 19; 16 19;...
         5 13; 5 20; 13 20; 6 12; 6 17; 12 17; 7 9; 7 22; 9 22; 8 21; 8 14; 21 14];
cables = [cables 3*numElems1+[1:8*3]];

% observed cables connections (cables forming triangles)
% 1 11 18
% 2 10 23
% 3 15 24
% 4 16 19
% 5 13 20
% 6 12 17
% 7 9  22
% 8 21 14

end

