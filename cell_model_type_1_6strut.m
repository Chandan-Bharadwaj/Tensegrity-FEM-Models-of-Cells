function [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_type_1(Radius1,Radius2,spread)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    struts = [];
    cables = [];
    interfil = [];
    cytoStruts = [];
    cytoCables = [];
    nucleoStruts = [];
    nucleoCables = [];
    
    [nodeCoordinates1,elementNodes1,struts1,cables1] = generate_6_strut_tensegrity(Radius1,spread,0);          
    CG1 = mean(nodeCoordinates1)
    
    [nodeCoordinates2,elementNodes2,struts2,cables2] = generate_6_strut_tensegrity(Radius2,0,0);
    CG2 = mean(nodeCoordinates2)
    
%      n = 6;    % number of struts for cylindrical tensegrity
%     [nodeCoordinates1,elementNodes1,struts1,cables1] = generate_prismatic_tensegrity(Radius1,n,0);
%     CG1 = mean(nodeCoordinates1);
%     
%     [nodeCoordinates2,elementNodes2,struts2,cables2] = generate_prismatic_tensegrity(Radius2,n,0);
%     CG2 = mean(nodeCoordinates2);
 
    
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


