function [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_type_1_12strut(Radius_cell,Radius_nucleus)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    struts = [];
    cables = [];
    interfil = [];
    cytoStruts = [];
    cytoCables = [];
    nucleoStruts = [];
    nucleoCables = [];
    
    [nodeCoordinates1,elementNodes1,struts1,cables1] = generate_12_strut_cuboctahedron_tensegrity(Radius_cell,1);        
    CG1 = mean(nodeCoordinates1)
    
    [nodeCoordinates2,elementNodes2,struts2,cables2] = generate_12_strut_cuboctahedron_tensegrity(Radius_nucleus,1);
    CG2 = mean(nodeCoordinates2)
    
    nodeCoordinates2 = nodeCoordinates2 - CG2 + CG1;
    
    nodeCoordinates = [nodeCoordinates1; nodeCoordinates2];
    numNodes1 = size(nodeCoordinates1,1);
    
    elementNodes = [elementNodes1; elementNodes2+numNodes1];
    numElements1 = size(elementNodes1,1);
    struts = [struts1 struts2+numElements1];
    cables = [cables1 cables2+numElements1];
    
    cytoStruts = 1:length(struts1);
    cytoCables = 1:length(cables1);
          
    nucleoStruts = length(struts1)+1:length(struts);
    nucleoCables = length(cables1)+1:length(cables);    
    
    interfilElements = [0 numNodes1]+[1:numNodes1]';
    interfil =  size(elementNodes,1)+[1:numNodes1];
    elementNodes = [elementNodes ; interfilElements];
end


