function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_cuboctahedron_tensegrity_C(Radius,sitOnTriangle)
% Generates a 12 struts cuboctahedron tensegrity

% n_g: no. great circles
n_g = 4; 
% n_per_g: no. of struts per great circle
n_per_g = n_g-1;  % = 3 

%----------------------------------------
% initializing the nodes and element data
%----------------------------------------
nodeCoordinates = [];
% first make all the strut element connections 
elementNodes = [[1:2:2*n_per_g*n_g]' [2:2:2*n_per_g*n_g]'];
struts = [1:n_g*n_per_g];
cables = [];
interfil = [];

%-------------------------------------------
% defining the 4 direction vectors of the 4 great circles 
%------------------------------------------
% obtained from the corner % points of a regular tetrahedron
r_x  = [-1, -1, 1 ,1]/2;
r_y  = [1, -1, -1, 1]/2;
r_z  = [-1, 1, -1, 1]/2;
  
% the angles by which the struts of a greal circle are rotated witht the
% plane of the great circle
delta = [-pi/12 pi/12  pi/6+pi/12  pi/6+pi/6+pi/12 ];


%----------------------------------------
% geodesic math formulation | "Geodesic math and how to use it" - Hugh kenner
%----------------------------------------
d = pi/3;                               % dip angle pi/n ->  n = no. of sturuts per great circle
g = sin(d/2)^2;                         % gap 
r =  sqrt((1+3*g)/(16*g)); % = 0.6614;  % radius of enclosing sphere for a unit strut length
% r = 0.666;
l_strut = Radius/r;                     % strut length for the given enclosing sphere radius          

%----------------------------------------
% Orienting the Strut sets in the right way
%----------------------------------------

%initializing the node coordinate variables
X_tens = [];
Y_tens = [];
Z_tens = [];

% Creating a single set of struts (struts of a great circle)
a = 2*pi/(n_per_g);
X0 = []; Y0 = []; Z0 = [];
alpha_by2 = asin(l_strut/(2*Radius));
for ii = 1:n_per_g
    theta = ii*a;    
    X0 = [X0 Radius*cos(theta+alpha_by2) Radius*cos(theta-alpha_by2) ];
    Y0 = [Y0 Radius*sin(theta+alpha_by2) Radius*sin(theta-alpha_by2) ];
    Z0 = [Z0 0 0];
end

% append each set of struts with different orientations in space 
% the die[rection given by : r_x, r_y, r_z
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

cables = length(struts)+[1:(4*length(X_tens))/2];   % (4*length(X_tens))/2 =>    (4 -> for each nodes | length(X_tens) -> no of nodes | /2 remove duplicate cables counts

              % ## or : hardcoded cable connections ##% 
% elementNodes = [ elementNodes; 1 10; 1 9; 1 24; 1 21; 2 18; 2 17; 2 21; 2 24;...
%                 3 19; 3 20; 3 13; 3 16; 4 13; 4 16; 4 9; 4 10;...
%                 5 17; 5 18; 5 11; 5 8; 6 19; 6 20; 6 8; 6 11;...
%                 7 15; 7 16; 7 20; 7 23; 8 20; 8 23; 9 22; 9 21;...
%                 10 15; 10 16; 11 14; 11 17; 12 22; 12 21;...
%                 12 14; 12 17; 13 19; 13 22; 14 22; 14 19;...
%                 15 24; 15 23; 18 24; 18 23 ];
% cables = 12+[1:48]; 

%================================================
% refine the node structure using form finding
%================================================
qc = -1.22405;                                    % tension coeffecien for struts of 30 strut spherical tens (can be improved)

[nodeCoordinates1] = findform(nodeCoordinates0,elementNodes,struts,cables,qc);
rad = mean(vecnorm(nodeCoordinates1'));

nodeCoordinates1 = nodeCoordinates1*Radius/rad;

X_tens = nodeCoordinates1(:,1);
Y_tens = nodeCoordinates1(:,2);
Z_tens = nodeCoordinates1(:,3);


if sitOnTriangle
    % reorient the tensegrity ot sit on 3 nodes
    V0 = [0 0 -1]'; 
    base = [1 9 21];
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
 
