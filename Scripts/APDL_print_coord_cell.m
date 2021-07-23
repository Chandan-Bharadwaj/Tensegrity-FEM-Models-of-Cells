


function  APDL_print_coord_cell(nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables,prescribedDof,Radius_cell,Radius_nucleus)
% displays APDL commands for creating nodes, elements and boundary conditions

disp("==================================================================")
disp("         APDL Node Coordinates and Element Connections")
disp("==================================================================")

numberNodes  = size(nodeCoordinates,1);
disp("! Cell Radius = "+Radius_cell);
disp("! nucleus Radius = "+Radius_nucleus);
% displaying the node positions as APDL commands to create the nodes
for jj = 1:numberNodes
    disp("N"+","+(jj)+","+(nodeCoordinates(jj,1))+","+(nodeCoordinates(jj,2))+","+(nodeCoordinates(jj,3))); % eg. N,1,2.5,4.5,5
end


% displaying the nodal connections that form elements 
fprintf("!=========== CytoSkeleton Elements =========== \n")
fprintf("!------- cyto struts ------- \n")
for ii = cytoStruts  
   str = struts(ii);
   disp("E"+","+(elementNodes(str,1))+","+(elementNodes(str,2)));% eg. E,1,7
end

fprintf("!------- cyto cables ------- \n")
for ii = cytoCables  
   cab = cables(ii);
   disp("E"+","+(elementNodes(cab,1))+","+(elementNodes(cab,2)));% eg. E,1,7
end
fprintf("!=========== nucleus Elements =========== \n")

fprintf("!------- nucleo struts ------- \n")
for ii = nucleoStruts  
   str = struts(ii);
   disp("E"+","+(elementNodes(str,1))+","+(elementNodes(str,2)));% eg. E,1,7
end
fprintf("!------- nucleo cables ------- \n")
for ii = nucleoCables  
   cab = cables(ii);
   disp("E"+","+(elementNodes(cab,1))+","+(elementNodes(cab,2)));% eg. E,1,7
end


fprintf("!=========== interfilaments =========== \n")
for ii = interfil   
   disp("E"+","+(elementNodes(ii,1))+","+(elementNodes(ii,2)));% eg. E,1,7
end

fprintf("=========== Color Codes ============\n")

disp("!Cytoskeleton")
disp("/COLOR,ELEM,RED,"+struts(cytoStruts(1))+","+struts(cytoStruts(end)))
disp("/COLOR,ELEM,BLUE,"+cables(cytoCables(1))+","+cables(cytoCables(end)))
if( ~isempty(nucleoStruts))
    disp("!Nucleus")
    disp("/COLOR,ELEM,RED,"+struts(nucleoStruts(1))+","+struts(nucleoStruts(end)))
    disp("/COLOR,ELEM,BLUE,"+cables(nucleoCables(1))+","+cables(nucleoCables(end)))
end
if ~(isempty(interfil))
    disp("!Interfilaments")
    disp("/COLOR,ELEM,WHIT,"+interfil(1)+","+interfil(end))
end
disp("!-----------------------------")

disp("/SOLU")
fprintf("! ============== Boundary Conditions =============\n")
DOF = ["UX","UY","UZ"];
for ii = prescribedDof  
   node = floor((ii-1)/3)+1;
   disp("D"+","+node+","+DOF( mod(ii,3)+1 )+",0") % eg. D,1,UX,0
end


end