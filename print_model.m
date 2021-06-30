function [fig,s1] = print_model(nodeCoordinates,elementNodes,struts,cables,interfil,Radius,A,A_scale)
% struts/cables/interfil = [] => do not display struts/cables/interfil 
% Radius = 0 => do not display sphere
% returns the handle to the figure as variable - fig

fig = figure;
s0 = subplot(1,1,1);
X = nodeCoordinates(:,1);
Y = nodeCoordinates(:,2);
Z = nodeCoordinates(:,3);

A = A*A_scale;
font_size = 9;
hold on
for el = struts
         Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],A(el),7,'r',1,0);
end
for el = cables
         Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],A(el),7,'b',1,0);
end
for el = interfil
        Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],A(el),7,'g',1,0);
end

% naming of nodes
for el = 1:length(X)
     scatter3(X(el),Y(el),Z(el),300,'.r')
     text(X(el),Y(el),Z(el),"  "+el,'FontSize',font_size)
     hold on
end

% for ii = 1:12
% %       plot3( [X(ii),CG(1)],[Y(ii),CG(2)],[Z(ii),CG(3)],"g")
%       Cylinder_arbitrary([X(ii), Y(ii), Z(ii)],[CG(1),CG(2),CG(3)],r_interfilaments,7,'g',1,1);
% end

if Radius ~=0
    CG = [sum(X)/length(X),sum(Y)/length(Y),sum(Z)/length(Z)] ;
    % centre node
    % scatter3(CG(1),CG(2),CG(3),300,'.r')

    % Outer sphere
    [X_sp, Y_sp, Z_sp] = sphere(50);
    X_sp = X_sp*Radius + CG(1);
    Y_sp = Y_sp*Radius + CG(2);
    Z_sp = Z_sp*Radius + CG(3);

    Sp = surf(X_sp, Y_sp, Z_sp);
    Sp.FaceColor = 'b';
    Sp.FaceAlpha = 0.01;    
    Sp.EdgeAlpha = 0.08;
end

xlabel(" X axis")
ylabel(" Y axis")
zlabel(" Z axis")
% axis equal
grid on
% 
% fig2 = figure;
% s1 = subplot(2,2,1);
% copyobj(allchild(get(fig, 'CurrentAxes')), s1)
% view(0,90) ;  % top view
% axis equal
% axis off
% xlabel("(a) top view");
% 
% s2 = subplot(2,2,2);
% copyobj(allchild(get(fig, 'CurrentAxes')), s2)
% view(90,0) ;  % side
% axis equal
% axis off
% xlabel("(b) left view");
% 
% s3 = subplot(2,2,3);
% copyobj(allchild(get(fig, 'CurrentAxes')), s3)
% view(0,0) ;   % front view
% axis equal
% axis off
% xlabel("(c) front view");
% 
% s4 = subplot(2,2,4);
% copyobj(allchild(get(fig, 'CurrentAxes')), s4)
% view(45,45) ; % isometric 
% axis equal
% axis off
% xlabel("(d) isometric view");
% set(fig2,'color','w');

end