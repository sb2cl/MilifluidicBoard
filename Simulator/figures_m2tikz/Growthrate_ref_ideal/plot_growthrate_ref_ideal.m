%% set properties for the plot
% load data to plot
close all
clear
load('growthrate_ideal_simulation.mat')

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


dark_grey = [0.2431,    0.2667,    0.2980];
light_blue = [0.0000,    0.7451,    1.0000];
dark_blue = [0.0000,    0.3176,    0.6196];
light_grey = [0.6235,    0.6000,    0.5961];
yellow = [1.0000,    0.8353,    0.0000];

width1 = 1.5;
style1 = '-';
marker1 = 'none';


width2 = 1;
style2 = '--';
marker2 = 'none';



nCol = 2;
nRow = 3;

fontsize = 10;
textwidth = 15.6; % cm 
plotname = 'mu_ref_ideal.tex';

fig = figure('Units','centimeters','outerposition', [0, 0, textwidth*1.15, textwidth*0.6],...% [left bottom width height]
'color', 'white');

YLim = [0.006 0.03];
YTick = 0.1:0.1:0.5;
YTickLabel = 0.1:0.1:0.5;

% [left bottom width height]
left = [0.1 0.55];
width = 0.36;
start = 0.05;
height = (1-start)/3*0.83;
bottom = 1 - (1-start)/3*(1:3);

%% plot
% reac 1
plot(out.tout,out.growth_reference(:,1),'Color',light_grey,'LineWidth',width2,'LineStyle',style1,'Marker',marker2)
hold on
plot(out.tout,out.actual_growth(:,1),'Color',light_grey,'LineWidth',width1,'LineStyle',style2,'Marker',marker1)
% reac 2
plot(out.tout,out.growth_reference(:,2),'Color',light_blue,'LineWidth',width2,'LineStyle',style1,'Marker',marker2)
plot(out.tout,out.actual_growth(:,2),'Color',light_blue,'LineWidth',width1,'LineStyle',style2,'Marker',marker1)
% reac 3
plot(out.tout,out.growth_reference(:,3),'Color',dark_grey,'LineWidth',width2,'LineStyle',style1,'Marker',marker2)
plot(out.tout,out.actual_growth(:,3),'Color',dark_grey,'LineWidth',width1,'LineStyle',style2,'Marker',marker1)
% reac 4
plot(out.tout,out.growth_reference(:,4),'Color',dark_blue,'LineWidth',width2,'LineStyle',style1,'Marker',marker2)
plot(out.tout,out.actual_growth(:,4),'Color',dark_blue,'LineWidth',width1,'LineStyle',style2,'Marker',marker1)
% axes properties
ax = gca();
ax.XLabel.String = '$t$ in minutes';
ax.YLabel.String = '$\mu$';
ax.YLim = YLim;
% ax.YTick = YTick;
% ax.YTickLabel = YTickLabel;
ax.FontSize = fontsize;
grid on

%%
cleanfigure('targetResolution',100)
set.axis_options = {'/tikz/line join=bevel'};
matlab2tikz(plotname, 'showInfo', false,'extraAxisOptions', set.axis_options);