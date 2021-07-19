function [p] = param()
%% General parameters
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
end
