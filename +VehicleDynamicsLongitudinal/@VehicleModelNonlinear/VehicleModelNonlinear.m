classdef VehicleModelNonlinear < VehicleDynamicsLongitudinal.VehicleModel
    % VehicleSimpleNonlinear Nonlinear vehicle model.
    %
    % It inherits properties from VehicleModel.

    methods
        % Constructor
        function self = VehicleModelNonlinear()
            
            % Vehicle parameters
            self.m  = 1000;         % Mass of the vehicle       [kg]
            self.Cd = 0.35;         % Drag coefficient          [-]
            self.A  = 2.5;          % Frontal area              [m2]
            self.L  = 4.65;         % Length of the vehicle     [m]
            self.W  = 1.78;         % Width of the vehicle      [m]
            % Constants
            self.g   = 9.81;        % Gravity                   [m/s2]
            self.rho = 1;           % Air density               [kg/m2]
            % Function handles
            self.slope      = @self.road_slope;                 % Road slope function
            self.v_ref      = @self.speed_reference;            % Speed reference function
            self.control    = @self.longitudinal_controller;    % Longitudinal controller

        end

        function [dz,Ft,V_ref] = Model(self, t, states,~)

            % Parameters
            g   = self.g;  
            m   = self.m;
            Cd  = self.Cd;          
            A   = self.A;    
            rho = self.rho;
                        
            % States
%             X = states(1);
            V = states(2);

            % Drag resistance
            Dx = 0.5*rho*Cd*A*V^2;
            
            % TODO: Rolling resistance 
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
            theta = self.slope(t);              % Slope                 [rad]
            Gx = m*g*sin(theta);                % Gravity force         [N]
            
            % Longitudinal force
            V_ref = self.v_ref(t);              % Speed reference       [m/s]
            Ft = self.control(V,V_ref);         % Longitudinal force    [N]

            % Dynamics
            dz(1,1) = V;
            dz(2,1) = (Ft - Dx - Rx - Gx)/m;

        end

        function theta = road_slope(~,~)
            % road_slope define the standard slope as a function of time.
            theta = 0;                  % Slope             [rad]
        end

        function v_ref = speed_reference(~,~)
            % road_slope define the standard speed reference as a function
            % of time.
            v_ref = 20;                 % speed             [m/s]
        end

        function Ft = longitudinal_controller(self,V,V_ref)
            % longitudinal_controller define the standard traction force as
            % a function of speed reference.
            
            Cd  = self.Cd;          
            A   = self.A;    
            rho = self.rho;

            Dx = 0.5*rho*Cd*A*V_ref^2;
            
            Kp  = 500;
            Ft  = Kp*(V_ref - V) + Dx;
            
        end
    end
end