%% init and load data
clc
clear
Init_general();
    
exp1_all = load('datasets/2021-02-16 02.mat');
exp1 = exp1_all.out;

exp2_all = load('datasets/2021-02-16 04.mat');
exp2 = exp2_all.out;

% time interval for plots [t_lower, t_upper]
t_lower = 0; % minutes
t_upper = 1000; % minutes
exp1.t_indices = (exp1.tout >= t_lower) == (exp1.tout <= t_upper);
exp2.t_indices = (exp2.tout >= t_lower) == (exp2.tout <= t_upper);

%% calculate mean error and RMSE
exp1.mean_error = mean(abs(exp1.reference(exp1.t_indices)-exp1.actual(exp1.t_indices)),1);
exp2.mean_error = mean(abs(exp2.reference(exp2.t_indices)-exp2.actual(exp2.t_indices)),1);

exp1.RMSE = sqrt(mean((exp1.reference(exp1.t_indices)-exp1.actual(exp1.t_indices)).^2,1));
exp2.RMSE = sqrt(mean((exp2.reference(exp2.t_indices)-exp2.actual(exp2.t_indices)).^2,1));

%% pump capacity utilization
exp1.max_pump_flow = exp1_all.p.max_pump_flow;
exp2.max_pump_flow = exp2_all.p.max_pump_flow;
window_length = 100; % in minutes
window_length_steps = window_length/h;
exp1.pump_util = [];
exp2.pump_util = [];
exp1.pump_util_sliding = [];
exp2.pump_util_sliding = [];

switch exp1_all.p.strategy_select
    case {1,2,3}
        exp1.pump_util(1) = mean(exp1.pump_inflow+exp1.pump_outflow,1)/exp1.max_pump_flow; % total capacity utilization
        exp1.pump_util_sliding = movmean(exp1.pump_inflow+exp1.pump_outflow,[window_length_steps 0])/exp1.max_pump_flow; % use only previous values for calculation        
    case {4,5,6}
        exp1.pump_util(1) = mean(exp1.pump_inflow,1)/exp1.max_pump_flow; % total capacity utilization
        exp1.pump_util(2) = mean(exp1.pump_outflow,1)/exp1.max_pump_flow; % total capacity utilization
        exp1.pump_util_sliding(:,1) = movmean(exp1.pump_inflow,[window_length_steps 0])/exp1.max_pump_flow; % use only previous values for calculation
        exp1.pump_util_sliding(:,2) = movmean(exp1.pump_outflow,[window_length_steps 0])/exp1.max_pump_flow; % use only previous values for calculation
end

switch exp2_all.p.strategy_select
    case {1,2,3}
        exp2.pump_util(1) = mean(exp2.pump_inflow+exp2.pump_outflow,1)/exp2.max_pump_flow; % total capacity utilization
        exp2.pump_util_sliding = movmean(exp2.pump_inflow+exp2.pump_outflow,[window_length_steps 0])/exp2.max_pump_flow; % use only previous values for calculation        
    case {4,5,6}
        exp2.pump_util(1) = mean(exp2.pump_inflow,1)/exp2.max_pump_flow; % total capacity utilization
        exp2.pump_util(2) = mean(exp2.pump_outflow,1)/exp2.max_pump_flow; % total capacity utilization
        exp2.pump_util_sliding(:,1) = movmean(exp2.pump_inflow,[window_length_steps 0])/exp2.max_pump_flow; % use only previous values for calculation
        exp2.pump_util_sliding(:,2) = movmean(exp2.pump_outflow,[window_length_steps 0])/exp2.max_pump_flow; % use only previous values for calculation
end
%% plot initialization
close all
set(0, 'DefaultTextInterpreter', 'LaTeX');
set(0, 'DefaultAxesTickLabelInterpreter', 'LaTeX');
set(0, 'DefaultAxesFontName', 'LaTeX');
set(0, 'DefaultLegendInterpreter', 'LaTeX');

% Colors
ISYS = [0.2431,    0.2667,    0.2980; % Dark grey
    0.0000,    0.7451,    1.0000; % Light blue
    0.0000,    0.3176,    0.6196; % Dark blue
    0.6235,    0.6000,    0.5961; % Light grey
    1.0000,    0.8353,    0.0000]; % yellow

color1 = ISYS(4,:);
width1 = 1.5;
style1 = '-';
marker1 = 'none';

color2 = ISYS(2,:);
width2 = 0.5;
style2 = '-';
marker2 = 'none';

color3 = ISYS(3,:);
width3 = 0.5;
style3 = '-';
marker3 = 'none';
% markersize3 = 10;

color4 = ISYS(1,:);
width4 = 1;
style4 = '-';
marker4 = 'none';

xlabel_text = 'time in minutes';
ylabel_text = 'OD';

%% plot OD both experiments and the reference
% reactor 1
figure(1);
subplot(4,1,1);
plot(exp1.tout(exp1.t_indices), exp1.reference(exp1.t_indices,1),'Color',color1,'LineWidth',width1,'LineStyle',style1,'Marker',marker1);
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.actual(exp1.t_indices,1),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
plot(exp2.tout(exp2.t_indices), exp2.actual(exp2.t_indices,1),'Color',color3,'LineWidth',width3,'LineStyle',style3,'Marker',marker3);
legend('OD reference','OD experiment 1','OD experiment 2');
title('Reactor 1');
xlabel(xlabel_text);
ylabel(ylabel_text);

% reactor 2
figure(1);
subplot(4,1,2);
plot(exp1.tout(exp1.t_indices), exp1.reference(exp1.t_indices,2),'Color',color1,'LineWidth',width1,'LineStyle',style1,'Marker',marker1);
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.actual(exp1.t_indices,2),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
plot(exp2.tout(exp2.t_indices), exp2.actual(exp2.t_indices,2),'Color',color3,'LineWidth',width3,'LineStyle',style3,'Marker',marker3);
legend('OD reference','OD experiment 1','OD experiment 2');
title('Reactor 2');
xlabel(xlabel_text);
ylabel(ylabel_text);

% reactor 3
figure(1);
subplot(4,1,3);
plot(exp1.tout(exp1.t_indices), exp1.reference(exp1.t_indices,3),'Color',color1,'LineWidth',width1,'LineStyle',style1,'Marker',marker1);
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.actual(exp1.t_indices,3),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
plot(exp2.tout(exp2.t_indices), exp2.actual(exp2.t_indices,3),'Color',color3,'LineWidth',width3,'LineStyle',style3,'Marker',marker3);
legend('OD reference','OD experiment 1','OD experiment 2');
title('Reactor 3');
xlabel(xlabel_text);
ylabel(ylabel_text);

figure(2);
plot(exp1.tout(exp1.t_indices), exp1.reference(exp1.t_indices,3),'Color',color1,'LineWidth',width1,'LineStyle',style1,'Marker',marker1);
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.actual(exp1.t_indices,3),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
plot(exp2.tout(exp2.t_indices), exp2.actual(exp2.t_indices,3),'Color',color3,'LineWidth',width3,'LineStyle',style3,'Marker',marker3);
legend('OD reference','OD experiment 1','OD experiment 2');
title('Reactor 3');
xlabel(xlabel_text);
ylabel(ylabel_text);

% reactor 4
figure(1);
subplot(4,1,4);
plot(exp1.tout(exp1.t_indices), exp1.reference(exp1.t_indices,4),'Color',color1,'LineWidth',width1,'LineStyle',style1,'Marker',marker1);
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.actual(exp1.t_indices,4),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
plot(exp2.tout(exp2.t_indices), exp2.actual(exp2.t_indices,4),'Color',color3,'LineWidth',width3,'LineStyle',style3,'Marker',marker3);
legend('OD reference','OD experiment 1','OD experiment 2');
title('Reactor 4');
xlabel(xlabel_text);
ylabel(ylabel_text);

%% plot pump capacity utilizations
% experiment 1
figure(3);
switch exp1_all.p.strategy_select
    case {1,2,3}
        
plot(exp1.tout(exp1.t_indices), repmat(exp1.pump_util,length(exp1.tout(exp1.t_indices)),1),...
    'Color',color1,'LineWidth',0.5,'LineStyle','--','Marker',marker1)
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.pump_util_sliding(exp1.t_indices),'Color',color1,'LineWidth',0.5,'LineStyle',style1,'Marker',marker1);
    
    case {4,5,6}
        
plot(exp1.tout(exp1.t_indices), repmat(exp1.pump_util(1),length(exp1.tout(exp1.t_indices)),1),...
    'Color',color1,'LineWidth',0.5,'LineStyle','--','Marker',marker1)
grid on
hold on
plot(exp1.tout(exp1.t_indices), exp1.pump_util_sliding(exp1.t_indices,1),'Color',color1,'LineWidth',0.5,'LineStyle',style1,'Marker',marker1);
plot(exp1.tout(exp1.t_indices), repmat(exp1.pump_util(2),length(exp1.tout(exp1.t_indices)),1),...
    'Color',color2,'LineWidth',0.5,'LineStyle','--','Marker',marker2)
plot(exp1.tout(exp1.t_indices), exp1.pump_util_sliding(exp1.t_indices,2),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
end
xlabel(xlabel_text);
ylabel('pump capacity utilization in percent');
title('Pump capacity utilizations exp 1');
legend('pump 1','pump 1 sliding','pump 2','pump 2 sliding');
ylim([0 max(max(exp1.pump_util_sliding(100:end,:)))+0.01]);

% experiment 2
figure(4);
switch exp2_all.p.strategy_select
    case {1,2,3}
        
plot(exp2.tout(exp2.t_indices), repmat(exp2.pump_util,length(exp2.tout(exp2.t_indices)),1),...
    'Color',color1,'LineWidth',0.5,'LineStyle','--','Marker',marker1)
grid on
hold on
plot(exp2.tout(exp2.t_indices), exp2.pump_util_sliding(exp2.t_indices),'Color',color1,'LineWidth',0.5,'LineStyle',style1,'Marker',marker1);
    
    case {4,5,6}
        
plot(exp2.tout(exp2.t_indices), repmat(exp2.pump_util(1),length(exp2.tout(exp2.t_indices)),1),...
    'Color',color1,'LineWidth',0.5,'LineStyle','--','Marker',marker1)
grid on
hold on
plot(exp2.tout(exp2.t_indices), exp2.pump_util_sliding(exp2.t_indices,1),'Color',color1,'LineWidth',0.5,'LineStyle',style1,'Marker',marker1);
plot(exp2.tout(exp2.t_indices), repmat(exp2.pump_util(2),length(exp2.tout(exp2.t_indices)),1),...
    'Color',color2,'LineWidth',0.5,'LineStyle','--','Marker',marker2)
plot(exp2.tout(exp2.t_indices), exp2.pump_util_sliding(exp2.t_indices,2),'Color',color2,'LineWidth',width2,'LineStyle',style2,'Marker',marker2);
end
xlabel(xlabel_text);
ylabel('pump capacity utilization in percent');
title('Pump capacity utilizations exp 2');
legend('pump 1','pump 1 sliding','pump 2','pump 2 sliding');
ylim([0 max(max(exp2.pump_util_sliding(100:end,:)))+0.01]);