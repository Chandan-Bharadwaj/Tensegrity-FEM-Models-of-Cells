function [nodeCoordinates,elementNodes,struts,cables,interfil] = generate_30_strut_icosidodecahedron_tensegrity(Radius,standOnTriangle)

struts = [1:30];                                   
cables = [31:150];                                                    
interfil = [];

nodeCoordinates = [  -0.295635431302752    -0.100739735514082 -4.46825479519311e-17 ;... 
                      0.707394616508518     -0.33615414024146     0.328208079462642 ;... 
                     -0.959355039167817     0.276576699945477     0.893909727499162 ;... 
                     -0.397725598255751   -0.0632093280177304    0.0346498200836276 ;... 
                     -0.297278590181442     0.271673536576669      1.86529880811345 ;... 
                     -0.953202554426447     0.297088627120448      1.00603890069793 ;... 
                      0.775626766308056    -0.108673220497221      1.57174054873442 ;... 
                     -0.191385978543006     0.246820197249212      1.89994862819708 ;... 
                      0.776642294343997    -0.338837280510867     0.418922486145646 ;... 
                      0.834919514716729    -0.144545356110493      1.48102614205141 ;... 
                      0.253603682947374     -0.31283580781598    0.0346498200836289 ;... 
                      0.240155071336267    -0.969114185140703     0.893909727499153 ;... 
                    -0.0625792832178354     0.780698778517451     0.328208079462644 ;... 
                      0.235060885777096    -0.205657926009911                     0 ;... 
                     -0.292279806967594     0.795334187915289      1.48102614205143 ;... 
                    -0.0948794545003481     0.842010596810758     0.418922486145654 ;... 
                     -0.118059571713384    -0.289155217971014      1.89994862819708 ;... 
                     -0.293699613492355     0.726049093726542      1.57174054873444 ;... 
                      0.219314978951482    -0.974041940645765      1.00603890069791 ;... 
                    -0.0866368891206192    -0.393287579386706      1.86529880811345 ;... 
                     -0.224521025182859    -0.917534612876421     0.621766234635893 ;... 
                      0.611680286650841    -0.719810171849643      1.27818239356117 ;... 
                     -0.806421788119626    0.0705564696482826     0.362857899546272 ;... 
                     -0.311381266657436    -0.869123825983613      0.56570164803651 ;... 
                     -0.273875049143522     0.961140909245254     0.915324494014914 ;... 
                     -0.804124492905115     0.182662106959411     0.384272666062026 ;... 
                      0.637157699078396     0.523461280243256      1.51567596213505 ;... 
                     -0.185595001144186     0.982015216541195      0.98462413418217 ;... 
                      0.667660163367662    -0.637624046260392      1.33424698016055 ;... 
                      0.689420474055949     0.424256674332626      1.53709072865079 ;... 
                      0.342107198943057    -0.733659989501017     0.362857899546273 ;... 
                       0.90837394566486      0.16489782580388     0.565701648036506 ;... 
                      -0.69543491945109    -0.717753204643643     0.915324494014907 ;... 
                      0.243872221516919    -0.787723292140826     0.384272666062022 ;... 
                      -0.77190961612737     0.290064113497079      1.51567596213506 ;... 
                     -0.757652623855446    -0.651737594076882     0.984624134182162 ;... 
                      0.218368540441509     0.897022685701443      1.33424698016056 ;... 
                     -0.712127294725118     0.384927307255226      1.53709072865081 ;... 
                      0.906868796193938     0.264326394946114     0.621766234635885 ;... 
                      0.317533751398827     0.889635753158575      1.27818239356118 ;... 
                      0.144121915308379      0.37604513583371    0.0346498200836296 ;... 
                       0.71919996783158     0.692537485195204      0.89390972749915 ;... 
                      -0.64481533329067    -0.444544638275998     0.328208079462643 ;... 
                     0.0605745455256557     0.306397661523993  -7.9435640803433e-17 ;... 
                     -0.542639707749093    -0.650788831804814      1.48102614205142 ;... 
                     -0.681762839843632      -0.5031733162999      0.41892248614565 ;... 
                      0.309445550256433    0.0423350207217822      1.89994862819708 ;... 
                     -0.481927152815661     -0.61737587322934      1.57174054873443 ;... 
                      0.733887575474999     0.676953313525295      1.00603890069791 ;... 
                      0.383915479302102     0.121614042810017      1.86529880811344 ;... 
                      0.560252271388209     0.605061185181402     0.384272666062022 ;... 
                      0.969309968594643    -0.243387704601624     0.915324494014897 ;... 
                     -0.596992679007404     0.704226000179724     0.565701648036517 ;... 
                      0.464314589176581     0.663103519852726     0.362857899546269 ;... 
                      -0.92921403804963    -0.169825581308956      1.27818239356118 ;... 
                     -0.682347771011056     0.653208217930291     0.621766234635899 ;... 
                       0.02270682066921    -0.809183981587872       1.5370907286508 ;... 
                     -0.886028703809133    -0.259398639441066      1.33424698016056 ;... 
                      0.943247624999664    -0.330277622464327     0.984624134182151 ;... 
                      0.134751917049014    -0.813525393740358      1.51567596213505 ];   

elementNodes = [ 1     2;...
                 3     4;...
                 5     6;...
                 7     8;...
                 9    10;...
                11    12;...
                13    14;...
                15    16;...
                17    18;...
                19    20;...
                21    22;...
                23    24;...
                25    26;...
                27    28;...
                29    30;...
                31    32;...
                33    34;...
                35    36;...
                37    38;...
                39    40;...
                41    42;...
                43    44;...
                45    46;...
                47    48;...
                49    50;...
                51    52;...
                53    54;...
                55    56;...
                57    58;...
                59    60;...
                 1    14;...
                 1    44;...
                 1    43;...
                 1    11;...
                 2    11;...
                 2    31;...
                 2    14;...
                 2    32;...
                 3    26;...
                 3    56;...
                 3    55;...
                 3    23;...
                 4    43;...
                 4    23;...
                 4    26;...
                 4    44;...
                 5    18;...
                 5    38;...
                 5    17;...
                 5    35;...
                 6    35;...
                 6    55;...
                 6    38;...
                 6    56;...
                 7    50;...
                 7    30;...
                 7    29;...
                 7    47;...
                 8    17;...
                 8    47;...
                 8    50;...
                 8    18;...
                 9    32;...
                 9    52;...
                 9    31;...
                 9    59;...
                10    29;...
                10    59;...
                10    52;...
                10    30;...
                11    31;...
                11    34;...
                12    21;...
                12    34;...
                12    22;...
                12    31;...
                13    41;...
                13    54;...
                13    44;...
                13    53;...
                14    44;...
                14    41;...
                15    37;...
                15    28;...
                15    25;...
                15    38;...
                16    53;...
                16    25;...
                16    54;...
                16    28;...
                17    47;...
                17    48;...
                18    38;...
                18    37;...
                19    60;...
                19    22;...
                19    21;...
                19    57;...
                20    57;...
                20    48;...
                20    47;...
                20    60;...
                21    34;...
                21    33;...
                22    60;...
                22    59;...
                23    43;...
                23    46;...
                24    33;...
                24    46;...
                24    34;...
                24    43;...
                25    53;...
                25    56;...
                26    56;...
                26    53;...
                27    49;...
                27    40;...
                27    37;...
                27    50;...
                28    37;...
                28    40;...
                29    59;...
                29    60;...
                30    50;...
                30    49;...
                32    52;...
                32    51;...
                33    46;...
                33    45;...
                35    55;...
                35    58;...
                36    45;...
                36    58;...
                36    46;...
                36    55;...
                39    51;...
                39    42;...
                39    49;...
                39    52;...
                40    49;...
                40    42;...
                41    54;...
                41    51;...
                42    51;...
                42    54;...
                45    58;...
                45    57;...
                48    57;...
                48    58];
            
nodeCoordinates0 = nodeCoordinates*Radius;  

X_tens = nodeCoordinates0(:,1);
Y_tens = nodeCoordinates0(:,2);
Z_tens = nodeCoordinates0(:,3);

pent_nodes = [36 46 23 55 3];

%================================================
% reorient
%================================================
if standOnTriangle
    % reorient the tensegrity ot sit on 3 nodes
    V0 = [0 0 -1]'; 
    base = [1 14 44]; % nodes 1, 14 and 44 make a triangle
    A = [X_tens(base(1)) Y_tens(base(1)) Z_tens(base(1))];
    B = [X_tens(base(2)) Y_tens(base(2)) Z_tens(base(2))];
    C = [X_tens(base(3)) Y_tens(base(3)) Z_tens(base(3))];

    [X_tens Y_tens Z_tens] = Reorient(X_tens',Y_tens',Z_tens',A,B,C,V0);

else
        A = [ X_tens(pent_nodes(1)) , Y_tens(pent_nodes(1)) , Z_tens(pent_nodes(1)) ];
        B = [ X_tens(pent_nodes(2)) , Y_tens(pent_nodes(2)) , Z_tens(pent_nodes(2)) ];
        C = [ X_tens(pent_nodes(3)) , Y_tens(pent_nodes(3)) , Z_tens(pent_nodes(3)) ];
        [X_tens,Y_tens,Z_tens] = Reorient(X_tens,Y_tens,Z_tens,A,B,C,[0 0 -1]);
        base_centre = [mean(X_tens(pent_nodes)) mean(Y_tens(pent_nodes)) mean(Z_tens(pent_nodes))]';
        X_tens = [X_tens'-base_centre(1)];
        Y_tens = [Y_tens'-base_centre(2)];
        Z_tens = [Z_tens'-base_centre(3)];
end

if(size(X_tens,1) == 1)
    nodeCoordinates = [X_tens' Y_tens' Z_tens'];
elseif(size(X_tens,2) == 1)
    nodeCoordinates = [X_tens Y_tens Z_tens];
else
    disp(" error in X_tens");
end

end