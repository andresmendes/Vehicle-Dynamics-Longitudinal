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
        m       % Mass of the vehicle   [kg]
        Ft      % Traction force        [N]
        Fb      % Brake force           [N]
        Rx      % Rolling resistance    [N]
        Dx      % Drag force            [N]
        Gx      % Gravity force         [N]
    end

    methods


    end

end

%% See Also
%
% <https://github.com/andresmendes/Vehicle-Dynamics-Longitudinal Home>
%
