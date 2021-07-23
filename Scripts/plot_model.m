function fig = plot_model(nodeCoordinates,elementNodes,struts,cables,interfil,Radius)
% fig = plot_model(nodeCoordinates,elementNodes,struts,cables,interfil,Radius)
% 
% struts/cables/interfil = [] => do not display struts/cables/interfil 
% Radius = 0 => do not display sphere
% returns the handle to the figure as variable - fig

fig = figure;
X = nodeCoordinates(:,1);
Y = nodeCoordinates(:,2);
Z = nodeCoordinates(:,3);

hold on
colorss = { 'k' , 'b' , 'g' };
linWdth = [1.5 1 1];

for el = struts
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{1},"LineWidth",linWdth(1))
%          Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'k',1,1);
end
for el = cables
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{2},"LineWidth",linWdth(2)); % 'Color',[0.85 0.5 0.5]
%          Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'b',1,1);
end
for el = interfil
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{3},"LineWidth",linWdth(3))
%         Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'g',1,1);
end

% naming of nodes
for el = 1:length(X)
     scatter3(X(el),Y(el),Z(el),120,'.r')
     text(X(el),Y(el),Z(el),"  "+el,'FontSize',8)
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
axis equal
grid on
% view(45,45) ; % isometric 
% view(0,0) ;   % front view
% view(0,90) ;  % top view
% view(90,0) ;  % side

end