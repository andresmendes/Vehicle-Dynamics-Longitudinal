%% Template Simplified
% This template shows how to simulate a simple vehicle and plot the
% results.
%
%% Simulation models and parameters
% First, all classes of the package are imported with

clear ; close all ; clc 

import VehicleDynamicsLongitudinal.*

%%
% Choosing vehicle model.

% Choosing vehicle
VehicleModel = VehicleModelNonlinear();

%%
% Choosing simulation time span

T       = 70;                       % Total simulation time         [s]
resol   = 100;                       % Resolution
TSPAN   = 0:T/resol:T;              % Time span                     [s]

%%
% To define a simulation object (simulator) the arguments must be the
% vehicle object and the time span.

simulator = Simulator(VehicleModel, TSPAN);

%% Run simulation
% To simulate the system we run the Simulate method of the simulation
% object.

simulator.Simulate();

%% Results
% The time series of each state is stored in separate variables. Retrieving
% states

X      = simulator.X;
V      = simulator.V;

%%
% Plotting the states

figure
hold on ; grid on ; box on
plot(TSPAN,V)
xlabel('Time [s]')
ylabel('Speed [m/s]')

%% See Also
%
% <../../../index.html Home>
%
