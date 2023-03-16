%% PicoScope 4000 Series (A API) Instrument Driver Oscilloscope Signal Generator Example
% *Copyright:* © 2014-2018 Pico Technology Limited. See |LICENSE| file for terms.
clc,clear,close all

PS4000aConfig;

if (exist('ps4000aDeviceObj', 'var') && ps4000aDeviceObj.isvalid && strcmp(ps4000aDeviceObj.status, 'open'))
    openDevice = questionDialog(['Device object ps4000aDeviceObj has an open connection. ' ...
        'Do you wish to close the connection and continue?'], ...
        'Device Object Connection Open');
    if (openDevice == PicoConstants.TRUE)
        % Close connection to device
        disconnect(ps4000aDeviceObj);
        delete(ps4000aDeviceObj);
    else
        % Exit script if User
        return;
    end
end
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic.mdd', '');
connect(ps4000aDeviceObj);

%% Obtain signal generator group object
sigGenGroupObj = get(ps4000aDeviceObj, 'Signalgenerator');
sigGenGroupObj = sigGenGroupObj(1);

%% Function generator - simple
[status.setSigGenBuiltInSimple] = invoke(sigGenGroupObj, 'setSigGenBuiltInSimple', 0);

%% Function generator - sweep frequency
set(ps4000aDeviceObj.Signalgenerator(1), ...
    'startFrequency', 50.0, ...
    'stopFrequency', 500.0, ...
    'offsetVoltage', 500.0, ...
    'peakToPeakVoltage', 2400.0);
% Execute device object function(s).
% Wavetype       : 1 (ps4000aEnuminfo.enPS4000AWaveType.PS4000A_SQUARE)
% Increment      : 50.0 (Hz)
% Dwell Time     : 1 (s)
% Sweep Type     : 1 (ps4000aEnuminfo.enPS4000ASweepType.PS4000A_DOWN)
% Operation      : 0 (ps4000aEnuminfo.enPS4000AExtraOperations.PS4000A_ES_OFF)
% Shots          : 0
% Sweeps         : 0
% Trigger Type   : 0 (ps4000aEnuminfo.enPS4000ASigGenTrigType.PS4000A_SIGGEN_RISING)
% Trigger Source : 0 (ps4000aEnuminfo.enPS4000ASigGenTrigSource.PS4000A_SIGGEN_NONE)
% Ext. Threshold : 0
[status.setSigGenBuiltIn] = invoke(sigGenGroupObj, 'setSigGenBuiltIn', 1, 50.0, 1, 1, 0, 0, 0, 0, 0, 0);
%% Turn off signal generator
[status.setSigGenOff] = invoke(sigGenGroupObj, 'setSigGenOff');

%% Arbitrary waveform generator - set parameters
% Set parameters (2000 mV p-p, 0 mV offset, 2000 Hz frequency) and define an arbitrary waveform.
% Set Signalgenerator group properties
set(ps4000aDeviceObj.Signalgenerator(1), ...
    'startFrequency', 2000.0, ...
    'stopFrequency', 2000.0, ...
    'offsetVoltage', 0.0, ...
    'peakToPeakVoltage', 2000.0);

%% Define an Arbitrary Waveform - values must be in the range -1 to +1.
awgBufferSize = get(sigGenGroupObj, 'awgBufferSize'); % Obtain the buffer size for the AWG
x = 0: ((2 * pi) / (awgBufferSize - 1)): 2 * pi;
y = normalise(sin(x) + sin(2 * x));

%% Arbitrary waveform generator - simple
% Output an arbitrary waveform with constant frequency (defined above).
% Arb. Waveform : y (defined above)
[status.setSigGenArbitrarySimple] = invoke(sigGenGroupObj, 'setSigGenArbitrarySimple', y);

%% Turn off signal generator
[status.setSigGenOff] = invoke(sigGenGroupObj, 'setSigGenOff');

%% Arbitrary waveform generator - output shots
% Output 2 cycles of an arbitrary waveform using a software trigger.
% Increment      : 0 (Hz)
% Dwell Time     : 1 (s)
% Arb. Waveform  : y (defined above)
% Sweep Type     : 0 (ps4000aEnuminfo.enPS4000ASweepType.PS4000A_UP)
% Operation      : 0 (ps4000aEnuminfo.enPS4000AExtraOperations.PS4000A_ES_OFF)
% indexMode      : 0
% Shots          : 2
% Sweeps         : 0
% Trigger Type   : 0 (ps4000aEnuminfo.enPS4000ASigGenTrigType.PS4000A_SIGGEN_RISING)
% Trigger Source : 4 (ps4000aEnuminfo.enPS4000ASigGenTrigSource.PS4000A_SIGGEN_SOFT_TRIG)
% Ext. Threshold : 0
[status.setSigGenArbitrary] = invoke(sigGenGroupObj, 'setSigGenArbitrary', 0, 1, y, 0, 0, 0, 2, 0, 0, 4, 0);

%% Display signals
channelA = ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A;

% All channels are enabled by default - switch off all except Channels A and B. 
% Channel A
channelSettings(1).enabled          = PicoConstants.TRUE; % 1
channelSettings(1).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;% 1
channelSettings(1).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;% 7
channelSettings(1).analogueOffset   = 0.0;

% Channel B
channelSettings(2).enabled          = PicoConstants.FALSE;
channelSettings(2).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(2).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(2).analogueOffset   = 0.0;

% Channel C
channelSettings(3).enabled          = PicoConstants.FALSE;
channelSettings(3).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(3).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(3).analogueOffset   = 0.0;

% Channel D
channelSettings(4).enabled          = PicoConstants.FALSE;
channelSettings(4).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(4).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(4).analogueOffset   = 0.0;

% Channel E
channelSettings(5).enabled          = PicoConstants.FALSE;
channelSettings(5).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(5).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(5).analogueOffset   = 0.0;

% Channel F
channelSettings(6).enabled          = PicoConstants.FALSE;
channelSettings(6).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(6).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(6).analogueOffset   = 0.0;

% Channel G
channelSettings(7).enabled          = PicoConstants.FALSE;
channelSettings(7).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(7).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(7).analogueOffset   = 0.0;

% Channel H
channelSettings(8).enabled          = PicoConstants.FALSE;
channelSettings(8).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;
channelSettings(8).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;
channelSettings(8).analogueOffset   = 0.0;

% Obtain the number of analog channels on the device from the driver
numChannels = get(ps4000aDeviceObj, 'channelCount');

for ch = 1:numChannels
    status.setChannelStatus(ch) = invoke(ps4000aDeviceObj, 'ps4000aSetChannel', ...
        (ch - 1), channelSettings(ch).enabled, ...
        channelSettings(ch).coupling, channelSettings(ch).range, ...
        channelSettings(ch).analogueOffset);
end

% Obtain the range and units for each enabled channel. For the PicoScope 4824, this will be in millivolts.
[chARange, chAUnits] = invoke(ps4000aDeviceObj, 'getChannelInputRangeAndUnits', ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A);
maxADCCount = double(get(ps4000aDeviceObj, 'maxADCValue'));

overviewBufferSize  = 250000*2; % Size of the buffer(s) to collect data from the driver's buffer(s).
segmentIndex        = 0;   
ratioMode           = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE;

% Buffers to be passed to the driver
pDriverBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1,'int16'));

status.setDataBufferChA = invoke(ps4000aDeviceObj, 'ps4000aSetDataBuffer', ...
    channelA, pDriverBufferChA, overviewBufferSize, segmentIndex, ratioMode);% status.setDataBufferChA = 0;

% Application Buffers - these are for temporarily copying data from the driver.
pAppBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1));

% Streaming properties and functions are located in the Instrument Driver's Streaming group.
streamingGroupObj = get(ps4000aDeviceObj, 'Streaming');
streamingGroupObj = streamingGroupObj(1);

% Register application buffer and driver buffers (with the wrapper driver).
status.setAppAndDriverBuffersA = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelA, ...
    pAppBufferChA, pDriverBufferChA, overviewBufferSize);

set(ps4000aDeviceObj, 'numPreTriggerSamples', 0);
set(ps4000aDeviceObj, 'numPostTriggerSamples', 1000000);

% The autoStop parameter can be set to false (0).
set(streamingGroupObj, 'autoStop', PicoConstants.FALSE);

% Set other streaming parameters
downSampleRatio     = 1;
downSampleRatioMode = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE; % downSampleRatioMode = 0;

maxSamples = get(ps4000aDeviceObj, 'numPreTriggerSamples') + ...
    get(ps4000aDeviceObj, 'numPostTriggerSamples');

pBufferChAFinal = libpointer('int16Ptr',zeros(maxSamples,1,'int16'));

% Prompt User to indicate if they wish to plot live streaming data.
plotLiveData = questionDialog('Plot live streaming data?', 'Streaming Data Plot');
if (plotLiveData == PicoConstants.TRUE)
    disp('Live streaming data collection with second plot on completion.');
else
    disp('Streaming data plot on completion.');
end

% Start streaming data collection.
[status.runStreaming, actualSampleInterval, sampleIntervalTimeUnitsStr] = ...
    invoke(streamingGroupObj, 'ps4000aRunStreaming', downSampleRatio, ...
    downSampleRatioMode, overviewBufferSize);
    
disp('Streaming data collection...');
fprintf('Click the STOP button to stop capture or wait for auto stop if enabled.\n\n') 

% Variables to be used when collecting the data
isAutoStopSet       = PicoConstants.FALSE;
newSamples          = 0; % Number of new samples returned from the driver.
previousTotal       = 0; % The previous total number of samples.
totalSamples        = 0; % Total number of samples captured by the device.
startIndex          = 0; % Start index of data in the buffer returned (zero-based).
hasTriggered        = 0; % To indicate if trigger event has occurred.
triggeredAtIndex    = 0; % The index in the overall buffer where the trigger occurred (zero-based).

status.getStreamingLatestValues = PicoStatus.PICO_OK; % OK

% Display a 'Stop' button.
[~, stopFig.h] = stopButton(); % `stopButton` from PicoScope Support Toolbox        
             
flag = 1; % Use flag variable to indicate if the stop button has been clicked (0).
setappdata(gcf, 'run', flag);

% Plot Properties - these are for displaying data as it is collected. In
% this example, data is displayed in millivolts. 
if (plotLiveData == PicoConstants.TRUE)
    % Plot on a single figure 
    figure1 = figure('Name','PicoScope 4000 Series (A API) Example - Streaming Mode Capture', ...
         'NumberTitle','off');
     axes1 = axes('Parent', figure1);

    xlim(axes1, [0 (actualSampleInterval * maxSamples)]);

    yRange = max(chARange);
    ylim(axes1,[(-1 * yRange) yRange]);

    hold(axes1,'on');
    grid(axes1, 'on');

    title(axes1, 'Live Streaming Data Capture');
    xLabelStr = strcat('Time (', sampleIntervalTimeUnitsStr, ')');
    xlabel(axes1, xLabelStr);
    ylabel(axes1, getVerticalAxisLabel(chAUnits));
end

% Collect samples as long as the autoStop flag has not been set or the call
% to getStreamingLatestValues does not return an error code (check for STOP
% button push inside loop).

% Trigger the AWG, State : 1
[status.sigGenSoftwareControl] = invoke(sigGenGroupObj, 'ps4000aSigGenSoftwareControl', 1);

while (isAutoStopSet == PicoConstants.FALSE && status.getStreamingLatestValues == PicoStatus.PICO_OK)
    ready = PicoConstants.FALSE; % PicoConstants.FALSE = 0;
   
    while (ready == PicoConstants.FALSE)
       status.getStreamingLatestValues = invoke(streamingGroupObj, 'getStreamingLatestValues');

       % Chek whether ready
       ready = invoke(streamingGroupObj, 'isReady');

       % Give option to abort from here
       flag = getappdata(gcf, 'run');
       drawnow;
       
       if (flag == 0)
            disp('STOP button clicked - aborting data collection.')
            break
       end

       if (plotLiveData == PicoConstants.TRUE)
            drawnow;
       end
    end
    
    % Check for new data values
    [newSamples, startIndex] = invoke(streamingGroupObj, 'availableData');

    if (newSamples > 0)
        % Check if the scope has triggered
        [triggered, triggeredAt] = invoke(streamingGroupObj, 'isTriggerReady');

        if (triggered == PicoConstants.TRUE)
            % Adjust trigger position as MATLAB does not use zero-based indexing.
            bufferTriggerPosition = triggeredAt + 1;
            fprintf('Triggered - index in buffer: %d\n', bufferTriggerPosition);
            hasTriggered = triggered;

            % Set the total number of samples at which the device triggered.
            triggeredAtIndex = totalSamples + bufferTriggerPosition;
        end

        previousTotal = totalSamples;
        totalSamples  = totalSamples + newSamples;

        % Printing to console can slow down acquisition - use for demonstration.
        fprintf('Collected %d samples, startIndex: %d total: %d.\n', newSamples, startIndex, totalSamples);
        
        % Position indices of data in the buffer(s).
        firstValuePosn = startIndex + 1;
        lastValuePosn = startIndex + newSamples;
        
        % Convert data values from the application buffer(s) - in this example
        bufferChAmV = adc2mv(pAppBufferChA.Value(firstValuePosn:lastValuePosn),chARange,maxADCCount);

        % Copy data into the final buffer(s).
        pBufferChAFinal.Value(previousTotal + 1:totalSamples) = bufferChAmV;
        
        if (plotLiveData == PicoConstants.TRUE)
            % Time axis
            % Multiply by ratio mode as samples get reduced.
            time = (double(actualSampleInterval) * double(downSampleRatio)) * (previousTotal:(totalSamples - 1));
            plot(time, bufferChAmV);
        end

        % Clear variables.
        clear bufferChAmV firstValuePosn lastValuePosn ...
            startIndex triggered triggerAt;
    end
   
    % Check if auto stop has occurred.
    isAutoStopSet = invoke(streamingGroupObj, 'autoStopped');
    if (isAutoStopSet == PicoConstants.TRUE)
       disp('AutoStop: TRUE - exiting loop.');
       break
    end
   
    % Check if 'STOP' button pressed.
    flag = getappdata(gcf, 'run');
    drawnow;
    if (flag == 0)
        disp('STOP button clicked - aborting data collection.')
        break
    end
end

% Close the STOP button window
if (exist('stopFig', 'var'))
    close('Stop Button');
    clear stopFig;
end

if (plotLiveData == PicoConstants.TRUE)
    drawnow
end

if (hasTriggered == PicoConstants.TRUE)
    fprintf('Triggered at overall index: %d\n', triggeredAtIndex);
end

if (plotLiveData == PicoConstants.TRUE)
    % Take hold off the current figure
    hold off;
    movegui(figure1, 'west');
end
fprintf('\n');

%% Turn off signal generator
% Sets the output to 0 V DC.
% [status.setSigGenOff] = invoke(sigGenGroupObj, 'setSigGenOff');   %  setSigGenOff:- Status code: 39. Please refer to the PicoStatus.m file.                                          

%% Disconnect device
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);