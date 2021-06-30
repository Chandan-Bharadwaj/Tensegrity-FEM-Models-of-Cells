%% mode shapes
function plot_mode_shapes_tensegrity(elementNodes,modes,nodeCoordinates,numMode,numberElements,magnification)
% magnification = 1e-15;
for mode =1:numMode
    figure
    for ii=1:numberElements
        cur_el = elementNodes(ii,:);
      
        x1 = nodeCoordinates(cur_el(1),1);
        y1 = nodeCoordinates(cur_el(1),2);
        z1 = nodeCoordinates(cur_el(1),3);
        x2 = nodeCoordinates(cur_el(2),1); % original structure
        y2 = nodeCoordinates(cur_el(2),2);
        z2 = nodeCoordinates(cur_el(2),3);
        plot3([x1,x2],[y1,y2],[z1,z2],'k','LineWidth',2)
        hold on
    
        x1 = nodeCoordinates(cur_el(1),1)+modes(3*cur_el(1)-2,mode)*magnification ;
        y1 = nodeCoordinates(cur_el(1),2)+modes(3*cur_el(1)-1,mode)*magnification ;
        z1 = nodeCoordinates(cur_el(1),3)+modes(3*cur_el(1),mode)*magnification   ;
        x2 = nodeCoordinates(cur_el(2),1)+modes(3*cur_el(2)-2,mode)*magnification ; % mode shape
        y2 = nodeCoordinates(cur_el(2),2)+modes(3*cur_el(2)-1,mode)*magnification ;
        z2 = nodeCoordinates(cur_el(2),3)+modes(3*cur_el(2),mode)*magnification   ;
        plot3([x1,x2],[y1,y2],[z1,z2],'--r','LineWidth',2) 
    end
title("mode "+mode);
xlabel("X");
ylabel("Y");
zlabel("Z")
% grid on
end
end
