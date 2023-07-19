%% matlab initialization
close all; clc; clear figure; clearvars;

%% Add mfile folder path
path = cd;
m_path = '\Matlab_mfile';
path = strcat(path,m_path);
addpath(path);
clearvars path m_path;

%% Saturation angle
%==========================================================================
Sat_angle = 45; % saturation angle will be addressed on visualization, sorting and surface extraction
alpha = 12;     % supporting span
beta = 0;       % supporting gradient/invalidated if 0
% =========================================================================

%% Import STL Geo. file(Dialog style)
disp('Importing & reading stl ... ');
tic
Geometry_in = uigetfile('*.stl');
[stlcoords, stlnormal] = READ_stl(Geometry_in);
toc

%% STL position shift
stlcoords = TRANSLATION(stlcoords);

%% STL area(patch)--------------
Facet_area = STL_area(stlcoords);

%% Calculate the Overhang angle
[Overhang_list, Overhang_list_True] = Face_OverhangAngle(stlnormal, Sat_angle);
OVHFacet_list = find(Overhang_list < Sat_angle);

%% Overhang angle plot(Surface normal)
Overhang_PlotSTL(stlcoords,Overhang_list,Sat_angle);

%% Build risk plot(Safe/Risk)
Overhang_Risk_Plot(stlcoords,Overhang_list_True);

%% Patch_Contact_list------------------------------
tic
Patch_Contact_list = Contact_Patch_OVH(stlcoords);
disp('Face connectivity : ')
toc

%% ???
Characters = Clouding(stlcoords,Overhang_list,Facet_area,Sat_angle);


%% edge length 계산시 필요
% tic
EdgeLength = Contact_Length(stlcoords, Patch_Contact_list);
% disp('Edge length data prepared')
% toc


%% 
[N_weight, iter] = PropagationFSM_solver(EdgeLength, Overhang_list, Characters, alpha, Facet_area, Patch_Contact_list, Sat_angle, beta);

%% New Overhang plot(Weighted)
[hpat, Weight_OVHA_list] = Weighted_Overhang_Plot(stlcoords, Overhang_list, N_weight, Sat_angle);
% Weighted_Overhang_Plot(stlcoords, Overhang_list, N_weight, Sat_angle);

%% Calculate the Overhang area
% 기존 45도 미만의 Facet area 총합ㅕ
under_OVA_area = OVH_area_Cla(Facet_area, Overhang_list, Sat_angle);
tmp_TXT = ['The facet area under the overhang angle is ',num2str(under_OVA_area),' (mm^2)'];
disp(tmp_TXT)

% 가중된 오버행 중 45도 미만의 Facet area 총합
Weighted_under_OVA_area = OVH_area_Cla(Facet_area, Weight_OVHA_list, Sat_angle);
tmp_TXT = ['The facet area under the Weighted overhang angle is ',num2str(Weighted_under_OVA_area),' (mm^2)'];
disp(tmp_TXT)

% 감소율 계산
D_rate = (Weighted_under_OVA_area - under_OVA_area) / under_OVA_area *100;
tmp_TXT = ['The risk area decreases by ',num2str(D_rate),'(%) compared to the actual value.'];
disp(tmp_TXT)

% 실제 위험 역역 비중
ALL_area = sum(Facet_area);
A_rate = Weighted_under_OVA_area / ALL_area * 100;
tmp_TXT = ['The weighted risk area is ',num2str(A_rate),'(%).'];
disp(tmp_TXT)

clearvars tmp_TXT ans;

%% Weighted build risk plot(Safe/Risk)
Weight_OVHA_list_True = ones(length(Weight_OVHA_list),1);
for i=1:length(Weight_OVHA_list)
    if (Weight_OVHA_list(i) < Sat_angle)
        Weight_OVHA_list_True(i) = 0;    
    end
end
Overhang_Risk_Plot(stlcoords,Weight_OVHA_list_True);
title('Weighted build risk area');

%% clear var.
clearvars hpat i ans iter;
