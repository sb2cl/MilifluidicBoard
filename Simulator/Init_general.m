%% clean up
close all
clear
clc

%% necessary paths
addpath(genpath('../MilifluidicSimulator'));

addpath(genpath('4reac_1pump'));
addpath(genpath('4reac_2pump'));
addpath(genpath('1reac_idealpump'));
addpath(genpath('4reac_idealpump'));
addpath(genpath('tubing_mdls'));
addpath(genpath('reactor_w_volume_state'));
addpath(genpath('test'));
addpath(genpath('old_parameters_and_references_datasets'));

%% get parameter structs
% p_4reac_1pump = Init_4reac_1pump();
% p_4reac_2pump = Init_4reac_2pump();
% p = Init_1reac_idealpump();

%% general parameters
h = 1e-3; %stepsize [minutes]
% h = 1e-4;
stoptime = 1000;
ref_select = 1;
strategy_select = 4;
p.ref_select = ref_select;
p.strategy_select = strategy_select;
%% millifluidic system parameters
p.num_reac = 4;
p.interval = 0.5; % interval in which every reactor must be fed / waste removed
p.max_pump_flow = 36; % in ml/minute, at 200RPM for 0.193ml/rev
p.pump_res = 0.180; % in ml
% p.pump_res = 0.0587;
p.clean_time = 0.6; % necessary time to clean the channels
p.waste_threshold = 3; % volume above p.V + p.waste_threshold --> do wasting cycle
p.valve_switch_time = 5e-3; % 1e-3 minutes --> 0.06 seconds
p.sampling_int = 15; % sampling interval in minutes

%% General parameters
% Volume of the chamber of the biorreactor. [mL]
p.V = repmat(15,p.num_reac,1);
% Maximum growth rate. [1/min]
p.mu_max = repmat(0.0289,p.num_reac,1);
% Half activation the of growth rate. [g/L]
p.K_s = repmat(0.1802,p.num_reac,1);
% Biomass productivity conversion rate (how many grams of substrate do we need to produce one gram of biomass. [adim]
p.y = repmat(1.43,p.num_reac,1);
% Fresh media substrate concentration (3.6-> minimum, 180.156 -> maximim). [g/L]
p.s_f = repmat(3.6,p.num_reac,1);
% Concentration of E.Coli cells in 1OD (Optical density). [cell/ml]
p.nOD = repmat(1e9,p.num_reac,1);
% Average cell mass E.Coli. [mg/cell]
p.m_p = repmat(433e-12,p.num_reac,1);
%% initial conditions;
p.init_x = repmat(0.1,p.num_reac,1);
p.init_s = repmat(16,p.num_reac,1);
p.init_v = repmat(15,p.num_reac,1);

%% OD reference
p.OD.step_time = [500; 250; 600; 400];
p.OD.init_val = [0.1; 0.2; 0.5; 0.4];
p.OD.final_val = [0.5; 0.4; 0.1; 0.2];

% p.OD.step_time = [500; 250; 600; 400; 300];
% p.OD.init_val = [0.1; 0.2; 0.5; 0.4;0.3];
% p.OD.final_val = [0.5; 0.4; 0.1; 0.2; 0.1];

%% Growth rate reference
p.growth_rate.step_time = [500; 300; 600; 400];
p.growth_rate.init_val = [0.01; 0.02; 0.0125; 0.02];
p.growth_rate.final_val = [0.02; 0.01; 0.015; 0.015];

% p.growth_rate.step_time = [500; 300; 600; 400; 300];
% p.growth_rate.init_val = [0.01; 0.02; 0.0125; 0.02; 0.025];
% p.growth_rate.final_val = [0.02; 0.01; 0.015; 0.015; 0.015];