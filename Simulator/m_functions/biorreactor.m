function [sys,x0,str,ts] = biorreactor(t,x,u,flag,Cini,p)
%  Biorreactor model.

% INPUT: u
%   u(1): F     (Input/output flow) [mL/min]

% INITIAL CONDITIONS: Cini
%   Cini(1):    (Concentration of biomass in the biorreactor)   [mg/mL]
%   Cini(2):    (Concentration of susbtrate in the biorreactor) [mg/mL]

% STATES: x
%   x(1):  x    (Concentration of biomass in the biorreactor)   [mg/mL]
%   x(2):  s    (Concentration of substrate in the biorreactor) [mg/mL]
%

% OUTPUTS: y
%   y(1):  x    (Concentration of biomass in the biorreactor)   [mg/mL]
%   y(2):  s    (Concentration of substrate in the biorreactor) [mg/mL]
%   y(3):  OD   (Optical density in the biorreactor)            [OD]
%   y(4):  mu   (Growth rate of the population of cells)        [1/min]

% System Description

if isvector(x)
  % Save the state array as individual variables.
  aux = x;
  
  x = aux(1);
  s = aux(2);

  F = u(1);
  
  D = F/p.V;
  mu = p.mu_max*s/(p.K_s+s);
end

switch flag
    case 0 % Initialization
        sys = [
            2       % number of continuous states
            0       % number of discrete states
            4       % number of outputs
            1       % number of inputs
            0       % reserved must be zero
            1       % direct feedthrough flag
            1       % number of sample times
            ];
        
        % Initialize state variables
        x0 = [
            Cini(1)
            Cini(2)
           ];
        
        str = [];
        ts  = [0 0];   % sample time: [period, offset]
        
    case 1 % Derivatives
        %dx    (Concentration of biomass in the biorreactor)
        sys(1)= mu*x - D*x;
        
        %ds    (Concentration of substrate in the biorreactor)
        sys(2)= -p.y*mu*x + D*(p.s_f - s);

    case 2 % Discrete state update
        sys = []; % do nothing
        
    case 3 % Outputs
        sys(1)  = x;
        sys(2)  = s;
        sys(3)  = x/p.m_p/p.nOD;
        sys(4)  = mu;
        
    case 9 % Terminate
        sys = []; % do nothing
        
    otherwise
        error(['unhandled flag = ',num2str(flag)]);
end
