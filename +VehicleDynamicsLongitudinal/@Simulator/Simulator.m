classdef Simulator<handle
    % Simulator Vehicle dynamics simulator
    % The simulator receives a vehicle object that inherits from VehicleSimple, simulates its behavior during a given time span and provides its behavior during time via its properties. Each property is a (timespan, 1) vector in which each value represents that parameter's value in time.
    methods
        % Constructor
        function self = Simulator(vehicle, tspan)
            self.Vehicle    = vehicle;
            self.TSpan      = tspan;
            % Initial conditions
            self.X0 = 0;
            self.V0 = 20;
        end

        function f = getInitialState(self)
            % Transforms properties into a vector so it can be used by the integrator
            f = [self.X0 self.V0];
        end

        function Simulate(self)
            options = odeset('AbsTol',1e-6,'RelTol',1e-6)
            [TOUT, XOUT] = ode45(@(t, estados) self.Vehicle.Model(t, estados,self.TSpan), self.TSpan, self.getInitialState(),options);
            % retrieve states exclusive to the vehicle
            self.X = XOUT(:, 1);
            self.V = XOUT(:, 2);

            % TSpan and TOUT contain the same values, but the first is passed in columns, while the second is a vector
            self.TSpan = TOUT;
        end
    end

    properties
        Vehicle % Vehicle model to be used in the simulation
        TSpan   % a vector indicating the intervals in which the simulation steps will be conducted
        X0      % Initial position [m]
        V0      % Initial speed [m/s]
        X       % Longitudinal position [m]
        V       % Longitudinal speed    [m/s]
    end
end

%% See Also
%
% <../../index.html Home>
%