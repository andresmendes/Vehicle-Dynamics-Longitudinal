classdef Graphics
    % Graphics Functions for graphics generation.
    %

    methods
        % Constructor
        function self = Graphics(simulator)
            self.Simulator          = simulator;
            self.VehicleColor       = 'r';
        end

        function Animation(self, varargin)

            vehicle_position    = self.Simulator.X;
            vehicle_speed       = self.Simulator.V;
            vehicle_acc         = self.Simulator.A;
            TOUT                = self.Simulator.TSpan;
            force_long          = self.Simulator.F;
            speed_ref           = self.Simulator.Vr;
            
            vehicle_Length      = self.Simulator.Vehicle.L;
            vehicle_Width       = self.Simulator.Vehicle.W;
            
            % Road
            road_Width              = 10;       % Road width                    [m]
            road_Margin             = 2;        % Road margin                   [m]
            road_Dist_Analysis      = 100;      % Road distance analysis        [m]
            
            if nargin == 2
                name = varargin{1};
            else
                name = 'animacao';
            end
                
            figure
%             set(gcf,'Position',[50 50 1280 720]) % 720p
            set(gcf,'Position',[50 50 854 480]) % 480p

            % Create and open video writer object
            v = VideoWriter(strcat(name,'.mp4'),'MPEG-4');
            v.Quality = 100;
            open(v);

            for i=1:length(TOUT)
                subplot(3,2,1)
                    hold on ; grid on ; box on
                    set(gca,'xlim',[0 TOUT(end)],'ylim',[0 1.2*max(vehicle_position)])
                    cla 
                    plot(TOUT,vehicle_position,'b')
                    plot([TOUT(i) TOUT(i)],[0 1.2*max(vehicle_position)],'k--') 
                    xlabel('Time [s]')
                    ylabel('Position [m]')
                    title('Position')
                subplot(3,2,2)
                    hold on ; grid on ; box on
                    set(gca,'xlim',[0 TOUT(end)],'ylim',[0 1.2*max(vehicle_speed)])
                    cla 
                    plot(TOUT,speed_ref,'k')
                    plot(TOUT,vehicle_speed,'b')
                    plot([TOUT(i) TOUT(i)],[0 1.2*max(vehicle_speed)],'k--') 
                    xlabel('Time [s]')
                    ylabel('Speed [m/s]')
                    title('Speed (Black=Reference, Blue=Actual)')
                subplot(3,2,3)
                    hold on ; grid on ; box on
                    set(gca,'xlim',[0 TOUT(end)],'ylim',[min(vehicle_acc)-1 max(vehicle_acc)+1])
                    cla 
                    plot(TOUT,vehicle_acc,'b')
                    plot([TOUT(i) TOUT(i)],[min(vehicle_acc)-1 max(vehicle_acc)+1],'k--') 
                    xlabel('Time [s]')
                    ylabel('Acceleration [m/s2]')
                    title('Acceleration')
                subplot(3,2,4)
                    hold on ; grid on ; box on
                    set(gca,'xlim',[0 TOUT(end)],'ylim',[min(force_long)-500 max(force_long)+500])
                    cla 
                    plot(TOUT,force_long,'b')
                    plot([TOUT(i) TOUT(i)],[min(force_long)-500 max(force_long)+500],'k--') 
                    xlabel('Time [s]')
                    ylabel('Lon. force [N]')
                    title('Longitudinal force')
                subplot(3,2,5:6)
                    hold on ; axis equal ; box on
                    cla 
                    % Position of the vehicle at current instant [m]
                    vehicle_position_inst = vehicle_position(i);

                    sideMarkingsX = [vehicle_position_inst-road_Dist_Analysis/2 vehicle_position_inst+road_Dist_Analysis/2];
                    set(gca,'xlim',sideMarkingsX,'ylim',[-road_Width/2-road_Margin +road_Width/2+road_Margin])

                    plot(sideMarkingsX,[+road_Width/2 +road_Width/2],'k--') % Left marking
                    plot(sideMarkingsX,[-road_Width/2 -road_Width/2],'k--') % Right marking

                    % Dimensions
                    vehicle_dimension_X = [vehicle_position_inst vehicle_position_inst vehicle_position_inst-vehicle_Length vehicle_position_inst-vehicle_Length];
                    vehicle_dimension_Y = [+vehicle_Width/2 -vehicle_Width/2 -vehicle_Width/2 +vehicle_Width/2];
                    % Plotting
                    fill(vehicle_dimension_X,vehicle_dimension_Y,'r')

                    xlabel('Lon. distance [m]')
                    ylabel('Lat. distance [m]')

                frame = getframe(gcf);
                writeVideo(v,frame);
            end

            close(v);

        end

        function Plot_Signals(self, varargin)

            vehicle_position    = self.Simulator.X;
            vehicle_speed       = self.Simulator.V;
            vehicle_acc         = self.Simulator.A;
            TOUT                = self.Simulator.TSpan;
            force_long          = self.Simulator.F;
            speed_ref           = self.Simulator.Vr;
            
            figure
%             set(gcf,'Position',[50 50 1280 720]) % 720p
            set(gcf,'Position',[50 50 854 480]) % 480p

            subplot(2,2,1)
                hold on ; grid on ; box on
                set(gca,'xlim',[0 TOUT(end)],'ylim',[0 1.2*max(vehicle_position)])
                cla 
                plot(TOUT,vehicle_position,'b')
                xlabel('Time [s]')
                ylabel('Position [m]')
                title('Position')
            subplot(2,2,2)
                hold on ; grid on ; box on
                set(gca,'xlim',[0 TOUT(end)],'ylim',[0 1.2*max(vehicle_speed)])
                cla 
                plot(TOUT,speed_ref,'k')
                plot(TOUT,vehicle_speed,'b')
                xlabel('Time [s]')
                ylabel('Speed [m/s]')
                title('Speed (Black=Reference, Blue=Actual)')
            subplot(2,2,3)
                hold on ; grid on ; box on
                set(gca,'xlim',[0 TOUT(end)],'ylim',[min(vehicle_acc)-1 max(vehicle_acc)+1])
                cla 
                plot(TOUT,vehicle_acc,'b')
                xlabel('Time [s]')
                ylabel('Acceleration [m/s2]')
                title('Acceleration')
            subplot(2,2,4)
                hold on ; grid on ; box on
                set(gca,'xlim',[0 TOUT(end)],'ylim',[min(force_long)-500 max(force_long)+500])
                cla 
                plot(TOUT,force_long,'b')
                xlabel('Time [s]')
                ylabel('Lon. force [N]')
                title('Longitudinal force')

        end
    end

    %% Properties
    %

    properties
        Simulator
        VehicleColor
    end
end