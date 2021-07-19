function [sys,x0,str,ts] = controllerGrowth(t,x,u,flag,p)
%  Controllers for the biorreactor.

% Chemostat mode.

% INPUT: u
%   u(1): OD     (Optical density in the biorreactor)     [OD]
%   u(2): mu     (Growth rate of the population of cells) [1/min]
%   u(3): mu_ref (Reference for growth rate)              [1/min]

% INITIAL CONDITIONS: Cini
% There is no states.

% STATES: x
% There is no states.

% OUTPUTS: y
%   u(1): F     (Input/output flow) [mL/min]

% System Description

if isvector(u)
  % Rename the input vector for simplicity.
  OD = u(1);
  mu = u(2);
  mu_ref = u(3);

end

switch flag
    case 0 % Initialization
        sys = [
            0       % number of continuous states
            0       % number of discrete states
            1       % number of outputs
            3       % number of inputs
            0       % reserved must be zero
            1       % direct feedthrough flag
            1       % number of sample times
            ];
        
        % Initialize state variables
        x0 = [
           ];
        
        str = [];
        ts  = [0 0];   % sample time: [period, offset]
        
    case 1 % Derivatives
        sys = []; % do nothing

    case 2 % Discrete state update
        sys = []; % do nothing
        
    case 3 % Outputs
        sys(1)  = mu_ref*p.V;
        
    case 9 % Terminate
        sys = []; % do nothing
        
    otherwise
        error(['unhandled flag = ',num2str(flag)]);
end
