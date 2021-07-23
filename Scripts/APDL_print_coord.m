
function  APDL_print_coord(nodeCoordinates,elementNodes,struts,cables,interfil,prescribedDof,Radius)
% displays APDL commands for creating nodes, elements and boundary conditions

disp("====================================================================")
disp("          APDL Node Coordinates and Element Connections")
disp("====================================================================")

numberNodes  = size(nodeCoordinates,1);
% displaying the node positions as APDL commands to create the nodes
disp("! Radius = "+Radius);
for jj = 1:numberNodes
    disp("N"+","+(jj)+","+(nodeCoordinates(jj,1))+","+(nodeCoordinates(jj,2))+","+(nodeCoordinates(jj,3))); % eg. N,1,2.5,4.5,5
end

fprintf("!=========== CytoSkeleton Elements =========== \n")

% displaying the nodal connections that form elements 
fprintf("!------- struts ------- \n")
for ii = struts   
   disp("E"+","+(elementNodes(ii,1))+","+(elementNodes(ii,2)));% eg. E,1,7
end
fprintf("!------- cables ------- \n")
for ii = cables   
   disp("E"+","+(elementNodes(ii,1))+","+(elementNodes(ii,2)));% eg. E,1,7
end
fprintf("!------- interfilaments ------- \n")
for ii = interfil   
   disp("E"+","+(elementNodes(ii,1))+","+(elementNodes(ii,2)));% eg. E,1,7
end

fprintf("=========== Color Codes ============\n")

disp("/COLOR,ELEM,RED,"+struts(1)+","+struts(end))
disp("/COLOR,ELEM,BLUE,"+cables(1)+","+cables(end))
if ~ isempty(interfil)
disp("/COLOR,ELEM,WHIT,"+interfil(1)+","+interfil(end))
end

fprintf("=========== Boundary Conditions ============\n")
DOF = ["UX","UY","UZ"];
for ii = prescribedDof  
   node = floor((ii-1)/3)+1;
   disp("D"+","+node+","+DOF( mod(ii,3)+1 )+",0") % eg. D,1,UX,0
end



disp("!-----------------------------")
end

%/COLOR,ELEM,RED,1,6
% /COLOR,ELEM,BLUE,7,30
% /COLOR,ELEM,WHIT,61,72
% /COLOR,ELEM,RED,31,36
% /COLOR,ELEM,BLUE,37,60