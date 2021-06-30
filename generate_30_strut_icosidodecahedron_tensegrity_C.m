function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_30_strut_icosidodecahedron_tensegrity_C(Radius,sitOnTriangle)

n_g = 6;            % no. of great cirles
n_per_g = n_g-1;    % no. of struts per great circles

nodeCoordinates = [];
elementNodes = [[1:2:2*n_per_g*n_g]' [2:2:2*n_per_g*n_g]'];     % assigning the strut elements
struts = [1:n_g*n_per_g];                                       % struts
cables = [];                                                    
interfil = [];

% directions of the 6 symmetrically oriented great circles
%  => the radial direction vertices of a dodecahedron seen from the center
r_x = [0.0000    0.7108    0.2196   -0.5750   -0.5750    0.2196];
r_y = [0.0000         0    0.6760    0.4178   -0.4178   -0.6760];
r_z = [0.7947    0.3554    0.3554    0.3554    0.3554    0.3554];
ddel = pi/48;
delta = [pi/12+ddel -pi/12-ddel -pi/12-ddel -pi/12-ddel -pi/12-ddel -pi/12-ddel ];

d = pi/5; g = sin(d/2)^2;
r = sqrt((1+3*g)/(16*g));% Radius = 0.9176;
        
l_strut = Radius/r;             % geodesic math formulation

a = 2*pi/(n_per_g);
X0 = []; Y0 = []; Z0 = [];
alpha_by2 = asin(l_strut/(2*Radius));

for ii = 1:n_per_g
    theta = ii*a;    
    X0 = [X0 Radius*cos(theta+alpha_by2) Radius*cos(theta-alpha_by2) ];
    Y0 = [Y0 Radius*sin(theta+alpha_by2) Radius*sin(theta-alpha_by2) ];
    Z0 = [Z0 0 0];    
end
e = [[1:2:2*n_per_g]' [2:2:2*n_per_g]'];

X_tens = [];
Y_tens = [];
Z_tens = [];

for nn = 1:n_g
    
    % =============== Rotate the struts of the currect great circle ==========
% ( i.e., struts in one plane )

% the rotational matrix (about the z axis)
Rz = [ cos(delta(nn)) -sin(delta(nn))   0;...
       sin(delta(nn))  cos(delta(nn))   0;...
       0                0               1];

% Rotate coodrinates P1(x,y,z)
P1 = Rz*[X0;...
         Y0;...
         Z0];
     
X1 = P1(1,:);
Y1 = P1(2,:);
Z1 = P1(3,:);

new_direction = [r_x(nn);r_y(nn);r_z(nn)];
center = [0,0,0];
[X2,Y2,Z2] = change_plane_direction(X1,Y1,Z1,center,new_direction);

X_tens = [X_tens X2];
Y_tens = [Y_tens Y2];
Z_tens = [Z_tens Z2];

end
nodeCoordinates0 = [X_tens' Y_tens' Z_tens'];

% the initial structure of nodes is framed
% this will be refined  later ( by form finding)
% element connectuons must be set before form finding 

%================================================
% form the element connection matrix
%================================================
elementNodes_with_duplicates = elementNodes;
for ii = 1:length(X_tens)
    
    l = vecnorm([ X_tens-X_tens(ii); Y_tens-Y_tens(ii); Z_tens- Z_tens(ii)]);
    [mins,ind] = mink(l,6);
    
    X4 = X_tens(ind(3:6));
    Y4 = Y_tens(ind(3:6));
    Z4 = Z_tens(ind(3:6));
    elementNodes_with_duplicates = [elementNodes_with_duplicates; [ii*[1 1 1 1]' ind(3:6)']]; 
    
end
% the above loop generates duplicate cable elements in the for: [a,b] and [b,a]
% duplicate cables(elements) are eliminated eliminated below

flag = [];                                              % a check to make note of a duplicate eleemnt (stores the row no. of that element)

for ii = 31:size(elementNodes_with_duplicates,1)         
    if ismember(ii,flag)            % if the element has been flagged
       continue 
       ii;
    end
    a = elementNodes_with_duplicates(ii,1);
    b = elementNodes_with_duplicates(ii,2); 
    % [a,b] is the current element
    [is_a_member,row_index] = ismember([b,a],elementNodes_with_duplicates,'rows');
    if is_a_member
        flag = [flag row_index];
    end
    elementNodes = [elementNodes; [a b]];         % an element goes into the nw list only if it is the 1st occourence and hasnt been flagged before
end
flag;

cables = length(struts)+[1:(4*length(X_tens))/2];   % (4*length(X_tens))/2 =>    (4 -> for each nodes | length(X_tens) -> no of nodes | /2 remove duplicate cables counts 

%================================================
% refine the node structure using form finding
%================================================
qc = -1.0812;                                    % tension coeffecien for struts of 30 strut spherica; tens (can be improved)

[nodeCoordinates1] = findform(nodeCoordinates0,elementNodes,struts,cables,qc);
rad = mean(vecnorm(nodeCoordinates1'));

nodeCoordinates1 = nodeCoordinates1*Radius/rad;

X_tens = nodeCoordinates1(:,1);
Y_tens = nodeCoordinates1(:,2);
Z_tens = nodeCoordinates1(:,3);

%================================================
% reorient
%================================================
if sitOnTriangle
    % reorient the tensegrity ot sit on 3 nodes
    V0 = [0 0 -1]'; 
    base = [1 14 44]; % nodes 1, 14 and 44 make a triangle
    A = [X_tens(base(1)) Y_tens(base(1)) Z_tens(base(1))];
    B = [X_tens(base(2)) Y_tens(base(2)) Z_tens(base(2))];
    C = [X_tens(base(3)) Y_tens(base(3)) Z_tens(base(3))];

    [X_tens Y_tens Z_tens] = Reorient(X_tens',Y_tens',Z_tens',A,B,C,V0);
end

if(size(X_tens,1) == 1)
    nodeCoordinates = [X_tens' Y_tens' Z_tens'];
elseif(size(X_tens,2) == 1)
    nodeCoordinates = [X_tens Y_tens Z_tens];
else
    disp(" error in X_tens");
end

end