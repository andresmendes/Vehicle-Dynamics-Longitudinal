%% Template Simplified
% This template shows how to simulate the longitudinal dynamics of a
% vehicle and plot the results.
%
% Watch animation on YouTube: <https://youtu.be/-y36vpdksPY>
%
%% Simulation models and parameters
% First, all classes of the package are imported with

clear ; close all ; clc 

import VehicleDynamicsLongitudinal.*

%% Vehicle model

VehicleModel = VehicleModelNonlinear();

%% Simulation time span

tf      = 10;                       % Final time                    [s]
fR      = 30;                       % Frame rate                    [fps]
dt      = 1/fR;                     % Time resolution               [s]
TSPAN   = linspace(0,tf,tf*fR);     % Time                          [s]

%% Simulation object
% To define a simulation object (simulator) the arguments must be the
% vehicle object and the time span.

simulator = Simulator(VehicleModel, TSPAN);

%% Run simulation
% To simulate the system we run the Simulate method of the simulation
% object.

simulator.Simulate();

%% Results

g = Graphics(simulator);

g.Plot_Signals();
% g.Animation('TemplateSimplifiedAnimation'); % (uncomment to run the animation)

%% See Also
%
% <https://www.mathworks.com/matlabcentral/fileexchange/81938-vehicle-dynamics-longitudinal Home>
%
