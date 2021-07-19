function [sys,x0,str,ts] = controller(t,x,u,flag,p)
%  Controllers for the biorreactor.

% Proportional to biomass and growth rate controller.

% INPUT: u
%   u(1): OD     (Optical density in the biorreactor)     [OD]
%   u(2): mu     (Growth rate of the population of cells) [1/min]
%   u(3): OD_ref (Reference for optical density)          [OD]
%   u(4): V      (Volume in Reactor)                      [ml]

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
  OD_ref = u(3);
  V = u(4);
  
  if OD_ref == 0
      OD_ref = inf;
  end

end

switch flag
    case 0 % Initialization
        sys = [
            0       % number of continuous states
            0       % number of discrete states
            1       % number of outputs
            4       % number of inputs
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
        sys(1)  = OD*mu/OD_ref*V;
        if sys(1)>10
            disp('hello');
        end
        
    case 9 % Terminate
        sys = []; % do nothing
        
    otherwise
        error(['unhandled flag = ',num2str(flag)]);
end
