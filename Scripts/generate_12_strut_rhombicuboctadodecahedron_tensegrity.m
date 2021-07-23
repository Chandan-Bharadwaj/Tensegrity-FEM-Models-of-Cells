
function[nodeCoordinates,elementNodes,struts,cables,interfil] = generate_12_strut_rhombicuboctadodecahedron_tensegrity(Radius)


    
% r=0.47;
% geodesic math
% r = sqrt((1+3*g)/(16*g));
% r = 0.5;  % this wont make the tensegrity fit inside the sphere

% length_strut = Radius/r;                 % geodesic math formulation
% length_strut = 4*R/sqrt(5);       % pythagorean formaulation - seems to fit inside the sphere


%% manual calculation of r =1/f
f = 1.9660e-05/1.1379e-05;
length_strut = f*Radius;

%% coordinates

ro2 = length_strut/2;
ro1 = 0.3*ro2;
h = 0.5*ro2;

% ro1 = sqrt(1/6)*length_strut;     % "Computational modelling of tensegrity"
% ro2 = 2*ro1;

X = [ ro2 ro2 ro1 -ro1 h h -ro2 -ro2 ro1 -ro1 h h   ro2 ro2 ro1 -ro1 -h -h -ro2 -ro2 ro1 -ro1 -h -h]; % x-coordinates
Y = [ -ro1 ro1 h h -ro2 -ro2 -ro1 ro1 h h ro2 ro2   -ro1 ro1 -h -h -ro2 -ro2 -ro1 ro1 -h -h ro2 ro2]; % y-coordinates
Z = [ h h ro2 ro2 ro1 -ro1 h h -ro2 -ro2 ro1 -ro1   -h -h ro2 ro2 ro1 -ro1 -h -h -ro2 -ro2 ro1 -ro1]; % z-coordinates
% e = [1 7;2 8;3 9;4 10;5 11;6 12;1 3;1 5;1 6;1 9;2 3;2 9;2 11;2 12;3 11;3 5;4 5;4 7;4 8;4 11;5 7;6 7;6 9; 6 10;7 10;8 10;8 11;8 12;9 12;10 12];
% e = [e ; [1 7;2 8;3 9;4 10;5 11;6 12;1 3;1 5;1 6;1 9;2 3;2 9;2 11;2 12;3 11;3 5;4 5;4 7;4 8;4 11;5 7;6 7;6 9; 6 10;7 10;8 10;8 11;8 12;9 12;10 12]+12];

struts = [];
cables = [];
interfil =[];

e = [1 7;2 8;3 9;4 10;5 11;6 12; [1 7;2 8;3 9;4 10;5 11;6 12;]+12 ];
struts = [1:12];

e = [e; 1 5;5 15;15 1;2 3;3 11;11 2;6 13;13 21;21 6;9 12;12 14;14 9;10 20;20 24;24 10;4 8;8 23;23 4;7 16;16 17;17 7;18 19;19 22;22 18;...
    1 12;1 4;2 16;2 6;3 7;3 24;4 12;5 22;5 14;6 16;7 24;8 18;8 15;9 23;9 19;10 13;10 11;11 13;14 22;15 18;17 20;17 21;19 23;20 21];
cables = [13:(12+48)];

elementNodes = e;


A = [X(1) Y(1) Z(1)]';
B = [X(15) Y(15) Z(15)]';
C = [X(5) Y(5) Z(5)]';

V0 = [0 0 1];

[X,Y,Z] = Reorient(X,Y,Z,A,B,C,V0);

for i=1:size(X,2)
    nodeCoordinates(i,1)=X(i);
    nodeCoordinates(i,2)=Y(i);
    nodeCoordinates(i,3)=Z(i);
end

