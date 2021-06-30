function [deltas,gaps,dips] = check_dip_angles(nodeCoordinates,elementNodes,struts,cables,Radius) 
% calculates the dip angles of all struts in Degrees
% apples only for spherical tensegrities

deltas = ones(1,length(struts))*-1;  % -1 to indicate that the dip angles arent initially calculated ( -1 indicates the dip angle wasnt updated)
gaps = -1*ones(1,length(struts));
dips = -1*ones(2,length(struts));
for jj = 1:length(struts)
    el_n = elementNodes(struts(jj),:);
    dnodes1 = [];
    dnodes2 = [];
    for ii = cables
        if (el_n(1) == elementNodes(ii,1))
            dnodes1 = [dnodes1 elementNodes(ii,2)];
        elseif (el_n(1) == elementNodes(ii,2))
            dnodes1 = [dnodes1 elementNodes(ii,1)];
        end

        if (el_n(2) == elementNodes(ii,1))
            dnodes2 = [dnodes2 elementNodes(ii,2)];
        elseif (el_n(2) == elementNodes(ii,2))
            dnodes2 = [dnodes2 elementNodes(ii,1)];
        end
    end

    dnodes = intersect(dnodes1,dnodes2);
    if length(dnodes) == 2
        
        % --------------- finidng gap -------------------
        gap_vector = nodeCoordinates(dnodes(1),:) - nodeCoordinates(dnodes(2),:);
        gaps(jj) = norm(gap_vector);
        
        % --------------- finidng dip -------------------
        % there are 2 dips for each strut: one for each dnode
        mid = (nodeCoordinates(elementNodes(struts(jj),1),:) + nodeCoordinates(elementNodes(struts(jj),2),:))/2; % mid point of strut
        dip_vector1 = mid - nodeCoordinates(dnodes(1),:);
        dip_vector2 = mid - nodeCoordinates(dnodes(2),:);
        dips(1,jj) = norm(dip_vector1); 
        dips(2,jj) = norm(dip_vector2); 
        
        % --------------- finidng dip angle -------------------
        P1 = [el_n(1) el_n(2) dnodes(1)];
        P2 = [el_n(1) el_n(2) dnodes(2)];

        A1 = nodeCoordinates(P1(1),:);
        B1 = nodeCoordinates(P1(2),:);
        C1 = nodeCoordinates(P1(3),:);
        cent1 =  (A1+B1+C1)/3;

        Va1 = A1-B1;
        Vb1 = C1-B1;
        Vn1 = cross(Va1,Vb1);

        A2 = nodeCoordinates(P2(1),:);
        B2 = nodeCoordinates(P2(2),:);
        C2 = nodeCoordinates(P2(3),:);
        cent2 =  (A2+B2+C2)/3;

        Va2 = A2-B2;
        Vb2 = C2-B2;
        Vn2 = cross(Va2,Vb2);

        Vn1 = 0.3*Radius*Vn1/norm(Vn1);
        Vn2 = 0.3*Radius*Vn2/norm(Vn2);

        dip_angle = asind( norm(cross(Vn1,Vn2))/(norm(Vn1)*norm(Vn2)) );
        deltas(jj) = dip_angle;
%         plot3([cent1(1) Vn1(1)+cent1(1)],[cent1(2) Vn1(2)+cent1(2)],[cent1(3) Vn1(3)+cent1(3)]);
%         hold on
%         plot3([cent2(1) Vn2(1)+cent2(1)],[cent2(2) Vn2(2)+cent2(2)],[cent2(3) Vn2(3)+cent2(3)]);
        % axis([0.1 0.8 -0.6 0.2 0 0.8]*2e-5)
    
    else
        disp("input model is not a spherical tensegrity");
        deltas = [];
        return
    end 
end

end