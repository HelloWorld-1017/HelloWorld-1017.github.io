%% Nonlinear State Estimation of a Degrading Battery System
%
% This example shows how to estimate the states of a nonlinear system using
% an Unscented Kalman Filter in Simulink(TM). The example also illustrates
% how to develop an event-based Kalman Filter to update system parameters
% for more accurate state estimation. This example also requires
% Simscape(TM) and Stateflow(R).

% Copyright 2016-2017 The MathWorks, Inc.

%% Overview
% Consider a battery model with the following equivalent circuit [1]
%
% <<../batteryEquivalentCircuit.jpg>> 
%
% The model consists of a voltage source $E_m$, a series resistor $R_0$ and
% a single RC block with components $R_1$ and $C_1$. The battery alternates
% between charging and discharging cycles. In this example, you estimate
% the state of charge (SOC) of the battery model using measured currents,
% voltages, and temperature of the battery. You assume the battery is a
% nonlinear system, and estimate the SOC using an Unscented Kalman Filter.
% The capacity of the battery degrades with every discharge-charge cycle,
% giving an inaccurate SOC estimation. You use an event-based linear Kalman
% filter to estimate the battery capacity when the battery transitions
% between charging and discharging. You then use the estimated capacity to
% indicate the health condition of the battery.

%%
% The Simulink model contains three major components: a battery model,
% an Unscented Kalman Filter block and an event-based Kalman Filter block.
open_system('BatteryExampleUKF/')

%% Battery Model
% The battery model with thermal effect is implemented using Simscape software.
%
% <<../batteryMdl.jpg>> 

%%
% The state transition equations for the battery model are given by:
% 
% $$ \frac{d}{dt} \left( 
% \begin{array}{cc} 
%   SOC \\ 
%   U_{1} 
% \end{array} \right) = \left(
% \begin{array}{cc} 
%   0 \\ 
%   -\frac{1}{R_1(SOC,T_b)*C_1(SOC,T_b)}U_1 
% \end{array} \right) + \left(
% \begin{array}{cc} 
%   -\frac{1}{3600*C_q} \\ 
%   \frac{1}{C_1(SOC,T_b)}\end{array} \right)I 
% + W
% $$
% 
% where $R_1(SOC,T_b)$ and $C_1(SOC,T_b)$ are the thermal and SOC-dependent
% resistor and capacitor in the RC block, $$ U_1 $$ is the voltage across
% capacitor $C_1$, $I$ is the input current, $T_b$ is the battery
% temperature, $C_q$ is the battery capacity (unit: Ah), and $W$ is
% the process noise.
% 
% The input currents are randomly generated pulses when the battery is discharging and
% constant when the battery is charging.
%
% <<../batteryDischargeChargeCurve.jpg>>

%%
% The measurement equation is given by:
%
% $$ \begin{array} {ll}
% E = E_m(SOC,T_b) - U_1 - IR_0(SOC,T_b) + V
% \end{array} $$
%
% where $E$ is the measured output voltage, $R_0(SOC,T_b)$ is the serial
% resistor, $E_m = E_m(SOC,T_b)$ is the electromotive force from voltage
% source, and $V$ is the measurement noise.
%
% In the model, $R_0, R_1, C_1$ and $E_m$ are 2D look-up tables that are
% dependent on SOC and battery temperature. The parameters in the look-up
% tables are identified using experimental data [1].

%% Estimate State of Charge (SOC)
% To use the Unscented Kalman Filter block, you specify the measurement and
% state transition functions using either Matlab or Simulink functions.
% This example demonstrates the use of Simulink functions. Since Unscented
% Kalman Filters are discrete-time filters, first discretize the state
% equations. In this example, Euler discretization is employed. Let the
% sampling time be $$ Ts $$. For a general nonlinear system $\dot{x} =
% f(x,u)$, the system can be discretized as: 
%
% $x_{T+1} = x_{T} + f(x_{T},u_{T})*Ts$

%%
% The state vectors of the nonlinear battery system are:
%
% $$ 
% x_T = \left( 
% \begin{array}{cc}
%   SOC_T \\ 
%   U_{1_T} 
% \end{array} \right) 
% $$.
% 
% Applying Euler discretization gives the following equations:
%
% $$ 
% \left(
% \begin{array}{cc} 
%   SOC_{T+1} \\ 
%   U_{1_{T+1}} 
% \end{array} \right) = \left( 
% \begin{array}{cc} 
%   SOC_{T} \\ 
%   U_{1_{T}} 
% \end{array} \right) + \left(
% \begin{array}{cc} 
%   -\frac{1}{3600*C_q}I \\ 
%   -\frac{1}{R_1(SOC_T,T_b)*C_1(SOC_T,T_b)}U_1+\frac{1}{C_1(SOC_T,T_b)} I
% \end{array} \right)Ts 
% + W_T 
% $$ 
%
% The discretized state transition equation is implemented in the Simulink
% function named |batteryStateFcn|. The function input |x| is the state
% vector, and the function output |xNext| is the state vector at the next
% step, calculated using the discretized state transition equations. In the
% function, you need to specify the signal dimensions and data type of |x|
% and |xNext|. In this example, the signal dimension for |x| and |xNext| is
% 2, and the data type is double. Additional inputs to |batteryStateFcn|
% are the temperature, estimated capacity, and current. Note that the
% additional inputs are inputs to the state transition equations and are not
% required by the Unscented Kalman Filter block.
%
% <<../stateEqn.jpg>>

%%
% Similarly, the measurement function is also implemented in the Simulink
% function named |batteryMeasurementFcn|.
%
% <<../measurementEqn.jpg>>

%%
% Configure the Unscented Kalman Filter block parameters as follows:
%
% In the *System Model* tab, specify the block parameters as shown:
%
% <<../blockParametersUKF.jpg>>
%
% You specify the following parameters:
%
% * *Function in State Transition:* |batteryStateFcn|.
% 
% The name of the simulink function defined previously that implements the
% discretized state transition equation.
%
% * *Process noise:* |Additive|, with time-invariant covariance   
% $\left[ 
% \begin{array}{cc}
%   2e-8 & 0 \\ 
%   0 & 3e-7 
% \end{array} \right]$. |Additive| implies that the noise term is added to the
% final signals directly.
%
%%
% The process noise for SOC and $U_1$ are estimated based on the dynamic
% characteristics of the battery system. The battery has a nominal capacity of 30
% Ah and undergoes either discharge or charge cycles at an average current amplitude
% of 15A. Therefore, one discharging or charging process would take around
% 2 hours (7200 seconds). The maximum change is 100% for SOC and
% around 4 volts for $U_1$.
%
% The maximum changes per step in SOC and $U_1$ are $max(|dSOC|) \approx
% \frac{100\%}{3600*2}*Ts$ and $max(|dU_1|) \approx \frac{4}{3600*2}*Ts$,
% where $T_s$ is the sampling time of the filter. In this example, $T_s$ is
% set to be 1 second.
% 
% Thus, the process noise $W$ is:
% 
% $$ W = \left[ 
% \begin{array}{cc} 
%   (max(|dSOC|))^2 & 0 \\ 
%   0 & (max(|dU_1|))^2
% \end{array} \right] \approx \left[ 
% \begin{array}{cc} 
%   2e-8 & 0 \\ 
%   0 & 3e-7 
% \end{array} \right] $$.

%%
% * *Initial State*: 
% $$ \left(
% \begin{array}{cc} 
%   1 \\ 
%   0 
% \end{array} \right) $$.
%
% The initial value for SOC is assumed to be 100% (fully charged battery)
% while initial value for $U_1$ is set to be 0, as we do not have any
% prior information of $U_1$.
%
% * *Initial Covariance*: 
%
% Initial covariance indicates how accurate and reliable the initial guesses are. Assume
% the maximum initial guess error is 10% for SOC and 1V for $U_1$. The
% initial covariance matrix is set to be  
% $$ \left[ \begin{array}{cc}
%   0.01 & 0 \\ 
%   0 & 1 
% \end{array} \right] $$.
%
% * *Unscented Transformation Parameters*: The parameter are specified based on [2]
%
%       - Alpha: 1. Determine the spread of sigma points around x. Set Alpha to be 1 for larger spread.
%       - Beta: 2. Used to incorporate prior knowledge of the distribution. The nominal value for Beta is 2.
%       - Kappa: 0. Secondary scaling parameter. The nominal value for Kappa is 0.
%
% * *Function in Measurement:* |batteryMeasurementFcn|.
%
% The name of the Simulink function defined previously that implements the
% measurement function.
%
% * *Measurement noise:* |Additive|, with time-invariant covariance 1e-3.
%
% The measurement noise |V| is estimated based on measurement equipment
% accuracy. A voltage meter for battery voltage measurement has
% approximately 1% accuracy. The battery voltage is around 4V.
% Equivalently, we have $max(dE_m) \approx 4*1\% = 0.04$. Therefore, $V =
% (max(dE_m))^2 \approx 1e-3$.
%
% * *Sample Time*:  $Ts$.

%% Estimate Battery Degradation
% The battery degradation is modeled by decreasing capacity $C_q$. In
% this example, the battery capacity is set to decrease 1 Ah per discharge-charge
% cycle to illustrate the effect of degradation. Since the degradation rate of capacity is
% not known in advance, set the state equation of $$ C_q $$ to a random walk:
%
% $C_{q_{k+1}} = C_{q_k} + W_{C_q}$,
% 
% where $k$ is the number of discharge-charge cycles, and $W_{C_q}$ is the process
% noise.
% 
% The battery is configured to automatically charge when the capacity is at 30%
% and switch to discharging when the capacity is 90%. Use this information to
% measure the battery capacity by integrating the current $I$ over a charge
% or discharge cycle (coulomb counting).
%
% The measurement equation for $C_q$ is:
%
% $$ C_{q_k}^{Measured} = C_{q_k} + V_{C_q} =
% \frac{\int_{t_{k-1}}^{t_k}{I}dt}{(\Delta SOC)_{nominal}}
% =\frac{\int_{t_{k-1}}^{t_k}{I}dt}{|0.9-0.3|}=
% \frac{\int_{t_{k-1}}^{t_k}{I}dt}{0.6}$$
% 
% where $V_{C_q}$ is the measurement noise. 
% 
% The state transition and measurement equations of battery degradation can be put into
% the following state-space form:
%
% $$ C_{q_{k+1}} = A_{C_q} C_{q_k} + W_{C_q} $$
%
% $$ C_{q_k}^{Measured} = C_{C_q} C_{q_k} + V_{C_q} $$
%
% where $A_{C_q}$ and $C_{C_q}$ are equal to 1.
%
% For the above linear system, use a Kalman Filter to estimate battery
% capacity. The estimated $C_q$ from the linear Kalman Filter is used to
% improve SOC estimation. In the example, an event-based linear Kalman
% filter is used to estimate $C_q$. Since $C_q$ is measured once over a
% charge or discharge cycle, the linear Kalman Filter is enabled only when
% charging or discharging ends.
%
%% 
% Configure the block parameters as follows:
%
% <<../blockSettingKF.jpg>>
%
%%
% In the *Model Parameters* tab, specify the plant model and noise
% characteristics:
%
% * *Model source:* |Input Port|. 
%
% To implement an event-based Kalman Filter, the state equation is enabled
% only when the event happens. In other word, the state equation is
% event-based as well. For a linear system $x_{t+1} = Ax_t + Bu_t + w_t$, set the
% state equation to be
%
% $$ x_{t+1} = \left \{ \begin{array}{cc}
%               Ax_t + Bu_t + w_t, t=t_{enabled} \\ 
%               x_t, t \neq t_{enabled}
%               \end{array} \right. $$. 
%
%
% * *A*: $$ \left \{ \begin{array}{cc}
%               A_{C_q}, t=t_{enabled} \\ 
%               1, t \neq t_{enabled}
%           \end{array} \right. $$. 
%  In this example, $A_{C_q}=1$. Therefore, $A$ equals to 1 all the time.
%
% * *C*: 1, from $C_{q_k}^{Measured} = C_{q_k} + V_{C_q} =
% \frac{\int_{t_{k-1}}^{t_k}{I}dt}{0.6}$.
%
% * *Initial Estimate Source*: |Dialog|. You specify initial states in
% |Initial state x[0]|
%
% * *Initial states x[0]*: 30. This is the nominal capacity of the battery
% (30Ah).
%
% * *Q*: $$ \left \{ \begin{array}{cc}
%               1, t=t_{enabled} \\ 
%               0, t \neq t_{enabled}
%           \end{array} \right. $$
%
% This is the covariance of the process noise $W_{C_q}$. Since the degradation
% rate in the capacity is around 1 Ah per discharge-charge cycle, set the
% process noise to be 1.
%
% * *R*: 0.1. This is the covariance of the measurement noise $V_{C_q}$.
% Assume that the capacity measurement error is less than 1%. With a battery
% capacity of 30 Ah, the measurement noise $V_{C_q} \approx (0.3)^2 \approx
% 0.1$.
%
% * *Sample Time*:  Ts.
%
% In the *Options* tab, add an input port |Enable| to control measurement
% updates. The enable port is used to update the battery capacity estimate
% on either charge or discharge events, as opposed to continually updating.
%
% Note that setting |Enable| to 0 does not disable predictions using state
% equations. Therefore, the state equation is configured to be
% event-based as well. By setting an event-based A and Q for the Kalman
% Filter block, predictions using state equations are disabled when
% |Enable| is set to be 0.

%% Results
% To simulate the system, load the battery parameters stored in the file
% |BatteryParameters.mat|. The file contains the battery parameters
% including $E_m(SOC,T)$, $R_0(SOC,T)$, $R_1(SOC,T)$.
load BatteryParameters.mat

%%
% Simulate the system.
sim('BatteryExampleUKF')

%%
% At every time step, the Unscented Kalman Filter provides an
% estimation for SOC, based on voltage measurements $E_m$. Plot the real
% SOC, the estimated SOC, and the difference between them.

% Synchronize two time series
[RealSOC, EstimatedSOC] = synchronize(RealSOC, EstimatedSOC, 'intersection');

figure;
subplot(2,1,1)
plot(100*RealSOC,'b','LineWidth',1.5);
hold on
plot(100*EstimatedSOC,'r--','LineWidth',1);
title('State of Charge');
xlabel('Time (s)');
ylabel('SOC (%)');
legend('Actual','UKF estimate','Location','Best','Orientation','horizontal');
axis tight

subplot(2,1,2)
DiffSOC = 100*(RealSOC - EstimatedSOC);
plot(DiffSOC.Time, DiffSOC.Data, 'LineWidth', 1.5);
xlabel('Time(s)');
ylabel('\Delta SOC (%)','Interpreter','Tex');
legend('Difference between Real SOC and Estimated SOC','Location','Best')
axis tight

%%
% After an initial estimation error, the SOC converges quickly
% to the real SOC. The final estimation error is within 0.5% error. Thus, the
% Unscented Kalman Filter gives an accurate estimation of SOC.

%% 
% At every discharge-charge transition, the battery capacity is estimated
% to improve the SOC estimation. The battery system outputs indicator signals
% to inform what process the battery is in. Discharging process is
% represented by -1 in the indicator signals while charging process is
% represented by 1. In this example, changes in the indicator signals are
% used to determine when to enable or disable Kalman Filter for capacity
% estimation. We plot the real and estimated capacity as well as the
% charge-discharge indicator signals.

figure;
subplot(2,1,1);
plot(RealCapacity,'b','LineWidth',1.5);
hold on
plot(EstimatedCapacity,'r--','LineWidth',1.5);
xlabel('Time (s)');
ylabel('Capacity (Ah)');
legend('Actual','KF estimate','Location','Best');

subplot(2,1,2);
plot(DischargeChargeIndicator.Time,DischargeChargeIndicator.Data,'b','LineWidth',1.5);
xlabel('Time(s)');
ylabel('Enable Signal');

%%
% In general, the Kalman Filter is able to track the real capacity. There
% is half cycle delay between estimated capacity and real capacity. This is
% because the battery capacity degradation happens when one full
% discharge-charge cycle ends. While the coulomb counting gives a capacity
% measurement of the last discharge or charge cycle.

%% Summary
% This example shows how to use the Unscented Kalman Filter block to
% perform nonlinear state estimation for a lithium battery. In addition,
% steps to develop an event-based Kalman Filter for battery capacity
% estimation are illustrated. The newly estimated capacity is used to
% improve SOC estimation in the Unscented Kalman Filter.

%% Reference
% [1] Huria, Tarun, et al. "High fidelity electrical model with thermal
% dependence for characterization and simulation of high power lithium
% battery cells." Electric Vehicle Conference (IEVC), 2012 IEEE
% International. IEEE, 2012. 
%
% [2] Wan, Eric A., and Rudolph Van Der Merwe. "The unscented Kalman filter
% for nonlinear estimation." Adaptive Systems for Signal Processing,
% Communications, and Control Symposium 2000. AS-SPCC. The IEEE 2000. Ieee,
% 2000.