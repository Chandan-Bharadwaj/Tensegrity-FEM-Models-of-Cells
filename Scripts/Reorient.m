function [X_new,Y_new,Z_new] = Reorient(X,Y,Z,A,B,C,V0)

if(size(X,2) == 1)
    X = X';
    Y = Y';
    Z = Z';
end

% [X_new,Y_new,Z_new] = Reorient(X,Y,Z,A,B,C,V0)
%R
% Reorient a Tensegrity (or any set of points (X,Y,Z) )
%       - to sit on the plane defined by 3 node points: A, B, C 
%       - facing the direction given by vector V0
%
% Reorientation happens by:
%   1)  translating the entire tensegrity(or any set (X, Y, Z)) 
%       such that the midpoint of nodes A, B, C lies on origin
%   2)  Rotating the translated tensegrity 
%           - about a line 
%               - Passing through point (a,b,c) (usually the origin - (0,0,0)
%               - along the direction vector (u,v,w)
%           - through a certain angle : theta 
%       such that the plane defined by nodes A, B, C now faces the direction vector V0 
%
% supporting source : https://sites.google.com/site/glennmurray/Home/rotation-matrices-and-formulas/rotation-about-an-arbitrary-axis-in-3-dimensions
       

% Direct formulation for the coordinates of the rotated set of points P(x,y,z)
% source : https://sites.google.com/site/glennmurray/Home/rotation-matrices-and-formulas/rotation-about-an-arbitrary-axis-in-3-dimensions

% obtained by rotating points (X,Y,Z) abount a line (passing through (a,b,c) and along (u,v,w)
% through an angle theta 




% ---------- translation ----------
% center of these three points to sit on origin
cent =  (A+B+C)/3;

X = X - cent(1);
Y = Y - cent(2);
Z = Z - cent(3);

% ---------- rotation -------------

a = 0;b = 0;c = 0; % aline through origin

V1 = A-B;
V2 = C-B;
Va = cross(V1,V2);

direction1 = Va/norm(Va);
direction2 = V0/norm(V0);
if isequal(direction1,direction2) || isequal(direction1,direction2')
    X_new = X;
    Y_new = Y;
    Z_new = Y;
    return
end

theta = acos( dot(Va,V0)/(norm(Va)*norm(V0)) );
Vb = cross(Va,V0);

u = Vb(1) ; v = Vb(2) ; w = Vb(3); % direction of the line

L = u^2 + v^2 + w^2;

% rotate the set of points (X,Y,Z) about a line in the direction (
P = (1/L)*[ (a*(v^2 + w^2)-u*(b*v + c*w - u*X - v*Y - w*Z))*(1-cos(theta)) + L*X*cos(theta) + sqrt(L)*(-c*v + b*w - w*Y + v*Z)*sin(theta) ;...
            (b*(u^2 + w^2)-v*(a*u + c*w - u*X - v*Y - w*Z))*(1-cos(theta)) + L*Y*cos(theta) + sqrt(L)*(c*u - a*w + w*X - u*Z)*sin(theta) ;...
            (c*(u^2 + v^2)-w*(a*u + b*v - u*X - v*Y - w*Z))*(1-cos(theta)) + L*Z*cos(theta) + sqrt(L)*(-b*u + a*w - v*X + u*Y)*sin(theta) ];
% updating the reoriented coordinates
X_new = P(1,:);
Y_new = P(2,:);
Z_new = P(3,:);
end