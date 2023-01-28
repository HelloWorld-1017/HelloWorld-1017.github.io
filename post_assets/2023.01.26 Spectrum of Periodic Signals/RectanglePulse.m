classdef RectanglePulse < handle
    properties
        tau = 1;         % Rectangle pulse width
        Period  % Period
        Omega   % Fundamental frequency
        Delays  % Pulse delay position
        rectanglePulse % Time-domain waveform
        tlim    % Time limit
        flim    % Frequency limit
        time    % Time vector
    end

    methods
        % Constructor
        function obj = RectanglePulse(tau, Period, tlim, flim)
            % Initialize
            obj.tau = tau;
            obj.tlim = tlim;
            obj.flim = flim;

            % Calculate period and angular frequency
            obj.Period = Period;
            obj.Omega = 2*pi/obj.Period;

            % Obtain time vector
            obj.time = -obj.tlim:0.01:obj.tlim;

            % Consturct periodic rectangle pulse
            % Refer to https://ww2.mathworks.cn/help/signal/ug/signal-generation-and-visualization.html#SignalGenerationExample-4
            RightDelays = 0:obj.Period:max(obj.time);
            LeftDelays = -fliplr(RightDelays);
            obj.Delays = [LeftDelays(1:end-1), RightDelays];
            obj.rectanglePulse = pulstran(obj.time,obj.Delays,@rectpuls,tau);
        end

        % Plot periodic rectangle pulse
        function Plot(obj)
            plot(obj.time, obj.rectanglePulse, 'k')
            box(gca, "on")
            xlabel('t')
            ylabel('f(t)')
            set(gca, 'YTick', [0,1])
            set(gca, 'Xtick', obj.Delays)
            title(['$\tau=$',num2str(obj.tau), ...
                '$, T=$', num2str(obj.Period), ...
                '$, T/\tau=$', num2str(obj.Period/obj.tau)], 'Interpreter', 'latex')
            set(gca, 'FontSize', 13)
        end

        % Plot Unilateral Spectrum for cosine form series
        function PlotUniSpec(obj)
            Unifreq = 0:obj.Omega:obj.flim;
            n = Unifreq/obj.Omega;
            an = 2*obj.tau/obj.Period*Sa(n*pi*obj.tau/obj.Period);
            stem(Unifreq, an, 'filled', 'MarkerSize', 4, ...
                'DisplayName', 'Unilateral Spectrum')
            xlabel('$\Omega$ (Hz)', 'Interpreter', 'latex')
            ylabel('Amplitude')
            title(['$\Omega=$', num2str(obj.Omega)], 'Interpreter', 'latex')
            legend();
            set(gca, 'FontSize', 13)
        end

        % Plot Bilateral Spectrum for exponential form series
        function PlotBiSpec(obj)
            Unifreq = 0:obj.Omega:obj.flim;
            Bifreq = [-fliplr(Unifreq), Unifreq];
            n = Bifreq/obj.Omega;
            an = obj.tau/obj.Period*Sa(n*pi*obj.tau/obj.Period);
            obj.Omega = 2*pi/obj.Period;
            stem(Bifreq, an, 'filled', 'MarkerSize', 4, ...
                'DisplayName', 'Bilateral Spectrum')
            xlabel('$\Omega$ (Hz)', 'Interpreter', 'latex')
            ylabel('Amplitude')
            ylim([-0.2,1])
            title(['$\Omega=$', num2str(obj.Omega)], 'Interpreter', 'latex')
            legend();
            set(gca, 'FontSize', 13)
        end
    end
end

% Reconstruct sinc function
% Refer to: https://ww2.mathworks.cn/help/signal/ref/sinc.html
function y = Sa(x)
y = sinc(x/pi);
end

