classdef (Abstract) VehicleModel
    % VehicleModel Simple vehicle abstract class.
    %
    % Abstract class representing a simple vehicle.
    %
    % Extend this class in order to create a new vehicle model to be used with the simulator.

    methods(Abstract)
        Model(self, t, estados)
    end

    properties
        % Vehicle parameters
        m       % Mass of the vehicle       [kg]
        Cd      % Drag coefficient          [-]
        A       % Frontal area              [m2]
        L       % Length of the vehicle     [m]
        W       % Width of the vehicle      [m]
        % Constants
        g       % Gravity                   [m/s2]
        rho     % Air density               [kg/m2]
        % Function handle
        slope   % Road slope function 
        v_ref   % Speed reference function
        control % Speed reference function
        
    end

    methods
       
    end

end