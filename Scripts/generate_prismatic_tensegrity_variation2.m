function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_prismatic_tensegrity_variation2(r1,r2,h,n)
% N-plex Cylindrical Tensegrity Generator
% r1 = Radius of top nodes
% r2 = Radius of bottom nodes
% h  = height of the tensegrity
%% calculation
alpha = pi/2 - pi/n; % Shift angle
h1 = h/2;
h2 = -h/2;
%% Main
% Point coordinates

nodt = zeros(n,3);
nodb = zeros(n,3);

for ii  =  1:(n)
    nodt(ii,:) = [r1*cos(2*(n+1-ii)*pi/n + alpha/2), r1*sin(2*(n+1-ii)*pi/n + alpha/2), h1];
    nodb(ii,:) = [r2*cos(2*(n+1-(ii+n))*pi/n - alpha/2) , r2*sin(2*(n+1-(ii+n))*pi/n - alpha/2),  h2];
end

for ii = 1:n
    nodeCoordinates(ii,1) = nodb(ii,1);
    nodeCoordinates(ii,2) = nodb(ii,2);
    nodeCoordinates(ii,3) = nodb(ii,3);
    
    nodeCoordinates(ii+n,1)=nodt(ii,1);
    nodeCoordinates(ii+n,2)=nodt(ii,2);
    nodeCoordinates(ii+n,3)=nodt(ii,3);
end
% adding the CG node to build the interfilaments
% CG = [0 0 0];
% nodeCoordinates = [nodeCoordinates; CG];
   
elementNodes =  [];
cables = [];
interfil = [];

for ii=1:n
    elementNodes(ii,:) = [ii mod(ii,n)+1];          % bottom cables
    cables(ii) =  ii;

    elementNodes(ii+n,:) = [ii+n mod(ii,n)+n+1]; % top cables
    cables(ii+n) =  ii+n;

    elementNodes(ii+2*n,:) = [ii ii+n];
    cables(ii+2*n) =  ii+2*n;                      % bottom cables
    
    elementNodes(ii+3*n,:) = [ii mod(ii+n-1-1,n)+1+n];% 1+mod((ii+ne+ne-2),2*ne)
    struts(ii) =  ii+3*n;
    
end

