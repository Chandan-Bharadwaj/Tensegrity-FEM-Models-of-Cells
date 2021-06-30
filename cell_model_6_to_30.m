    function [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_6_to_30(Radius_cell,Radius_nucleus)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    struts = [];
    cables = [];
    interfil = [];
    cytoStruts = [];
    cytoCables = [];
    nucleoStruts = [];
    nucleoCables = [];
    
    [nodeCoordinates1,elementNodes1,struts1,cables1] = generate_6_strut_tensegrity(Radius_cell,0,0);
    CG1 = mean(nodeCoordinates1);
    
    [nodeCoordinates2,elementNodes2,struts2,cables2] = generate_30_strut_icosidodecahedron_tensegrity(Radius_nucleus,1);          
    CG2 = mean(nodeCoordinates2);
        
    nodeCoordinates2 = nodeCoordinates2 - CG2 + CG1;
    
    nodeCoordinates = [nodeCoordinates1; nodeCoordinates2];
    
    numNodes1 = size(nodeCoordinates1,1);
    numNodes2 = size(nodeCoordinates2,1);
      
    elementNodes = [elementNodes1; elementNodes2+numNodes1];
    numElements1 = size(elementNodes1,1);
    numElements2 = size(elementNodes2,1);
    
    struts = [struts1 struts2+numElements1];
    cables = [cables1 cables2+numElements1];
    
    cytoStruts = 1:length(struts1);
    cytoCables = 1:length(cables1);
  
    nucleoStruts = length(struts1)+1:length(struts);
    nucleoCables = length(cables1)+1:length(cables);
    
%     interfilElements = [0 numNodes1]+[1:numNodes1]';
%     interfil =  size(elementNodes,1)+[1:numNodes1];
%     elementNodes = [elementNodes ; interfilElements];
    
    interfilElems = zeros(numNodes2,2);
    for ii = 1:numNodes2
        length_vectors = nodeCoordinates1 - nodeCoordinates2(ii,:);
        l = vecnorm(length_vectors');
        [a,n] = min(l);
        interfilElems(ii,:) = [n , ii + numNodes1]; 
    end
    
    interfil = size(elementNodes,1)+[1:numNodes2];
    elementNodes = [elementNodes ; interfilElems];
   
    
end


