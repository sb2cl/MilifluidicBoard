function [p] = Init_1reac_idealpump()
  % Volume of the chamber of the biorreactor. [mL]
  p.V = 15;

  % Maximum growth rate. [1/min]
  p.mu_max = 0.0322;
  
  % Half activation the of growth rate. [mg/mL]
  p.K_s = 1.8204;

  % Biomass productivity conversion rate (how many grams of substrate do we need to produce one gram of biomass. [adim]
  p.y = 1.43;

  % Fresh media substrate concentration (0.5 -> minimum, 16 -> maximim). [mg/mL]
  p.s_f = 16;

  % Concentration of E.Coli cells in 1OD (Optical density). [cell/ml]
  p.nOD = 1e9;

  % Average cell mass E.Coli. [mg/cell]
  p.m_p = 865e-12;
  
  % new param
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
end
