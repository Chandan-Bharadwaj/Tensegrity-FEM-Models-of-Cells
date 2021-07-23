function fig = print_model_cell(nodeCoordinates,elementNodes,struts,cables,interfil,cytoStruts,cytoCables,nucleoStruts,nucleoCables,Radius_cell)
% struts/cables/interfil = [] => do not display struts/cables/interfil 
% Radius = 0 => do not display sphere
% returns the handle to the figure as variable - fig

fig = figure;
s0 = subplot(1,1,1);
X = nodeCoordinates(:,1);
Y = nodeCoordinates(:,2);
Z = nodeCoordinates(:,3);

cytonodes = unique([elementNodes(struts(cytoStruts),:) ; elementNodes(cables(cytoCables),:) ]);

hold on

colorss = { 'b' , [0.9686    0.4902    0.0667] ,  'k' , [ 0.7294         0    0.4510] , 'g' };
% colorss = { 'r' , 'b' ,   'k',  'k' , 'g' };
linWdth = [1.5 1 1.5 1 1];


for ii = cytoStruts  
   el = struts(ii);
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{1},"LineWidth",linWdth(1))
%          Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'k',1,1);
end
for ii = cytoCables 
   el = cables(ii);
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{2},"LineWidth",linWdth(2)); % 'Color',[0.85 0.5 0.5]
%          Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'b',1,1);
end

for ii = nucleoStruts  
   el = struts(ii);
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{3},"LineWidth",linWdth(3))
%          Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'k',1,1);
end
for ii = nucleoCables 
   el = cables(ii);
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{4},"LineWidth",linWdth(4)); % 'Color',[0.85 0.5 0.5]
%          Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'b',1,1);
end
% 
for el = interfil
    plot3( [X(elementNodes(el,1)),X(elementNodes(el,2))],[Y(elementNodes(el,1)),Y(elementNodes(el,2))],[Z(elementNodes(el,1)),Z(elementNodes(el,2))],'Color',colorss{5},"LineWidth",linWdth(5))
%         Cylinder_arbitrary([X(elementNodes(el,1)) Y(elementNodes(el,1)) Z(elementNodes(el,1))],[X(elementNodes(el,2)) Y(elementNodes(el,2)) Z(elementNodes(el,2))],1e-7,7,'g',1,1);
end
% pink - [1.0000    0.0745    0.6510]
% orange - [0.9686    0.4902    0.0667]
% dull orange - [0.85 0.5 0.5]
% dark purple - [ 0.7294         0    0.4510]
% bright pink - [1.0000    0.2000    0.8941]


% naming of nodes
% for el = 1:length(X)
%      scatter3(X(el),Y(el),Z(el),150,'.k')
%      hold on
% end

% for el = cytonodes
%      scatter3(X(el),Y(el),Z(el),200,'.k')
%      text(X(el),Y(el),Z(el),"  "+el,'FontSize',10)
%      hold on
% end



x_base = Radius_cell*[-1:0.25:1];
y_base = Radius_cell*[-1:0.25:1];
[X_BASE,Y_BASE] = meshgrid(x_base,y_base);
Z_BASE = X_BASE*0;
mesh(X_BASE,Y_BASE,Z_BASE,'FaceColor',[0.8000    0.8000    0.8000],'FaceAlpha',0.2,'EdgeColor','k','EdgeAlpha',0.1)

xlabel(" X axis (m)")
ylabel(" Y axis (m)")
zlabel(" Z axis (m)")

axis equal
axis off
set(fig,'color','w');


end

%%
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
% % axis off
% xlabel("(b) left view");
% 
% s3 = subplot(2,2,3);
% copyobj(allchild(get(fig, 'CurrentAxes')), s3)
% view(0,0) ;   % front view
% axis equal
% % axis off
% xlabel("(c) front view");
% 
% s4 = subplot(2,2,4);
% copyobj(allchild(get(fig, 'CurrentAxes')), s4)
% view(45,45) ; % isometric 
% axis equal
% % axis off
% xlabel("(d) isometric view");
% set(fig2,'color','w');

% grid on
% view(45,45) ; % isometric 
% view(0,0) ;   % front view
% view(0,90) ;  % top view
% view(90,0) ;  % side
