function [m,result] = gpt_utricularia_trap_model_fig_4_6_7_12_s3_20190722( m, varargin )
%[m,result] = gpt_utricularia_trap_model_fig_4_6_7_12_s3_20190722( m, varargin )
%   Morphogen interaction function.
%   Written at 2019-10-01 14:48:10.
%   GFtbox revision 6030, 2019-03-06 16:30.

% The user may edit any part of this function lying between lines that
% begin "%%% USER CODE" and "%%% END OF USER CODE".  Those lines themselves
% delimiters themselves must not be moved, edited, deleted, or added.

    result = [];
    if isempty(m), return; end

    setGlobals();
    
    % Handle new-style callbacks.
    if nargin > 1
        if exist('ifCallbackHandler','file')==2
            [m,result] = ifCallbackHandler( m, varargin{:} );
        end
        return;
    end

    fprintf( 1, '%s found in %s\n', mfilename(), which(mfilename()) );

    realtime = m.globalDynamicProps.currenttime;
    dt = m.globalProps.timestep;

%%% USER CODE: INITIALISATION

      % This is a code setting property of the trap.
      % For non-cell models (Figure 4, 6, 7, 12, S3, S5 and S7),
      % 'bioAsplitcells' and 'allowSplitBio' should be false.
      % For celluar models (Figure 9, 10 and 11), 
      % 'bioAsplitcells' and 'allowSplitBio' should be true.
      %  Cells should be added by GUI. (No. of cells = 63)

      m = leaf_setproperty( m, 'mingradient', 0, 'timestep', 6, 'userpolarisation',false, ...
         'bioAsplitcells', false, 'allowSplitBio',false, ...
         'bioApullin', 0.09 );   
      m = leaf_subdivide( m, 'morphogen', 'id_stalk', 'min', 0.5, 'minrellength', 8);
    
    if (Steps(m)==0) && m.globalDynamicProps.doinit
      
      % This is a code creating latitude and longitude grids on the sphare as in Figure 4 and 6. 
      % However, it is not necessary to call this on every run, as the
      % initial mesh has been saved with the cells created.
      m = leaf_makesecondlayer( m, 'mode', 'latlong','divisions', [36 18], 'subdivisions', [1 1],'plane', 'XZ' );   
      m = leaf_plotoptions( m, 'bioAemptyalpha', 0);  
        
        m.userdata.ranges.modelname.range = {
            '1_Isotropic model 1'%Figure 4A-F
            '2_Isotropic model 2'%Figure 4G-J
            '3_Isotropic model 3'%Figure 4K-N, 9E, 10E, 11A-E, S5AB and S7AB
            '4_anisotropic model 1'%Figure 6A-D
            '5_anisotropic model 2'%Figure 6E-H
            '6_anisotropic model 3'%Figure 6I-L, 9F, 10F, 11E-H, S5CD and S7CD
            '7_integrated model'%Figure 6M-P, 7F, 9AG, 10AG, 11I-L, and 12GJM
            '8_terminal model'%Figure 7D
            '9_basal model'%Figure 7E
            '10_increasing ventral thickness'%Supplemental Figure S3
            }; 
        m.userdata.ranges.modelname.index = 1;
               
    end
    m.secondlayer.averagetargetarea = 0;  
    modelname = m.userdata.ranges.modelname.range{m.userdata.ranges.modelname.index};  
    
    % This code is for setting arrows and cell colours
    m = leaf_plotoptions(m,'highgradcolor',[0,0,0],'lowgradcolor',[1,0,0]);
    m = leaf_plotoptions(m,'decorscale',1.5);
    m = leaf_plotoptions(m,'arrowthickness',1.8);
    m = leaf_plotoptions(m,'layeroffset', 0.005);
    % For the initial view (Figure 4BCGHKL and 6BFJMN), layeroffset = 0.005. 
    % For the developed view (Figure 4EIM), layeroffset = 0.05. 
    m = leaf_plotoptions(m,'arrowheadratio', 0.5);
    m = leaf_plotoptions(m,'arrowheadsize', 0.5);
    % Arrow spercity was set in GUI. 
    % For the initial view (Figure 6AEI), spercity = 0.15.
    % For the developed view (Figure 6CGKO, 12GJM, S3), spercity = 0.1. 
    m = leaf_plotoptions(m,'bioAlinecolor', [0.3 0.3 0.3]);
    % For non-cell models (Figure 4BCEGHIKLM and 6BFJMN), bioAlinecolor = [0.3 0.3 0.3].
    % For cellular models (Figure 9AEFG, 10AEFG, 11A-L, S5A-D and S7A-D) bioAlinecolor = [0.8 0.8 0.8]
    
    
    % This code is for cellular anisotropic line used in Figure 10AEFG and
    % S7A-D. For these models, 'drawcellaniso' is true.
    m = leaf_plotoptions( m, 'drawcellaniso', false, 'cellanisowidth', 3.0, 'cellanisothreshold', 0.45, 'cellanisocolor', 'k');
    
    % This code is for cell color scaling used in Figuer 9AEFG, 10AEFG,
    % S5A-E and S7A-E.
    m = leaf_setcellcolorinfo( m,...
        'factor', 'c_aniso', ...
        'mode', 'custom', ...
        'colors', jet(), ...
        'autorange', false, ...
        'range', [0 1]);
    m = leaf_setcellcolorinfo( m,...
        'factor', 'c_area', ...
        'mode', 'custom', ...
        'colors', jet(), ...
        'autorange', false, ...
        'range', [3.219 7.824]);
    
    % This code is for making mouth region white as in Figure 9AEFG,
    % 10AEFG, and 11A-L, S5A-D and S7A-D.
    mymap = [0 1 1];
    m = leaf_setcellcolorinfo( m,...
        'factor', 'c_mouth', ...
        'mode', 'custom', ...
        'colors', colormap(mymap), ...
        'autorange', false, ...
        'range', [0.01 0.015]);
    
    % This code is for making clones as in Fig 11A-L
    m = leaf_setcellcolorinfo( m,...
         'factor', 'c_rand', ... 
         'autorange', false, ...
         'range', [0.8 1.0]);
    
    % This code is for cell multiplot. Choose one and comment out others
  % m = leaf_plotoptions( m, 'cellbodyvalue', { 'C_aniso', 'C_mouth'} );
  % m = leaf_plotpriority( m, { 'C_aniso', 'C_mouth' }, [0 1], 0, 'type', 'cellvalue');
  % m = leaf_plotoptions( m, 'cellbodyvalue', { 'C_area', 'C_mouth'} );
  % m = leaf_plotpriority( m, { 'C_area', 'C_mouth' }, [0 1], 0, 'type', 'cellvalue');
  % m = leaf_plotoptions( m, 'cellbodyvalue', { 'C_rand', 'C_mouth'} );
  % m = leaf_plotpriority( m, { 'C_rand', 'C_mouth' }, [0 1], 0, 'type', 'cellvalue');
%%% END OF USER CODE: INITIALISATION

%%% SECTION 1: ACCESSING MORPHOGENS AND TIME.
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.

% Each call of getMgenLevels below returns four results:
% XXX_i is the index of the morphogen called XXX.
% XXX_p is the vector of all of its values.
% XXX_a is its mutation level.
% XXX_l is the "effective" level of the morphogen, i.e. XXX_p*XXX_a.
% In SECTION 3 of the automatically generated code, all of the XXX_p values
% will be copied back into the mesh.

    polariser_i = FindMorphogenRole( m, 'POLARISER' );
    P = m.morphogens(:,polariser_i);
    [kapar_i,kapar_p,kapar_a,kapar_l] = getMgenLevels( m, 'KAPAR' );  %#ok<ASGLU>
    [kaper_i,kaper_p,kaper_a,kaper_l] = getMgenLevels( m, 'KAPER' );  %#ok<ASGLU>
    [kbpar_i,kbpar_p,kbpar_a,kbpar_l] = getMgenLevels( m, 'KBPAR' );  %#ok<ASGLU>
    [kbper_i,kbper_p,kbper_a,kbper_l] = getMgenLevels( m, 'KBPER' );  %#ok<ASGLU>
    [knor_i,knor_p,knor_a,knor_l] = getMgenLevels( m, 'KNOR' );  %#ok<ASGLU>
    [strainret_i,strainret_p,strainret_a,strainret_l] = getMgenLevels( m, 'STRAINRET' );  %#ok<ASGLU>
    [arrest_i,arrest_p,arrest_a,arrest_l] = getMgenLevels( m, 'ARREST' );  %#ok<ASGLU>
    [id_centstalk_i,id_centstalk_p,id_centstalk_a,id_centstalk_l] = getMgenLevels( m, 'ID_CENTSTALK' );  %#ok<ASGLU>
    [id_areathresh_i,id_areathresh_p,id_areathresh_a,id_areathresh_l] = getMgenLevels( m, 'ID_AREATHRESH' );  %#ok<ASGLU>
    [id_com_i,id_com_p,id_com_a,id_com_l] = getMgenLevels( m, 'ID_COM' );  %#ok<ASGLU>
    [id_stalk_i,id_stalk_p,id_stalk_a,id_stalk_l] = getMgenLevels( m, 'ID_STALK' );  %#ok<ASGLU>
    [id_midline_i,id_midline_p,id_midline_a,id_midline_l] = getMgenLevels( m, 'ID_MIDLINE' );  %#ok<ASGLU>
    [s_celldivthresh_i,s_celldivthresh_p,s_celldivthresh_a,s_celldivthresh_l] = getMgenLevels( m, 'S_CELLDIVTHRESH' );  %#ok<ASGLU>
    [s_midline_i,s_midline_p,s_midline_a,s_midline_l] = getMgenLevels( m, 'S_MIDLINE' );  %#ok<ASGLU>
    [id_dorsalmidline_i,id_dorsalmidline_p,id_dorsalmidline_a,id_dorsalmidline_l] = getMgenLevels( m, 'ID_DORSALMIDLINE' );  %#ok<ASGLU>
    [v_background_i,v_background_p,v_background_a,v_background_l] = getMgenLevels( m, 'V_BACKGROUND' );  %#ok<ASGLU>
    [s_dorsalmidline_i,s_dorsalmidline_p,s_dorsalmidline_a,s_dorsalmidline_l] = getMgenLevels( m, 'S_DORSALMIDLINE' );  %#ok<ASGLU>
    [id_ventral_i,id_ventral_p,id_ventral_a,id_ventral_l] = getMgenLevels( m, 'ID_VENTRAL' );  %#ok<ASGLU>
    [id_dorsal_i,id_dorsal_p,id_dorsal_a,id_dorsal_l] = getMgenLevels( m, 'ID_DORSAL' );  %#ok<ASGLU>
    [s_ventralmidline_i,s_ventralmidline_p,s_ventralmidline_a,s_ventralmidline_l] = getMgenLevels( m, 'S_VENTRALMIDLINE' );  %#ok<ASGLU>
    [id_rightleft_i,id_rightleft_p,id_rightleft_a,id_rightleft_l] = getMgenLevels( m, 'ID_RIGHTLEFT' );  %#ok<ASGLU>
    [id_topbottom_i,id_topbottom_p,id_topbottom_a,id_topbottom_l] = getMgenLevels( m, 'ID_TOPBOTTOM' );  %#ok<ASGLU>
    [id_frontback_i,id_frontback_p,id_frontback_a,id_frontback_l] = getMgenLevels( m, 'ID_FRONTBACK' );  %#ok<ASGLU>
    [id_ventralmidline_i,id_ventralmidline_p,id_ventralmidline_a,id_ventralmidline_l] = getMgenLevels( m, 'ID_VENTRALMIDLINE' );  %#ok<ASGLU>
    [v_karea_i,v_karea_p,v_karea_a,v_karea_l] = getMgenLevels( m, 'V_KAREA' );  %#ok<ASGLU>
    [id_centrestripmouth_i,id_centrestripmouth_p,id_centrestripmouth_a,id_centrestripmouth_l] = getMgenLevels( m, 'ID_CENTRESTRIPMOUTH' );  %#ok<ASGLU>
    [v_ventralmidline_i,v_ventralmidline_p,v_ventralmidline_a,v_ventralmidline_l] = getMgenLevels( m, 'V_VENTRALMIDLINE' );  %#ok<ASGLU>
    [v_dorsalmidline_i,v_dorsalmidline_p,v_dorsalmidline_a,v_dorsalmidline_l] = getMgenLevels( m, 'V_DORSALMIDLINE' );  %#ok<ASGLU>
    [v_specificaniso2_i,v_specificaniso2_p,v_specificaniso2_a,v_specificaniso2_l] = getMgenLevels( m, 'V_SPECIFICANISO2' );  %#ok<ASGLU>
    [id_bottomtop_i,id_bottomtop_p,id_bottomtop_a,id_bottomtop_l] = getMgenLevels( m, 'ID_BOTTOMTOP' );  %#ok<ASGLU>
    [c_mouth_i,c_mouth] = getCellFactorLevels( m, 'c_mouth' );
    [c_area_i,c_area] = getCellFactorLevels( m, 'c_area' );
    [c_stalk_i,c_stalk] = getCellFactorLevels( m, 'c_stalk' );
    [c_chin_i,c_chin] = getCellFactorLevels( m, 'c_chin' );
    [c_dorsalmidline_i,c_dorsalmidline] = getCellFactorLevels( m, 'c_dorsalmidline' );
    [c_background_i,c_background] = getCellFactorLevels( m, 'c_background' );
    [c_rand_i,c_rand] = getCellFactorLevels( m, 'c_rand' );
    [c_aniso_i,c_aniso] = getCellFactorLevels( m, 'c_aniso' );

% Mesh type: icosahedron
%             new: 1
%          radius: 18.75
%      randomness: 1
%      refinement: 3
%       thickness: 25

%            Morphogen    Diffusion   Decay   Dilution   Mutant
%            --------------------------------------------------
%                KAPAR         ----    ----       ----     ----
%                KAPER         ----    ----       ----     ----
%                KBPAR         ----    ----       ----     ----
%                KBPER         ----    ----       ----     ----
%                 KNOR         ----    ----       ----     ----
%            POLARISER         ----    ----       ----     ----
%            STRAINRET         ----    ----       ----     ----
%               ARREST         ----    ----       ----     ----
%         ID_CENTSTALK         ----    ----       ----     ----
%        ID_AREATHRESH         ----    ----       ----     ----
%               ID_COM         ----    ----       ----     ----
%             ID_STALK         ----    ----       ----     ----
%           ID_MIDLINE         ----    ----       ----     ----
%      S_CELLDIVTHRESH         ----    ----       ----     ----
%            S_MIDLINE         ----    ----       ----     ----
%     ID_DORSALMIDLINE         ----    ----       ----     ----
%         V_BACKGROUND         ----    ----       ----     ----
%      S_DORSALMIDLINE         ----    ----       ----     ----
%           ID_VENTRAL         ----    ----       ----     ----
%            ID_DORSAL         ----    ----       ----     ----
%     S_VENTRALMIDLINE         ----    ----       ----     ----
%         ID_RIGHTLEFT         ----    ----       ----     ----
%         ID_TOPBOTTOM         ----    ----       ----     ----
%         ID_FRONTBACK         ----    ----       ----     ----
%    ID_VENTRALMIDLINE         ----    ----       ----     ----
%              V_KAREA         ----    ----       ----     ----
%  ID_CENTRESTRIPMOUTH         ----    ----       ----     ----
%     V_VENTRALMIDLINE         ----    ----       ----     ----
%      V_DORSALMIDLINE         ----    ----       ----     ----
%     V_SPECIFICANISO2         ----    ----       ----     ----
%         ID_BOTTOMTOP         ----    ----       ----     ----


%%% USER CODE: MORPHOGEN INTERACTIONS
    
    % This model start from 48hrs (2DAI). 
    % In pre-growth phase from 48hrs to 72hrs, trap grows isotropically. 
    % This phase is added to modify cell shape in actual growth start. (cell setting)
    % In pre-growth phase from 72hrs to 96hrs, trap does not grow.
    % This phase is added for morphogen setting (diffusing).(morphogen setting)
    % Growth phase is from 96hrs (4DAI) to 252hrs(10.5DAI).
    % Currently each time step is 6hrs.
    % Run from 48hrs to 252hrs = 34 steps.
    % To 10.5DAI, run 34 steps.

    
    if (Steps(m)==0) && m.globalDynamicProps.doinit
        % Pre-growth phase (Cell setting)
        kapar_p(:) = 0.030;
        kaper_p(:) = kapar_p;
        kbpar_p(:) = kapar_p;
        kbper_p(:) = kapar_p;
        knor_p(:)  = 0.1;
        
        id_com_p(:) = 1; 
        CELL_AREA_AT_DIVISION = 70;
        s_celldivthresh_p(:) = CELL_AREA_AT_DIVISION;
        
    elseif realtime == 72
         % Pre-growth phase (Morphogen setting)      
         kapar_p(:) = 0.00;
         kaper_p(:) = kapar_p;
         kbpar_p(:) = kapar_p;
         kbper_p(:) = kapar_p;
         knor_p(:) = 0;
         
       
        %ID_CENTRESTRIPMOUTH
        % This is a region for mouth centre
        id_centrestripmouth_p(:) = 0;
        radius = 36.34;% Radius of sphare
        theta_centrestripmouth = 328.5; % (323.5 + 333.5) / 2
        rtheta_centrestripmouth = theta_centrestripmouth / 180*pi; % radian degree
        id_centrestripmouth_p((m.nodes (:, 1) > 0) &...
           (m.nodes (:, 2) <= sin(rtheta_centrestripmouth + 0.06)*radius) &...
           (m.nodes (:, 2) >= sin(rtheta_centrestripmouth  )*radius) &...
           (m.nodes (:, 3) < 18) & (m.nodes(:, 3) > -18)) = 1;
       
       
        %ID_MIDLINE
        id_midline_p (:) = 0;
        id_midline_p ((m.nodes (:,3) > -2) & (m.nodes(:,3) < 2))= 1;
        
        %ID_CENTSTALK
        %Centstalk is at the bottom of sphere
        %cut by plane parallel to x-z plane
        %the position of center of stalk is 270 degree (from view +Z axis)
        %= bottom of sphere = theta1
        %1/2 corn angle = theta2
        %centstalk definition: cut circle by a linear line (y = ax + b)
        % a = 1/tan(centre degree) 
        % this line goes through a point [x, y] = 
        %[(cos(theta1)*cos(theta2)),(cos(theta1)*sin(theta2))]
        
        theta_centstalk = 270;%input center angle 
        rtheta_centstalk = theta_centstalk/180*pi;%radian degree
        theta2_centstalk = 1;%input 1/2 corn angle (just smaller degree than stalk region)
        rtheta2_centstalk = theta2_centstalk/180*pi;%radian degree
        radius = 36.34;%input radius of sphare
        C_centstalk = m.nodes(:,2)- (cos(rtheta2_centstalk)*sin(rtheta_centstalk)*radius) ...
            + (1/tan(rtheta_centstalk))*(m.nodes(:,1)-cos(rtheta2_centstalk)*cos(rtheta_centstalk)*radius) ;
        id_centstalk_p(C_centstalk <= 0) = 1;
        
        
        %STK (ID_STALK)
        %Stalk is at the bottom of the sphere
        %Angles are based on Karen's measurements
        %stalk centre angle = 270 degree (from view +Z axis)
        %stalk angle = 55 (1/2 corn angle = 27.5)
        %stalk definition: cut circle by a linear line (y = ax + b)
        %same as centstalk
        
        id_stalk_p(:) = 0;
        theta_stalk = 270;%input center angle (from view +Z axis)
        rtheta_stalk = theta_stalk/180*pi;%radian degree
        theta2_stalk = 27.5;%input 1/2 stalk width angle, equal to 1/2 corn angle
        rtheta2_stalk = theta2_stalk/180*pi;%radian degree
        radius = 36.34;%input radius of sphare
        C_stalk = m.nodes(:,2)- (sin((rtheta_stalk)+(rtheta2_stalk))*radius) ...
            + (1/tan(rtheta_stalk))*(m.nodes(:,1)-cos((rtheta_stalk)+(rtheta2_stalk))*radius) ;
        id_stalk_p(C_stalk <= 0) = 1;
                            
        
       %VENTRAL REGION
        id_ventral_p(:) = 0;
        ventral_bottom = 270;
        ventral_top = 328.5;
        rventral_bottom = ventral_bottom/180*pi;
        rventral_top = ventral_top/180*pi;
        id_ventral_p((m.nodes (:,1) > 0)&(m.nodes (:,2) < tan(rventral_top).* m.nodes(:,1)))=1;

        
       %DORSAL REGION
        %NOT ventral
        id_dorsal_p(~(id_ventral_p(:)))= 1;
        
      
       %BACKGROUND
        v_background_p (:) = 1;
             
    
    %% set up s_midline diffusable factor from id_midline -- s_midline diffuses from id_midline and creates a gradient
        s_midline_p = id_midline_p;
        m.morphogenclamp((id_midline_p==1), s_midline_i ) = 1; % midline is producing
   
        m = leaf_mgen_conductivity( m, 'S_MIDLINE', 1);  % specifies the diffusion rate of s_midline across the tissue from id_midline. 
        m = leaf_mgen_absorption( m, 'S_MIDLINE', 0.0001 );  % specifies degradation rate of s_midline across the whole tissue
   
   %% Making cell clones (for 40% of all cells for Figure 11A-L)
       %Add random values to all cells in GUI. Then call to make 40% cells display.
       %Comment out before run.
       %c_rand(:) = (max(0.6, c_rand(:))-0.6).*2.5;        
   
   %% @@PRN Polariser Regulatory Network
    
    switch modelname
        case {
             '1_Isotropic model 1'
             '2_Isotropic model 2'
             '3_Isotropic model 3'
             '4_anisotropic model 1'
             '5_anisotropic model 2'
             '6_anisotropic model 3'
             '7_integrated model'
             '8_terminal model'
             '9_basal model'
             '10_increasing ventral thickness'
            }
              
            P(:) = 0.1;
            P(id_centstalk_p == 1) = 1; % + organiser
            P(id_centrestripmouth_p == 1) = 0; % - organiser
            
            m.morphogenclamp(((id_centrestripmouth_p==1)|(id_centstalk_p==1)), polariser_i ) = 1;
            
            m = leaf_mgen_conductivity( m, 'POLARISER', 10 ); % specifies the diffusion rate of polariser across the tissue from the + organiser. 
            m = leaf_mgen_absorption( m, 'POLARISER', 0.0001 );% specifies degradation rate of polariser across the whole tissue
   
       otherwise
    end
    
    
    
   elseif (realtime > 72)&(realtime < 96)
   %% set up MID (midline diffuse except for the stalk)
     id_midline_p = s_midline_p.*(id_stalk_p == 0);
     
    
   %% set up VEN (id_ventralmidline from s_midline)         
     id_ventralmidline_p = s_midline_p.*((id_ventral_p == 1)&(id_stalk_p == 0));
    
   %% visualising factors for making Figure 
     v_dorsalmidline_p = id_midline_p.*id_dorsal_p;
     v_ventralmidline_p (id_ventralmidline_p > 0.01) = 1;

    elseif abs (realtime - 96) < 0.01 
        %Growth starts
        %fixing patern of polariser at this timepoint 
        m = leaf_mgen_conductivity( m, 'POLARISER', 0 );
        m = leaf_mgen_absorption( m, 'POLARISER', 0 );
        
        m = leaf_mgen_conductivity( m, 'S_MIDLINE', 0 );
        m = leaf_mgen_absorption( m, 'S_MIDLINE', 0 );

   %% Setting cell division threshold
        id_com_p = 1; 
        CELL_AREA_AT_DIVISION = 70;
        s_celldivthresh_p(:) = CELL_AREA_AT_DIVISION;

   %% Growth Regulatory Network
        
     switch modelname
        case '1_Isotropic model 1'%Figure 4A-F
            %Isotoropic growth from phere to flattend disc
            kapar_p(:) = 0.0145...
                         .*pro (0.165, s_midline_p);
            kaper_p(:) = kapar_p;             
            kbpar_p(:) = kapar_p;
            kbper_p(:) = kaper_p;
            knor_p(:)  = 0.005;
            
            %For Figure 4C
            v_karea_p(:) = kapar_p + kaper_p;

       case '2_Isotropic model 2'%Figure 4G-J
           %Isotoropic with midline and stalk           
            kapar_p(:) = 0.0145...
                         .*pro (0.165, s_midline_p)...
                         .*inh (1.4, id_stalk_p);   
            kaper_p(:) = kapar_p;                                 
            kbpar_p(:) = kapar_p;
            kbper_p(:) = kaper_p;
            knor_p(:)  = 0.005;
            
            %For Figure 4H
            v_karea_p(:) = kapar_p + kaper_p; 
            
        case '3_Isotropic model 3'%Figure 4K-N, 9E, 10E, 11A-E, S5AB and S7AB
        
            kapar_p(:) = 0.0145...
                         .*pro (0.165, s_midline_p)...
                         .*inh (1.4, id_stalk_p)...
                         .*pro (0.2, id_ventralmidline_p);             
            kaper_p(:) = kapar_p;        
            kbpar_p(:) = kapar_p; 
            kbper_p(:) = kaper_p;
            knor_p(:)  = 0.005;
            
            %For Figure 4L
            v_karea_p(:) = kapar_p + kaper_p;
                 
        case '4_anisotropic model 1'%Figure 6A-D
            kapar_p(:) = 0.015...
                         .*pro (0.35, s_midline_p);
            kapar_p(:) = min(0.03, kapar_p);
            kaper_p(:) = 0.03 - kapar_p;            
            kbpar_p(:) = kapar_p;
            kbper_p(:) = kaper_p;            
            knor_p(:)  = 0.005;
            
            %For Figure 6B
            v_specificaniso2_p(:) = (kapar_p - kaper_p)./(kapar_p + kaper_p);
            

        case '5_anisotropic model 2'%Figure 6E-H
            kapar_p(:) = 0.015...
                         .*pro (0.35, s_midline_p)...
                         .*inh(1.5, id_stalk_p);
            kapar_p(:) = min(0.03, kapar_p);
            kaper_p(:) = 0.03 - kapar_p;            
            kbpar_p(:) = kapar_p; 
            kbper_p(:) = kaper_p; 
            knor_p(:)  = 0.005;
            
            %For Figure 6F
            v_specificaniso2_p(:) = (kapar_p - kaper_p)./(kapar_p + kaper_p);
            
        case '6_anisotropic model 3'%Figure 6I-L, 9F, 10F, 11E-H, S5CD and S7CD
            kapar_p(:) = 0.015...
                         .*pro (0.35, s_midline_p)...
                         .*pro (0.5, id_ventralmidline_p)...
                         .*inh(1.5, id_stalk_p);
            kapar_p(:) = min(0.03, kapar_p);
            kaper_p(:) = 0.03 - kapar_p;            
            kbpar_p(:) = kapar_p; 
            kbper_p(:) = kaper_p; 
            
            knor_p(:)  = 0.005;
            
            %For Figure 6J
            v_specificaniso2_p(:) = (kapar_p - kaper_p)./(kapar_p + kaper_p);
        

        case '7_integrated model'%Figure 6M-P, 7F, 9AG, 10AG, 11I-L and 12GJM 
          
           kapar_p(:) = 0.015...
                         .*pro (0.35, s_midline_p )...
                         .*pro (0.5, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kaper_p(:) = 0.015...
                         .*inh (0.8, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kbpar_p(:) = kapar_p;
           kbper_p(:) = kaper_p;
           knor_p(:)  = 0.005;
          
           %For Figure 6M
           v_karea_p(:) = kapar_p + kaper_p;
           
           %For Figure 6N
           v_specificaniso2_p(:) = (kapar_p - kaper_p)./(kapar_p + kaper_p);
           
         case '8_terminal model'%Figure 7
          
           kapar_p(:) = 0.015...
                         .*pro (0.05, s_midline_p )...
                         .*pro (1.25, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kaper_p(:) = 0.015...
                         .*inh (0.8, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kbpar_p(:) = kapar_p;
           kbper_p(:) = kaper_p;
           knor_p(:)  = 0.005;

        case '9_basal model'%Figure 7
          
           kapar_p(:) = 0.015...
                         .*pro (0.45, s_midline_p )...
                         .*pro (0.1, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kaper_p(:) = 0.015...
                         .*inh (0.8, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kbpar_p(:) = kapar_p;
           kbper_p(:) = kaper_p;
           knor_p(:)  = 0.005;
          

        case '10_increasing ventral thickness'%Supplemental Figure S3
          
           kapar_p(:) = 0.015...
                         .*pro (0.35, s_midline_p )...
                         .*pro (0.5, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kaper_p(:) = 0.015...
                         .*inh (0.8, id_ventralmidline_p > 0.01)...
                         .*inh(1.5, id_stalk_p);
           kbpar_p(:) = kapar_p;
           kbper_p(:) = kaper_p;
           knor_p(:)  = 0.005.*pro(0.5, id_stalk_p).*pro(0.5, id_ventralmidline_p > 0.01);
       
           
    end
    end   
     
    %% Cell division stop
     if (realtime >= 96)
     arrest_p(id_stalk_p(:) > 0) = 1; 
     end

     if (realtime >= 156)
     arrest_p(:) = 1; 
     end
          
    %% Making a clipping plane for Figure 4AJN, 6HLP, 7DEF, 12GJM and S3
     if (realtime >= 252) 
      % For the developed view (Figure 4JN, 6HLP, 7DEF, 12GJM and S3), realtime >= 252.
      % For the initial view (Figure 4A), realtime >= 96
            
            id_rightleft_p(m.nodes (:,3) <= 0) = 1;
            id_topbottom_p(m.nodes (:,2) <= 0) = 1;
            id_frontback_p(m.nodes (:,1) <= 0) = 1;
            id_bottomtop_p(m.nodes (:,2) >= 0) = 1;
            
     end
     
   
  %% Displaying Mouth
          c_mouth(:) = FEvertexToCell(m, id_centrestripmouth_p);
          c_mouth(:) = ceil(c_mouth(:));
%%% END OF USER CODE: MORPHOGEN INTERACTIONS

%%% SECTION 3: INSTALLING MODIFIED VALUES BACK INTO MESH STRUCTURE
%%% AUTOMATICALLY GENERATED CODE: DO NOT EDIT.
    m.morphogens(:,polariser_i) = P;
    m.morphogens(:,kapar_i) = kapar_p;
    m.morphogens(:,kaper_i) = kaper_p;
    m.morphogens(:,kbpar_i) = kbpar_p;
    m.morphogens(:,kbper_i) = kbper_p;
    m.morphogens(:,knor_i) = knor_p;
    m.morphogens(:,strainret_i) = strainret_p;
    m.morphogens(:,arrest_i) = arrest_p;
    m.morphogens(:,id_centstalk_i) = id_centstalk_p;
    m.morphogens(:,id_areathresh_i) = id_areathresh_p;
    m.morphogens(:,id_com_i) = id_com_p;
    m.morphogens(:,id_stalk_i) = id_stalk_p;
    m.morphogens(:,id_midline_i) = id_midline_p;
    m.morphogens(:,s_celldivthresh_i) = s_celldivthresh_p;
    m.morphogens(:,s_midline_i) = s_midline_p;
    m.morphogens(:,id_dorsalmidline_i) = id_dorsalmidline_p;
    m.morphogens(:,v_background_i) = v_background_p;
    m.morphogens(:,s_dorsalmidline_i) = s_dorsalmidline_p;
    m.morphogens(:,id_ventral_i) = id_ventral_p;
    m.morphogens(:,id_dorsal_i) = id_dorsal_p;
    m.morphogens(:,s_ventralmidline_i) = s_ventralmidline_p;
    m.morphogens(:,id_rightleft_i) = id_rightleft_p;
    m.morphogens(:,id_topbottom_i) = id_topbottom_p;
    m.morphogens(:,id_frontback_i) = id_frontback_p;
    m.morphogens(:,id_ventralmidline_i) = id_ventralmidline_p;
    m.morphogens(:,v_karea_i) = v_karea_p;
    m.morphogens(:,id_centrestripmouth_i) = id_centrestripmouth_p;
    m.morphogens(:,v_ventralmidline_i) = v_ventralmidline_p;
    m.morphogens(:,v_dorsalmidline_i) = v_dorsalmidline_p;
    m.morphogens(:,v_specificaniso2_i) = v_specificaniso2_p;
    m.morphogens(:,id_bottomtop_i) = id_bottomtop_p;
    m.secondlayer.cellvalues(:,c_mouth_i) = c_mouth(:);
    m.secondlayer.cellvalues(:,c_area_i) = c_area(:);
    m.secondlayer.cellvalues(:,c_stalk_i) = c_stalk(:);
    m.secondlayer.cellvalues(:,c_chin_i) = c_chin(:);
    m.secondlayer.cellvalues(:,c_dorsalmidline_i) = c_dorsalmidline(:);
    m.secondlayer.cellvalues(:,c_background_i) = c_background(:);
    m.secondlayer.cellvalues(:,c_rand_i) = c_rand(:);
    m.secondlayer.cellvalues(:,c_aniso_i) = c_aniso(:);

%%% USER CODE: FINALISATION

% In this section you may modify the mesh in any way whatsoever.
%%% END OF USER CODE: FINALISATION

end

function [m,result] = ifCallbackHandler( m, fn, varargin )
    result = [];
    if exist(fn,'file') ~= 2
        return;
    end
    [m,result] = feval( fn, m, varargin{:} );
end


%%% USER CODE: SUBFUNCTIONS

function m = local_setproperties( m )
% This function is called at time zero in the INITIALISATION section of the
% interaction function.  It provides commands to set each of the properties
% that are contained in m.globalProps.  Uncomment whichever ones you would
% like to set yourself, and put in whatever value you want.
% 
% Some of these properties are for internal use only and should never be
% set by the user.  At some point these will be moved into a different
% component of m, but for the present, just don't change anything unless
% you know what it is you're changing.
% 
%    m = leaf_setproperty( m, 'trinodesvalid', true );
%    m = leaf_setproperty( m, 'prismnodesvalid', true );
%    m = leaf_setproperty( m, 'thresholdsq', 142.153519 );
%    m = leaf_setproperty( m, 'lengthscale', 48.000000 );
%    m = leaf_setproperty( m, 'initialArea', 7134.057832 );
%    m = leaf_setproperty( m, 'bendunitlength', 84.463352 );
%    m = leaf_setproperty( m, 'thicknessRelative', 0.100000 );
%    m = leaf_setproperty( m, 'thicknessArea', 1.000000 );
%    m = leaf_setproperty( m, 'hybridMesh', false );
%    m = leaf_setproperty( m, 'thicknessMode', 'direct' );
%    m = leaf_setproperty( m, 'activeGrowth', 1.000000 );
%    m = leaf_setproperty( m, 'displayedGrowth', 1.000000 );
%    m = leaf_setproperty( m, 'displayedMulti', [] );
%    m = leaf_setproperty( m, 'allowNegativeGrowth', true );
%    m = leaf_setproperty( m, 'usePrevDispAsEstimate', true );
%    m = leaf_setproperty( m, 'perturbInitGrowthEstimate', 0.000010 );
%    m = leaf_setproperty( m, 'perturbRelGrowthEstimate', 0.010000 );
%    m = leaf_setproperty( m, 'perturbDiffusionEstimate', 0.000100 );
%    m = leaf_setproperty( m, 'resetRand', false );
%    m = leaf_setproperty( m, 'mingradient', 0.000000 );
%    m = leaf_setproperty( m, 'relativepolgrad', false );
%    m = leaf_setproperty( m, 'usefrozengradient', true );
%    m = leaf_setproperty( m, 'userpolarisation', false );
%    m = leaf_setproperty( m, 'twosidedpolarisation', false );
%    m = leaf_setproperty( m, 'splitmargin', 1.400000 );
%    m = leaf_setproperty( m, 'splitmorphogen', '' );
%    m = leaf_setproperty( m, 'thresholdmgen', 0.500000 );
%    m = leaf_setproperty( m, 'bulkmodulus', 1.000000 );
%    m = leaf_setproperty( m, 'unitbulkmodulus', true );
%    m = leaf_setproperty( m, 'poissonsRatio', 0.300000 );
%    m = leaf_setproperty( m, 'starttime', 0.000000 );
%    m = leaf_setproperty( m, 'timestep', 0.010000 );
%    m = leaf_setproperty( m, 'timeunitname', '' );
%    m = leaf_setproperty( m, 'distunitname', 'mm' );
%    m = leaf_setproperty( m, 'scalebarvalue', 0.000000 );
%    m = leaf_setproperty( m, 'validateMesh', true );
%    m = leaf_setproperty( m, 'rectifyverticals', false );
%    m = leaf_setproperty( m, 'allowSplitLongFEM', true );
%    m = leaf_setproperty( m, 'allowSplitThinFEM', false );
%    m = leaf_setproperty( m, 'splitthinness', 10.000000 );
%    m = leaf_setproperty( m, 'longSplitThresholdPower', 0.000000 );
%    m = leaf_setproperty( m, 'allowSplitBentFEM', false );
%    m = leaf_setproperty( m, 'allowSplitBio', true );
%    m = leaf_setproperty( m, 'allowFlipEdges', false );
%    m = leaf_setproperty( m, 'allowElideEdges', true );
%    m = leaf_setproperty( m, 'mincellangle', 0.200000 );
%    m = leaf_setproperty( m, 'mincellrelarea', 0.040000 );
%    m = leaf_setproperty( m, 'maxFEratio', 10.000000 );
%    m = leaf_setproperty( m, 'alwaysFlat', 0.000000 );
%    m = leaf_setproperty( m, 'flattenforceconvex', true );
%    m = leaf_setproperty( m, 'flatten', false );
%    m = leaf_setproperty( m, 'flattenratio', 1.000000 );
%    m = leaf_setproperty( m, 'useGrowthTensors', false );
%    m = leaf_setproperty( m, 'useMorphogens', true );
%    m = leaf_setproperty( m, 'plasticGrowth', false );
%    m = leaf_setproperty( m, 'maxFEcells', 0 );
%    m = leaf_setproperty( m, 'inittotalcells', 0 );
%    m = leaf_setproperty( m, 'bioApresplitproc', '' );
%    m = leaf_setproperty( m, 'bioApostsplitproc', '' );
%    m = leaf_setproperty( m, 'maxBioAcells', 0 );
%    m = leaf_setproperty( m, 'biosplitarea', 0.000000 );
%    m = leaf_setproperty( m, 'biosplitarrestmgen', 'ARREST' );
%    m = leaf_setproperty( m, 'biosplitarrestmgenthreshold', 0.990000 );
%    m = leaf_setproperty( m, 'bioMinEdgeLength', 0.000000 );
%    m = leaf_setproperty( m, 'bioSpacePullInRatio', 0.100000 );
%    m = leaf_setproperty( m, 'colors', (6 values) );
%    m = leaf_setproperty( m, 'colorvariation', 0.050000 );
%    m = leaf_setproperty( m, 'colorparams', (12 values) );
%    m = leaf_setproperty( m, 'biocolormode', 'auto' );
%    m = leaf_setproperty( m, 'userpostiterateproc', [] );
%    m = leaf_setproperty( m, 'canceldrift', false );
%    m = leaf_setproperty( m, 'mgen_interaction', '' );
%    m = leaf_setproperty( m, 'mgen_interactionName', 'gpt_sptest3_20170904' );
%    m = leaf_setproperty( m, 'allowInteraction', true );
%    m = leaf_setproperty( m, 'interactionValid', true );
%    m = leaf_setproperty( m, 'gaussInfo', (unknown type ''struct'') );
%    m = leaf_setproperty( m, 'D', (36 values) );
%    m = leaf_setproperty( m, 'C', (36 values) );
%    m = leaf_setproperty( m, 'G', (6 values) );
%    m = leaf_setproperty( m, 'solver', 'cgs' );
%    m = leaf_setproperty( m, 'solverprecision', 'double' );
%    m = leaf_setproperty( m, 'solvertolerance', 0.001000 );
%    m = leaf_setproperty( m, 'solvertolerancemethod', 'max' );
%    m = leaf_setproperty( m, 'diffusiontolerance', 0.000010 );
%    m = leaf_setproperty( m, 'allowsparse', true );
%    m = leaf_setproperty( m, 'maxsolvetime', 1000.000000 );
%    m = leaf_setproperty( m, 'cgiters', 0 );
%    m = leaf_setproperty( m, 'simsteps', 0 );
%    m = leaf_setproperty( m, 'stepsperrender', 0 );
%    m = leaf_setproperty( m, 'growthEnabled', true );
%    m = leaf_setproperty( m, 'diffusionEnabled', true );
%    m = leaf_setproperty( m, 'flashmovie', false );
%    m = leaf_setproperty( m, 'makemovie', false );
%    m = leaf_setproperty( m, 'moviefile', '' );
%    m = leaf_setproperty( m, 'codec', 'Motion JPEG AVI' );
%    m = leaf_setproperty( m, 'autonamemovie', true );
%    m = leaf_setproperty( m, 'overwritemovie', false );
%    m = leaf_setproperty( m, 'framesize', [] );
%    m = leaf_setproperty( m, 'mov', [] );
%    m = leaf_setproperty( m, 'boingNeeded', false );
%    m = leaf_setproperty( m, 'defaultinterp', 'min' );
%    m = leaf_setproperty( m, 'readonly', false );
%    m = leaf_setproperty( m, 'projectdir', 'C:\Users\koidey\GFtbox_Projects' );
%    m = leaf_setproperty( m, 'modelname', 'GPT_sptest3_20170904' );
%    m = leaf_setproperty( m, 'allowsave', true );
%    m = leaf_setproperty( m, 'addedToPath', false );
%    m = leaf_setproperty( m, 'bendsplit', 0.300000 );
%    m = leaf_setproperty( m, 'usepolfreezebc', false );
%    m = leaf_setproperty( m, 'dorsaltop', true );
%    m = leaf_setproperty( m, 'defaultazimuth', -45.000000 );
%    m = leaf_setproperty( m, 'defaultelevation', 33.750000 );
%    m = leaf_setproperty( m, 'defaultroll', 0.000000 );
%    m = leaf_setproperty( m, 'defaultViewParams', (unknown type ''struct'') );
%    m = leaf_setproperty( m, 'comment', '' );
%    m = leaf_setproperty( m, 'legendTemplate', '%T: %q\n%m' );
%    m = leaf_setproperty( m, 'bioAsplitcells', true );
%    m = leaf_setproperty( m, 'bioApullin', 0.142857 );
%    m = leaf_setproperty( m, 'bioAfakepull', 0.202073 );
%    m = leaf_setproperty( m, 'viewrotationstart', -45.000000 );
%    m = leaf_setproperty( m, 'viewrotationperiod', 0.000000 );
%    m = leaf_setproperty( m, 'interactive', false );
%    m = leaf_setproperty( m, 'coderevision', 0 );
%    m = leaf_setproperty( m, 'coderevisiondate', '' );
%    m = leaf_setproperty( m, 'modelrevision', 0 );
%    m = leaf_setproperty( m, 'modelrevisiondate', '' );
%    m = leaf_setproperty( m, 'savedrunname', '' );
%    m = leaf_setproperty( m, 'savedrundesc', '' );
%    m = leaf_setproperty( m, 'vxgrad', (108 values) );
 end

function [m,result] = GFtbox_Precelldivision_Callback( m, ci ) %#ok<DEFNU>
    [s_celldivthresh_i,s_celldivthresh_p,s_celldivthresh_a,s_celldivthresh_l] = getMgenLevels( m, 'S_CELLDIVTHRESH' );  %#ok<ASGLU>
    % Convert it to a perl-cell value.
    perCellThreshold = perVertexToPerCell( m, s_celldivthresh_p );
    % Split if the cell area exceeds the morphogen.
    result.divide = (m.secondlayer.cellarea(ci) > perCellThreshold(ci)) & (perCellThreshold(ci) > 0); % & (realtime <50);
    % Let GFtbox decide the splitting plane.
    result.dividepoint =  [];
    result.perpendicular = zeros( length(ci), 3 );
    % If a nonempty result is to be returned, it should be a struct
    % with fields result.divide, result.dividepoint, and result.perpendicular.
end

function [m,result] = GFtbox_Preplot_Callback( m, theaxes )
    result =[];
    m = setCellAreaMorphogen( m );
    m = setCellAreaMorphogen_aniso( m );
   
end

 function m = setCellAreaMorphogen( m )
     [c_area_i,c_area] = getCellFactorLevels( m, 'c_area' );  %#ok<ASGLU>
     area = m.secondlayer.cellarea;
     LN_area = log(area);
     m.secondlayer.cellvalues(:,c_area_i) = LN_area;
 end

function m = setCellAreaMorphogen_aniso( m )
    [c_aniso_i,c_aniso] = getCellFactorLevels( m, 'c_aniso' );  %#ok<ASGLU>
    aniso = leaf_cellshapes( m );
    
    aniso = anisoCorrection(aniso);   
    m.secondlayer.cellvalues(:,c_aniso_i) = aniso;
end

function a1 = anisoCorrection(a)
  a(a>1) = 1;
  a(a<0) = 0;
  a1 = (1 - sqrt( 1 - a.^2))./a;
  a1(isnan(a1)) = 0;
end

 function m = setCellAreaMorphogen_rand( m )
     [c_rand_i,c_rand] = getCellFactorLevels( m, 'c_rand' );  %#ok<ASGLU>
 end