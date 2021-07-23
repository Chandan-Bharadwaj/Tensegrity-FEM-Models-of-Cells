function [mids,elLengths] = check_nodes(nodeCoordinates,elementNodes,Radius)
% checks whether the nodes lie of the surface of a sphere
%       (does not apply for non-round cell configurations)


numNodes = size(nodeCoordinates,1);
numElem = size(elementNodes,1);

CG = [sum(nodeCoordinates(:,1))/length(nodeCoordinates(:,1)), sum(nodeCoordinates(:,2))/length(nodeCoordinates(:,2)), sum(nodeCoordinates(:,3))/length(nodeCoordinates(:,3))];
tol = 1e-9;
all_err = [];
for ii=1:numNodes
    err = (nodeCoordinates(ii,1)-CG(1))^2 + (nodeCoordinates(ii,2)-CG(2))^2 + (nodeCoordinates(ii,3)-CG(3))^2  - Radius^2;
    if err <= tol
        node_check = 1;
    else
        node_check = 0;
    end
    all_err = [all_err err];
end
disp("---------------------------------");
if node_check ==1
    disp("Node check: success");
    disp("Max. error :- "+max(all_err));
else
    disp("Node check: Fail");
end
disp("---------------------------------");

%%


 
    

end
