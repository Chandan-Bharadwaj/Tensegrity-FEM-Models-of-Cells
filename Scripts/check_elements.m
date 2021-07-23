function [elLengths,mids] = check_elements(nodeCoordinates,elementNodes,Radius)
% checks for intersecting elements
% calculates the lengths of all elements

numElem = size(elementNodes,1);
mids = zeros(numElem,3);
elLengths = -1*ones(numElem,1);  % initializing with -1 to check later for logical error in length calculation
for ii = 1:numElem
        elLengths(ii) = norm(nodeCoordinates(elementNodes(ii,1),:)' - nodeCoordinates(elementNodes(ii,2),:)');
        mids(ii,:) = (nodeCoordinates(elementNodes(ii,1),:)' + nodeCoordinates(elementNodes(ii,2),:)')/2;
%             text(mids(ii,1),mids(ii,2),mids(ii,3)," "+elLengths(ii));
end
    
tol = Radius*1e-8;
true_node = [1 1 1]';
for ii = 1:numElem-1

n1 = nodeCoordinates(elementNodes(ii,1),:)';
n2 = nodeCoordinates(elementNodes(ii,2),:)';

    for jj = ii+1:numElem
        n3 = nodeCoordinates(elementNodes(jj,1),:)';
        n4 = nodeCoordinates(elementNodes(jj,2),:)';
        
        P = n1-n3;
        Q = -(n2-n1);
        R = n4-n3;

        if Q(2) ~= 0
            f1 = Q(1)/Q(2);
            b = (P(1)-f1*P(2))/(R(1)-f1*R(2));
        elseif Q(3) ~= 0
            f1 = Q(1)/Q(3);
            b = (P(1)-f1*P(3))/(R(1)-f1*R(3));
        elseif Q(1) ~= 0
            f1 = Q(2)/Q(1);
            b = (P(2)-f1*P(1))/(R(2)-f1*R(1));
        else 
            disp(" #$%*#*$* ");
        end

        if R(2) ~= 0
            f2 = R(1)/R(2);
            a = (P(1)-f2*P(2))/(Q(1)-f2*Q(2));
        elseif R(3) ~= 0
            f2 = R(1)/R(3);
            a = (P(1)-f2*P(3))/(Q(1)-f2*Q(3));
        elseif R(1) ~= 0
            f2 = R(2)/R(1);
            a = (P(2)-f2*P(1))/(Q(2)-f2*Q(1));
        else 
            disp(" #$%*#*$* ");
        end
        a = round(a,7);      % sometimes a,b comes almost 1 but is not detected as 1
        b = round(b,7);
        int1 = -Q*a + n1;   
        int2 = R*b + n3;  
        true_intesection = isequal( (abs(int1-int2)<=tol),true_node);
        if true_intesection && (a<1 && a>0) && (b<1 && b>0)
%             disp("( "+ii+" "+jj+") ( "+a+" "+b+") ["+int2str(elementNodes(ii,:))+"] , ["+int2str(elementNodes(jj,:))+"]");
            disp("intersection detected btw elements : ["+int2str(elementNodes(ii,:))+"] , ["+int2str(elementNodes(jj,:))+"]");  
        end
    end
end

%     function check_intersection(nodeCoordinates,elementNodes,elements)
% struts,cables,interfil,

end
