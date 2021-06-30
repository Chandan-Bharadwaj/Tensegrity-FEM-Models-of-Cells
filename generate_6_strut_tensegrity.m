function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_6_strut_tensegrity_on_z(Radius,spread_cell,interfil_req)
% spread_cell = 0 if spread cell config is req. 
%               (anything else if it is req.)
% interfil_req = 0 if interfilaments is not req.
%               (anything else if it is req.)
struts = [];
cables = [];
interfil = [];

r = sqrt((1+3*0.5)/(16*0.5));
length_strut = Radius/r;
ro2 = length_strut/2;
ro1 = 0.5*ro2;
X = [ ro2 ro2 ro1 -ro1 0 0 -ro2 -ro2 ro1 -ro1 0 0 ]; % x-coordinates
Y = [ -ro1 ro1 0 0 -ro2 -ro2 -ro1 ro1 0 0 ro2 ro2 ]; %y-coordinates
Z = [ 0 0 ro2 ro2 ro1 -ro1 0 0 -ro2 -ro2 ro1 -ro1 ]; %z-coordinates

A = [X(1) Y(1) Z(1)]';
B = [X(3) Y(3) Z(3)]';
C = [X(5) Y(5) Z(5)]';

V0 = [0 0 1]';

[X,Y,Z] = Reorient(X,Y,Z,A,B,C,V0);

% ------- spread cell ----------------
% bring down the floating struts vertically down (without change in x and y)
% to form the spread cm,ell configuration
% 2-8 ,4-10, 6-12 are the floating struts
if spread_cell ==1
%     
%         Y(8) = Y(8)-Y(2);
%         Y(10) = Y(10)-Y(4);
%         Y(12) = Y(12)-Y(6);
    
            % OR
 % y axis =====   
%      l1 = norm([X(8) Y(8) Z(8)] - [X(2) 0 Z(2)] );
%           X(8) = X(2) + (X(8)-X(2))*length_strut/l1;
%           Y(8) =  0   + (Y(8)- 0 )*length_strut/l1;
%           Z(8) = Z(2) + (Z(8)-Z(2))*length_strut/l1;
%      l2 = norm([X(10) Y(10) Z(10)] - [X(4) 0 Z(4)] );
%           X(10) = X(4) + (X(10)-X(4))*length_strut/l2;
%           Y(10) =  0   + (Y(10)- 0 )*length_strut/l2;
%           Z(10) = Z(4) + (Z(10)-Z(4))*length_strut/l2;
%      l3 = norm([X(12) Y(12) Z(12)] - [X(6) 0 Z(6)] );
%           X(12) = X(6) + (X(12)-X(6))*length_strut/l3;
%           Y(12) =  0   + (Y(12)- 0 )*length_strut/l3;
%           Z(12) = Z(6) + (Z(12)-Z(6))*length_strut/l3;
%    
%     Y(2) = 0;
%     Y(4) = 0;
%     Y(6) = 0;
    
      l1 = norm([X(8) Y(8) Z(8)] - [X(2) Y(2) 0] );
          Y(8) = Y(2) + (Y(8)-Y(2))*length_strut/l1;
          X(8) = X(2) + (X(8)- X(2) )*length_strut/l1;
          Z(8) = 0    + (Z(8)- 0)*length_strut/l1;
     l2 = norm([X(10) Y(10) Z(10)] - [X(4) Y(4) 0] );
          Y(10) = Y(4) + (Y(10)-Y(4))*length_strut/l1;
          X(10) = X(4) + (X(10)- X(4) )*length_strut/l1;
          Z(10) = 0    + (Z(10)- 0)*length_strut/l1;
     l3 = norm([X(12) Y(12) Z(12)] - [X(6) Y(6) 0] );
          Y(12) = Y(6) + (Y(12)- Y(6))*length_strut/l1;
          X(12) = X(6) + (X(12)- X(6) )*length_strut/l1;
          Z(12) = 0    + (Z(12)- 0)*length_strut/l1;
    
    Z(2) = 0;
    Z(4) = 0;
    Z(6) = 0;
end

elementNodes = [1 7;2 8;3 9;4 10;5 11;6 12;1 3;1 5;1 6;1 9;2 3;2 9;2 11;2 12;3 11;3 5;4 5;4 7;4 8;4 11;5 7;6 7;6 9; 6 10;7 10;8 10;8 11;8 12;9 12;10 12;];
    if interfil_req
        
        CG = [sum(X)/length(X), sum(Y)/length(Y), sum(Z)/length(Z)];
        X = [X CG(1)]; 
        Y = [Y CG(2)];     %central node
        Z = [Z CG(3)];
        
        elementNodes = [elementNodes; 1 13; 2 13; 3 13; 4 13; 5 13; 6 13; 7 13; 8 13; 9 13; 10 13; 11 13; 12 13]; %connection from central node to all other nodes
        interfil = [31:42]; % assigning interfilaments
    end

for i=1:size(X,2)
    nodeCoordinates(i,1)=X(i);
    nodeCoordinates(i,2)=Y(i);
    nodeCoordinates(i,3)=Z(i);
end

% assigning the struts, cables, 
struts = [1:6];
cables = [7:30];

end
%%




