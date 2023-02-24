function main()
data = createData();
gui = createInterface(data.DemoNames);
a = 1;
    function data = createData()
        % Create the shared data-structure for this application
        demoList = {
            'Complex surface'            'cplxdemo'
            'Cruller'                    'cruller'
            'Earth'                      'earthmap'
            'Four linked tori'           'tori4'
            'Klein bottle'               'xpklein'
            'Klein bottle (1)'           'klein1'
            'Knot'                       'knot'
            'Logo'                       'logo'
            'Spherical Surface Harmonic' 'spharm2'
            'Werner Boy''s Surface'      'wernerboy'
            };
        selectedDemo = 8;
        data = struct( ...
            'DemoNames', {demoList(:,1)'}, ...
            'DemoFunctions', {demoList(:,2)'}, ...
            'SelectedDemo', selectedDemo);
    end

    function gui = createInterface( demoList )
        % Create the user interface for the application and return a
        % structure of handles for global use.
        gui = struct();

        % Open a window and add some menus
        gui.Window = figure( ...
            'Name', 'Gallery browser', ...
            'NumberTitle', 'off', ...
            'MenuBar', 'none', ...
            'Toolbar', 'none', ...
            'HandleVisibility', 'off' );

        % + File menu
        gui.FileMenu = uimenu(gui.Window,'Label','File');
        uimenu(gui.FileMenu,'Label','Exit','Callback',@onExit);

        % + View menu
        gui.ViewMenu = uimenu(gui.Window,'Label','View');
        for num = 1:numel(demoList)
            uimenu(gui.ViewMenu,'Label',demoList{num},'Callback',@onMenuSelection);
        end
        
        % + Help menu
        helpMenu = uimenu(gui.Window,'Label','Help');
        uimenu(helpMenu,'Label','Documentation','Callback',@onHelp);

        % Arrange the main interface
        mainLayout = uix.HBoxFlex('Parent',gui.Window,'Spacing',3);

        % + Create the panels
        controlPanel = uix.BoxPanel( ...
            'Parent',mainLayout, ...
            'Title','Select a demo:' );
        gui.ViewPanel = uix.BoxPanel( ...
            'Parent',mainLayout, ...
            'Title','Viewing: ???', ...
            'HelpFcn',@onDemoHelp);
        gui.ViewContainer = uicontainer( ...
            'Parent',gui.ViewPanel);

        % + Adjust the main layout
        set(mainLayout,'Widths',[-1,-2]);

        % + Create the controls
        controlLayout = uix.VBox('Parent',controlPanel, ...
            'Padding',3,'Spacing',3);
        gui.ListBox = uicontrol('Style','list', ...
            'BackgroundColor','w', ...
            'Parent',controlLayout, ...
            'String',demoList(:), ...
            'Value',1, ...
            'Callback',@onListSelection);
        gui.HelpButton = uicontrol('Style','PushButton', ...
            'Parent',controlLayout, ...
            'String', 'Help for <demo>', ...
            'Callback', @onDemoHelp);
        set(controlLayout,'Heights',[-1 28]); % Make the list fill the space

        % + Create the view
        gui.ViewAxes = axes('Parent',gui.ViewContainer);
    end
end
