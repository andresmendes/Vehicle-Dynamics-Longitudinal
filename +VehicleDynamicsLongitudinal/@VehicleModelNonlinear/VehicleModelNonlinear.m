classdef VehicleModelNonlinear < VehicleDynamicsLongitudinal.VehicleModel
    % VehicleSimpleNonlinear Nonlinear vehicle model.
    %
    % It inherits properties from VehicleModel.

    methods
        % Constructor
        function self = VehicleModelNonlinear()
            self.m  = 1000;         % Mass of the vehicle       [kg]
            self.Ft = 133.7000;     % Traction force            [N]
            self.Fb = 0;            % Brake force               [N]
        end

        function dx = Model(self, t, states,~)
            
            % Parameters
            m   = self.m;
            g   = 9.81;             % Gravity                   [m/s2]
            Cd  = 0.3;              % Drag coefficient          [-]
            A   = 2;                % Frontal area              [m2]
            rho = 1;                % Air density               [kg/m2]
            
            % States
            X = states(1);
            V = states(2);

            % Drag resistance
            C  = 0.5*rho*Cd*A;
            Dx = 0.5*rho*Cd*A*V^2;
            
            % Rolling resistance
%             vKPH = V*3.6;
%             W = m*g;                % Weight [N]
%             vMPH = vKPH/1.609;      % Velocidade [mph]
%             % Model 1 - Tire pressure (28 psi)
%             f0 = 0.012;
%             fs = 0.007;
%             fr = f0 + 3.24*fs*(vMPH/100).^2.5;
%             Rx = fr*W;              % [N]
Rx=0;
            % Gravity force
            Gx = 0;
            if t > 20
                theta = 2*pi/180;           % Slope             [rad]
                Gx = m*g*sin(theta);        % Gravity force     [N]
            end
            
            % Traction force
            % TODO: PI control as Ft model using function handle.
%             if isa(self.Ft,'function_handle')
%                 Ft = self.Ft([X;V],t);
%             elseif length(self.Ft)>1
%                 Ft = interp1(tspan,self.Ft,t);
%             else
%                 Ft = self.Ft;
%             end
            Kp      = 300;
            Ki      = 100;
            vOp     = 72/3.6; % Ref. speed [m/s]
            Clinear = 2*C*vOp;
            Ft = Kp*(vOp-V)+Ki*(vOp*t - X) + C*vOp^2 + (V - vOp)*Clinear;

            % Dynamics
            dx(1,1) = V;
            dx(2,1) = (Ft - Dx - Rx - Gx)/m;

        end
    end
end

%% See Also
%
% <https://github.com/andresmendes/Vehicle-Dynamics-Longitudinal Home>
%
