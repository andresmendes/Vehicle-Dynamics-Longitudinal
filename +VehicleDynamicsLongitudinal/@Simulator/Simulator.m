classdef Simulator<handle
    % Simulator The simulator receives a vehicle object, simulates its
    % behavior during a given time span and provides its motion during time
    % via its properties. Each property is a (timespan, 1) vector in which
    % each value represents that parameter's value in time.
    methods
        % Constructor
        function self = Simulator(vehicle, tspan)
            self.Vehicle    = vehicle;  % Vehicle object.
            self.TSpan      = tspan;    % Time span         [s]
            % Initial conditions
            self.X0         = 0;        % Initial position  [m]
            self.V0         = 20;       % Initial speed     [m/s]
        end

        function f = getInitialState(self)
            % Transforms properties into a vector so it can be used by the
            % integrator
            f = [self.X0 self.V0];
        end

        function Simulate(self)
            options = odeset('AbsTol',1e-6,'RelTol',1e-6);
            [TOUT, ZOUT] = ode45(@(t, estados) self.Vehicle.Model(t, estados,self.TSpan), self.TSpan, self.getInitialState(),options);
            % retrieve states exclusive to the vehicle
            self.X = ZOUT(:, 1);
            self.V = ZOUT(:, 2);

            % TSpan and TOUT contain the same values, but the first is
            % passed in columns, while the second is a vector
            self.TSpan = TOUT;
            
            % Acceleration | Force | Reference speed
            % Preallocating
            self.A      = zeros(length(TOUT),1);
            self.F      = zeros(length(TOUT),1);
            self.Vr     = zeros(length(TOUT),1);
            for i=1:length(TOUT)
                [dz,F_l,V_r]    = self.Vehicle.Model(TOUT(i),ZOUT(i,:),self.TSpan);
                self.A(i)       = dz(2);
                self.F(i)       = F_l;
                self.Vr(i)      = V_r;
            end

        end
    end

    properties
        Vehicle % Vehicle model to be used in the simulation
        TSpan   % a vector indicating the intervals in which the simulation steps will be conducted
        X0      % Initial position              [m]
        V0      % Initial speed                 [m/s]
        X       % Longitudinal position         [m]
        V       % Longitudinal speed            [m/s]
        A       % Longitudinal acceleration     [m/s2]
        F       % Longitudinal force            [N]
        Vr      % Reference speed               [m/s]
    end
end