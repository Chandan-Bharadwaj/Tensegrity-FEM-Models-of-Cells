function [nodeCoordinates2] = findform(nodeCoordinates,elementNodes,struts,cables,qc)
% Form finding of 3D or 2D tensegrities
% outputs the new nodeCoordinates after applying the procedure of form
% finding

dim = 3; % Dimensional

X = nodeCoordinates(:,1);    
Y = nodeCoordinates(:,2);     
Z = nodeCoordinates(:,3);  
X0 = nodeCoordinates(:,1);    
Y0 = nodeCoordinates(:,2);     
Z0 = nodeCoordinates(:,3); 
numElements = size(elementNodes,1);

for ii = 1:numElements
    C(ii,elementNodes(ii,1)) = 1;
    C(ii,elementNodes(ii,2)) = -1;
end
nb = size(C,1); % number of bars nb
nn = size(C,2); % number of nodes nn

q0 =[];
q0(struts) = qc;
q0(cables) = 1;
q0 = q0';
q = q0;

nb = size(C,1); % number of bars nb
nn = size(C,2); % number of nodes nn

toll = max(max(abs([X Y Z])))*1e-5;
l_strut = vecnorm(nodeCoordinates(elementNodes(struts,1),:)' - nodeCoordinates(elementNodes(struts,2),:)');
l_strut = l_strut(1);

for iii = 1:30

D = C'*diag(q)*C;
% rd = rank(D)
[U,V] = schur(D);
L = vecnorm(C*U);
% extra_n = length(L(L<toll)) > 0 
extra_n = length(L(L<toll));
% we need 3 min, but we take extra_n more to account for 0s at the begining
[min_norm,ind] = mink(unique(L),3+extra_n); 
min3_norm = min_norm((extra_n+1):end);

% U_ = U(:,ind((extra_n+1):end));

pick_all_low = abs(L - min3_norm')<toll;
U_ = [];
for ii = 1:3
    U_ = [U_ U(:,pick_all_low(ii,:) )];
end

[Q,R] = qr(C*U_);
[ech_form,piv] = rref(R);

% xyz = U_;
x = U_(:,piv(1));
y = U_(:,piv(2));
z = U_(:,piv(3));
X = x;
Y = y;
Z = z;
 
CX = C*X; CX2 = CX.*CX;
CY = C*Y; CY2 = CY.*CY;
CZ = C*Z; CZ2 = CZ.*CZ;
for i = 1:nb
L(i) = sqrt(CX2(i)+CY2(i)+CZ2(i))*0 +1; % Lengths
end
CtCX = C'*diag(C*X./L');
CtCY = C'*diag(C*Y./L');
CtCZ = C'*diag(C*Z./L');
A = [CtCX; CtCY; CtCZ];
% m = size(A,1);
% n = size(A,2);
ra = rank(A);
[U,V,W] = svd(A);
for jj = nb-1:-1:1
    Wj = W(:,jj:end);%size(Wj);
    q_ = lsqminnorm(Wj,q0);
%     q_ = lsqr(Wj,q0);
    qj = Wj*q_;
    if isequal( q0./abs(q0),qj./abs(qj))
        q = qj;
%         break
    end   
end

 s = nb - ra;
end

nodeCoordinates2 = [X Y Z];

%  forceDensity_check = D*[X Y Z]
%  equilibriumcheck = (A*q)'

end