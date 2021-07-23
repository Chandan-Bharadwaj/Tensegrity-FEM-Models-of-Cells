function [nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables] = cell_model_12_to_6(Radius_cell,Radius_nucleus,stand_on_pent)
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
    pent_nodes = [1 9 21];
    
    if stand_on_pent
        X = nodeCoordinates1(:,1); Y = nodeCoordinates1(:,2); Z = nodeCoordinates1(:,3); 
        A = [ X(pent_nodes(1)) , Y(pent_nodes(1)) , Z(pent_nodes(1)) ];
        B = [ X(pent_nodes(2)) , Y(pent_nodes(2)) , Z(pent_nodes(2)) ];
        C = [ X(pent_nodes(3)) , Y(pent_nodes(3)) , Z(pent_nodes(3)) ];
        [X1,Y1,Z1] = Reorient(X,Y,Z,A,B,C,[0 0 -1]);
        base_centre = [mean(X1(pent_nodes)) mean(Y1(pent_nodes)) mean(Z1(pent_nodes))]';
        nodeCoordinates1 = [X1'-base_centre(1)   Y1'-base_centre(2) Z1'-base_centre(3)];
    end
    
    CG1 = mean(nodeCoordinates1);
        
    [nodeCoordinates2,elementNodes2,struts2,cables2] = generate_6_strut_tensegrity(Radius_nucleus,0,0);
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

        
%     interfilElems = zeros(2*numNodes2,2);    
%     for ii = 1:numNodes2
%         length_vectors = nodeCoordinates1 - nodeCoordinates2(ii,:);
%         l = vecnorm(length_vectors');
%         [a,n] = min(l);
%         interfilElems(ii,:) = [n , ii + numNodes1]; 
%     end
    
    interfil = size(elementNodes,1)+[1:size(interfilElems,1)];
    elementNodes = [elementNodes ; interfilElems];
   
    
end


