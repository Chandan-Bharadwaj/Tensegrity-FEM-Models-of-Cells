function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_prismatic_tensegrity(Radius,n,interfil_req)
% N-plex Cylindrical Tensegrity Generator
% Radius - radius of sphere into which it fits
% n - no. of struts
% interfil_req - 0 for no interfilaments 

%% parameters 
f = 1;
%% calculation
T1 = sqrt( 1-(f^2/4) )*2*sin(pi/n);
ln = T1*Radius ;       % length of upper and lower cable (horizontal cable)
T2 = (2-2*cos((2-n)*pi/(2*n)) )/(4*sin(pi/n)^2);
q = (f^2/T1^2 + T2 )^0.5;
ls = q*ln;      % length of strut

theta = (2+n)*pi/(2*n); % Shift angle
r1 = ln/(2*sin(pi/n)); % Radius of top nodes
r2 = r1; % Radius of bottom nodes
h = sqrt(ls^2-2*r1^2+2*r1^2*cos((2-n)/2/n*pi));
if h <= 0
disp('Increase the value of ls!!')
pause
return
end
lb = sqrt(h^2+2*r1^2-2*r1^2*cos((2+n)/2/n*pi));
h1 = h/2;
h2 = -h/2;
%% Main
phi = 2*pi/n;
% Cycler index i:1-n+1 j:1-n,1 nodes
for ii  =  1:(n)
    if mod(ii,n) == 0
        j(ii) = n;
    else
        j(ii) = mod(ii,n);
    end
end
% Point coordinates

nodt = zeros(n,3);
nodb = zeros(n,3);
for ii  =  1:(n)
    k = j(ii);
    nodt(ii,:) = [r1*cos(phi*(k-1)+theta), r1*sin(phi*(k-1)+theta), h1];
    nodb(ii,:) = [r2*cos(phi*(k-1)) , r2*sin(phi*(k-1)) ,  h2];
end
for ii = 1:n
    nodeCoordinates(ii,1)=nodb(ii,1);
    nodeCoordinates(ii,2)=nodb(ii,2);
    nodeCoordinates(ii,3)=nodb(ii,3);
    
    nodeCoordinates(ii+n,1)=nodt(ii,1);
    nodeCoordinates(ii+n,2)=nodt(ii,2);
    nodeCoordinates(ii+n,3)=nodt(ii,3);
end
% adding the CG node to build the interfilaments
if interfil_req
    CG = [0 0 0];
    nodeCoordinates = [nodeCoordinates; CG];
end
    
    
elementNodes =  [];
cables = [];
interfil = [];

for ii=1:n
    elementNodes(ii,:) = [ii mod(ii,n)+1];          % bottom cables
    cables(ii) =  ii;

    elementNodes(ii+n,:) = [ii+n mod(ii,n)+n+1]; % top cables
    cables(ii+n) =  ii+n;

     elementNodes(ii+2*n,:) = [ii mod(ii+n-1-1,n)+1+n];% 1+mod((ii+ne+ne-2),2*ne)
    cables(ii+2*n) =  ii+2*n;                      % bottom cables
    
    elementNodes(ii+3*n,:) = [ii ii+n];
    struts(ii) =  ii+3*n;
    if interfil_req
        elementNodes(ii+4*n,:) = [ii 2*n+1];
        interfil(ii) =  ii+4*n;  

        elementNodes(ii+5*n,:) = [ii+n 2*n+1 ];
        interfil(ii+n) =  ii+5*n;
    end
end



