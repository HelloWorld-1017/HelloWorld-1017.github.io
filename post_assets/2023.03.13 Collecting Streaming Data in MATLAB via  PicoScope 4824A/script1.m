%% PicoScope 4000 Series (A API) Instrument Driver Oscilloscope Streaming Data Capture Example
clc, clear, close all

%% Load configuration information
PS4000aConfig;

%% Parameter definitions
% Define any parameters that might be required throughout the script.
channelA = ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_A;
channelB = ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_B;

%% Device connection
if (exist('ps4000aDeviceObj','var') && ps4000aDeviceObj.isvalid && strcmp(ps4000aDeviceObj.status,'open'))
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
ps4000aDeviceObj = icdevice('picotech_ps4000a_generic','ObjectVisibility','on'); 
% Connect device
connect(ps4000aDeviceObj);
%% Display unit information
[infoStatus, unitInfo] = invoke(ps4000aDeviceObj, 'getUnitInfo');

disp('Device information:-')
disp(unitInfo);
%% Channel setup
% All channels are enabled by default - switch off all except Channels A and B. 
% Channel A
channelSettings(1).enabled          = PicoConstants.TRUE; % 1
channelSettings(1).coupling         = ps4000aEnuminfo.enPS4000ACoupling.PS4000A_DC;% 1
channelSettings(1).range            = ps4000aEnuminfo.enPS4000ARange.PS4000A_2V;% 7
channelSettings(1).analogueOffset   = 0.0;

% Channel B
channelSettings(2).enabled          = PicoConstants.TRUE;
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
[chBRange, chBUnits] = invoke(ps4000aDeviceObj, 'getChannelInputRangeAndUnits', ps4000aEnuminfo.enPS4000AChannel.PS4000A_CHANNEL_B);

% Obtain the maximum Analog Digital Converter Count value from the driver
% - this is used for scaling values returned from the driver when data is
% collected.
maxADCCount = double(get(ps4000aDeviceObj, 'maxADCValue'));

%% Set data buffers
% Data buffers for Channel A and B - buffers should be set with the
% (lib)ps400a shared library, and these *MUST* be passed with application
% buffers to the wrapper shared library. This will ensure that data is
% correctly copied from the shared library buffers for later processing.

overviewBufferSize  = 250000*2; % Size of the buffer(s) to collect data from the driver's buffer(s).
segmentIndex        = 0;   
ratioMode           = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE;

% Buffers to be passed to the driver
pDriverBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1,'int16'));
pDriverBufferChB = libpointer('int16Ptr',zeros(overviewBufferSize,1,'int16'));

status.setDataBufferChA = invoke(ps4000aDeviceObj, 'ps4000aSetDataBuffer', ...
    channelA, pDriverBufferChA, overviewBufferSize, segmentIndex, ratioMode);% status.setDataBufferChA = 0;
status.setDataBufferChB = invoke(ps4000aDeviceObj, 'ps4000aSetDataBuffer', ...
   channelB, pDriverBufferChB, overviewBufferSize, segmentIndex, ratioMode);% status.setDataBufferChB = 0;

% Application Buffers - these are for temporarily copying data from the driver.
pAppBufferChA = libpointer('int16Ptr',zeros(overviewBufferSize,1));
pAppBufferChB = libpointer('int16Ptr',zeros(overviewBufferSize,1));

% Streaming properties and functions are located in the Instrument Driver's Streaming group.
streamingGroupObj = get(ps4000aDeviceObj, 'Streaming');
streamingGroupObj = streamingGroupObj(1);

% Register application buffer and driver buffers (with the wrapper driver).
status.setAppAndDriverBuffersA = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelA, ...
    pAppBufferChA, pDriverBufferChA, overviewBufferSize);
status.setAppAndDriverBuffersB = invoke(streamingGroupObj, 'setAppAndDriverBuffers', channelB, ...
   pAppBufferChB, pDriverBufferChB, overviewBufferSize);

%% Start streaming and collect data
% Use default value for streaming interval which is 1e-6 for 1 MS/s.
% Collect data for 1 second with auto stop. The maximum array size will
% depend on the PC's resources. For further information, type |memory| in
% the MATLAB Command Window and press Enter.
%
% To change the sample interval set the |streamingInterval| property of the
% |Streaming| group object. The call to |ps4000aRunStreaming()| will output the actual
% sampling interval used by the driver.

% For 200 kS/s, specify 5 us
%set(streamingGroupObj, 'streamingInterval', 5e-6);

% For 10 MS/s, specify 100 ns (0.1 us)
%set(streamingGroupObj, 'streamingInterval', 100e-9);

% Set the number of pre- and post-trigger samples
% If no trigger is set 'numPreTriggerSamples' is ignored
set(ps4000aDeviceObj, 'numPreTriggerSamples', 0);
set(ps4000aDeviceObj, 'numPostTriggerSamples', 1000000);

% The autoStop parameter can be set to false (0).
set(streamingGroupObj, 'autoStop', PicoConstants.FALSE);

% Set other streaming parameters
downSampleRatio     = 1;
downSampleRatioMode = ps4000aEnuminfo.enPS4000ARatioMode.PS4000A_RATIO_MODE_NONE; % downSampleRatioMode = 0;

% Defined buffers to store data collected from the channels.
% If capturing data without using the autoStop flag, or if using a trigger 
% with the autoStop flag, allocate sufficient space (1.5 times the size is 
% shown below) to allow for pre-trigger data. Pre-allocating the array is 
% more efficient than using vertcat to combine data.
maxSamples = get(ps4000aDeviceObj, 'numPreTriggerSamples') + ...
    get(ps4000aDeviceObj, 'numPostTriggerSamples');

% Take into account the downsampling ratio mode - required if collecting
% data without a trigger and using the autoStop flag. 
% finalBufferLength = round(1.5 * maxSamples / downSampleRatio);
pBufferChAFinal = libpointer('int16Ptr',zeros(maxSamples,1,'int16'));
pBufferChBFinal = libpointer('int16Ptr',zeros(maxSamples,1,'int16'));

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

    % Estimate x-axis limit to try and avoid using too much CPU resources
    % when drawing - use max voltage range selected if plotting multiple
    % channels on the same graph.
    xlim(axes1, [0 (actualSampleInterval * maxSamples)]);

    yRange = max(chARange, chBRange);
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
        bufferChBmV = adc2mv(pAppBufferChB.Value(firstValuePosn:lastValuePosn),chBRange,maxADCCount);

        % Process collected data further if required - this example plots
        % the data if the User has selected 'Yes' at the prompt.
        
        % Copy data into the final buffer(s).
        pBufferChAFinal.Value(previousTotal + 1:totalSamples) = bufferChAmV;
        pBufferChBFinal.Value(previousTotal + 1:totalSamples) = bufferChBmV;
        
        if (plotLiveData == PicoConstants.TRUE)
            % Time axis
            % Multiply by ratio mode as samples get reduced.
            time = (double(actualSampleInterval) * double(downSampleRatio)) * (previousTotal:(totalSamples - 1));
            plot(time, bufferChAmV, time, bufferChBmV);
        end

        % Clear variables.
        clear bufferChAmV bufferChBmV firstValuePosn lastValuePosn ...
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

%% Stop the device
% This function should be called regardless of whether the |autoStop|
% property is enabled or not.
status.stop = invoke(ps4000aDeviceObj, 'ps4000aStop');

%% Find the number of samples
% This is the number of samples held in the |(lib)ps4000a| shared library itself. The actual
% number of samples collected when using a trigger is likely to be greater.
[status.noOfStreamingValues, numStreamingValues] = invoke(streamingGroupObj, 'ps4000aNoOfStreamingValues');
fprintf('Number of samples available from the driver: %u.\n\n', numStreamingValues);

%% Process data
% Process all data if required

% Reduce size of arrays if required.
if (totalSamples < maxSamples)
    pBufferChAFinal.Value(totalSamples + 1:end) = [];
    pBufferChBFinal.Value(totalSamples + 1:end) = [];
end


% Retrieve data for the Channels.
channelAFinal = pBufferChAFinal.Value();
channelBFinal = pBufferChBFinal.Value();

% Plot the total data collected on another figure.
finalFigure = figure('Name','PicoScope 4000 Series (A API) Example - Streaming Mode Capture', ...
    'NumberTitle','off');
finalFigureAxes = axes('Parent', finalFigure);
hold(finalFigureAxes, 'on');

title('Streaming Data Capture (Final)');
xLabelStr = strcat('Time (', sampleIntervalTimeUnitsStr, ')');
xlabel(finalFigureAxes, xLabelStr);
ylabel(finalFigureAxes, 'Voltage (mV)');

% Find the maximum voltage range.
maxYRange = max(chARange, chBRange);
ylim(finalFigureAxes,[(-1 * maxYRange) maxYRange]);

% Calculated values for time axis, then plot.
timeAxis = (double(actualSampleInterval) * double(downSampleRatio)) * (0:length(channelAFinal) - 1);
plot(finalFigureAxes, timeAxis, channelAFinal, timeAxis, channelBFinal);

grid(finalFigureAxes, 'on');
legend(finalFigureAxes, 'Channel A', 'Channel B');
hold(finalFigureAxes, 'off');

movegui(finalFigureAxes, 'east');
%% Disconnect device
% Disconnect device object from hardware.
disconnect(ps4000aDeviceObj);
delete(ps4000aDeviceObj);