function p = Init_4reac_1pump()
%% General parameters
  % Volume of the chamber of the biorreactor. [mL]
  p.V = 15;
  % Maximum growth rate. [1/min]
  p.mu_max = 0.0289;
  % Half activation the of growth rate. [g/L]
  p.K_s = 0.1802;
  % Biomass productivity conversion rate (how many grams of substrate do we need to produce one gram of biomass. [adim]
  p.y = 1.43;
  % Fresh media substrate concentration (3.6-> minimum, 180.156 -> maximim). [g/L]
  p.s_f = 3.6;
  % Concentration of E.Coli cells in 1OD (Optical density). [cell/ml]
  p.nOD = 1e9;
  % Average cell mass E.Coli. [mg/cell]
  p.m_p = 433e-12;
  
%% OD reference Reactor 1
p.r1.step_time = 500;
p.r1.init_val = 0.1;
p.r1.final_val = 0.5;

%% OD reference Reactor 2
p.r2.step_time = 250;
p.r2.init_val = 0.2;
p.r2.final_val = 0.4;

%% OD reference Reactor 3
p.r3.step_time = 600;
p.r3.init_val = 0.5;
p.r3.final_val = 0.1;

%% OD reference Reactor 4
p.r4.step_time = 400;
p.r4.init_val = 0.4;
p.r4.final_val = 0.2;

%% growth reference Reactor 1
p.r1_growth.step_time = 500;
p.r1_growth.init_val = 0.01;
p.r1_growth.final_val = 0.02;

%% growth reference Reactor 2
p.r2_growth.step_time = 300;
p.r2_growth.init_val = 0.02;
p.r2_growth.final_val = 0.01;

%% growth reference Reactor 3
p.r3_growth.step_time = 600;
p.r3_growth.init_val = 0.0125;
p.r3_growth.final_val = 0.015;

%% growth reference Reactor 4
p.r4_growth.step_time = 400;
p.r4_growth.init_val = 0.02;
p.r4_growth.final_val = 0.015;

%% millifluidic system parameters
p.interval = 1; % interval in which every reactor must be fed / waste removed
p.num_reac = 4;
p.max_pump_flow = 36; % in ml/minute, at 200RPM for 0.193ml/rev
p.pump_res = 0.180; % in ml, estimated value for 2.4mm ID by quadratic interpolation
p.clean_time = 0.5; % necessary time to clean the channels
p.waste_threshold = 0.5; % volume above p.V + p.waste_threshold --> do wasting cycle
end

