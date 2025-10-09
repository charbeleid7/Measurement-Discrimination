%Make sure to clear variables before running a second time, otherwise
%uncomment the next line (to avoid array size issues)
%clear

%samples (\samples-1)
a=100;
b=200;


% 0 for plotting measurement and instrument discrimination success probabilities,1 for plotting with instrument advantage
% (PLOT = 1 does not compute values at 0 to avoid floating point errors)
PLOT = 0;

% Non rotated Trine Measurement at \theta=0 , \phi=0
N(:,:,:,1) = ThreeOutQubitMeasChan(0,0);

% Choi operators corresponding respectively to the measurement chanel and instrument
% channel of the above measurement
G(:,:,1) = MeasChan(N(:,:,:,1));
C(:,:,1) = LudInstChan(N(:,:,:,1));

if PLOT == 0

    % Initializing Variables
    IvM=zeros(a+1,b+1);
    p_succM=zeros(a+1,b+1);
    p_succI=zeros(a+1,b+1);
    
    % Main Loop
    for i = 0:a
        for j = 0:b
    
        %update \theta and \phi variables
        theta(i+1) = (i)*2*pi/(a);
        phi(j+1) = (j)*pi/(b);

        %progress percentage
        prog =   100 *(i*(b+1) + j+1)/((a+1)*(b+1)) ;
        clc;
        fprintf('Current Progress: %.3f %% \n', prog);
        
        % Rotated Measurement
        N(:,:,:,2) = ThreeOutQubitMeasChan(theta(i+1),phi(j+1));

        %Corresponding Choi operators
        C(:,:,2) = LudInstChan(N(:,:,:,2));
        G(:,:,2) = MeasChan(N(:,:,:,2));
        
        % Instrument Discrimination Success Probability  
        [~,p_succI(i+1,j+1)]=Nchannels_1copy_discriminationexample(C, [2,6]);
        % Measurement Discrimination Success Probability 
        [~,p_succM(i+1,j+1)]=Nchannels_1copy_discriminationexample(G, [2,3]);
        end
    end

    %Instrument advantage (Not ploted, may have floating point error at 0)
    IvM = (p_succI-0.5)./(p_succM-0.5);
    
    

    %plot:
    % Create grid
    [Theta, Phi] = meshgrid(theta, phi);  
    
    % Plot Instrument discrimination success probability
    figure(1);
    surf(Theta, Phi, p_succI');
    shading interp;
    

    % Color map settings (custom color map) (for Instrument Discrimination)
    nColors = 256;
    nBands = 11;
    bandWidth = 0.2;        % very thin lines
    darkIntensity = 0.85;   % strong darkening
    boneMap = bone(nColors);
    bandCenters = round(linspace(1, nColors, nBands));
    darkMask = zeros(nColors,1);
    x = (1:nColors)';       % vectorized x
    for i = 1:nBands
        idx = bandCenters(i);
        darkMask = darkMask + exp(-((x - idx).^2)/(2*bandWidth^2));
    end
    darkMask = darkMask / max(darkMask);
    finalMap = boneMap .* (1 - darkIntensity*darkMask);
    colormap(finalMap);
    colorbar;
    
    % Plot styling (for Instrument Discrimination)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';
    ax.TickDir = 'out';
    ax.TickLength = [0.015 0.015];
    xlim(ax, [0 6.29]);
    ylim(ax, [0 3.15]);

     % Set axis ticks and labels in radians
    xticks([0 pi/2 pi 3*pi/2 2*pi]);
    xticklabels({'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'});

    yticks([0 pi/4 pi/2 3*pi/4 pi]);
    yticklabels({'$0$', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'});

    set(gca, 'TickLabelInterpreter', 'latex');
    
    title('Success Probability of Dichotomic Trine Insrument Discrimination','Interpreter', 'latex', 'FontSize', 30);

    
    % Plot labels (for Instrument Discrimination)
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$\phi$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$P_{Inst}$', 'Interpreter', 'latex', 'FontSize', 30);
   
    % Graph orientation (for Instrument Discrimination)
    view(0, 90);


    % Plot Measurement discrimination success probability
    figure(2);
    surf(Theta, Phi, p_succM');
    shading interp;
    

    % Color map settings (custom color map) (for Measurement Discrimination)
    nColors = 256;
    nBands = 11;
    bandWidth = 0.2;        % very thin lines
    darkIntensity = 0.85;   % strong darkening
    boneMap = bone(nColors);
    bandCenters = round(linspace(1, nColors, nBands));
    darkMask = zeros(nColors,1);
    x = (1:nColors)';       % vectorized x
    for i = 1:nBands
        idx = bandCenters(i);
        darkMask = darkMask + exp(-((x - idx).^2)/(2*bandWidth^2));
    end
    darkMask = darkMask / max(darkMask);
    finalMap = boneMap .* (1 - darkIntensity*darkMask);
    colormap(finalMap);
    colorbar;
    
    % Plot styling (for Measurement Discrimination)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';
    ax.TickDir = 'out';
    ax.TickLength = [0.015 0.015];
    xlim(ax, [0 6.29]);
    ylim(ax, [0 3.15]);

     % Set axis ticks and labels in radians
    xticks([0 pi/2 pi 3*pi/2 2*pi]);
    xticklabels({'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'});

    yticks([0 pi/4 pi/2 3*pi/4 pi]);
    yticklabels({'$0$', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'});

    set(gca, 'TickLabelInterpreter', 'latex');


    title('Success Probability of Dichotomic Trine Measurement Discrimination','Interpreter', 'latex', 'FontSize', 30);

    
    % Plot labels (for Measurement Discrimination)
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$\phi$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$P_{Meas}$', 'Interpreter', 'latex', 'FontSize', 30);
   
    % Graph orientation (for Instrument Discrimination)
    view(0, 90);

elseif PLOT == 1

    % Initializing Variables
    p_succM=zeros(a,b);
    p_succI=zeros(a,b);
    
    % Main Loop (starts at 1 to avoid floating point errors in IvM)
    for i = 1:a
        for j = 1:b
    
        %update \theta and \phi variables
        theta(i) = (i)*2*pi/(a);
        phi(j) = (j)*pi/(b);

        %progress percentage
        prog =   100 * ( (i-1)*(b) + j)/((a)*(b)) ;
        clc;
        fprintf('Current Progress: %.3f %% \n', prog);
        
        % Rotated Measurement
        N(:,:,:,2) = ThreeOutQubitMeasChan(theta(i),phi(j));

        %Corresponding Choi operators
        C(:,:,2) = LudInstChan(N(:,:,:,2));
        G(:,:,2) = MeasChan(N(:,:,:,2));
        
        % Instrument Discrimination Success Probability  
        [~,p_succI(i,j)]=Nchannels_1copy_discriminationexample(C, [2,6]);
        % Measurement Discrimination Success Probability 
        [~,p_succM(i,j)]=Nchannels_1copy_discriminationexample(G, [2,3]);
        end
    end

    %Instrument advantage
    IvM = (p_succI-0.5)./(p_succM-0.5);

    %plot:
    % Create grid
    [Theta, Phi] = meshgrid(theta, phi);  
    
    % Plot Instrument Advantage success probability
    figure(1);
    surf(Theta, Phi, IvM');
    shading interp;
    

    % Color map settings (custom color map) (for Instrument Advantage)
    nColors = 256;
    nBands = 11;
    bandWidth = 0.2;        % very thin lines
    darkIntensity = 0.85;   % strong darkening
    boneMap = bone(nColors);
    bandCenters = round(linspace(1, nColors, nBands));
    darkMask = zeros(nColors,1);
    x = (1:nColors)';       % vectorized x
    for i = 1:nBands
        idx = bandCenters(i);
        darkMask = darkMask + exp(-((x - idx).^2)/(2*bandWidth^2));
    end
    darkMask = darkMask / max(darkMask);
    finalMap = boneMap .* (1 - darkIntensity*darkMask);
    colormap(finalMap);
    colorbar;
    
    % Plot styling (for Instrument Advantage)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';
    ax.TickDir = 'out';
    ax.TickLength = [0.015 0.015];
    xlim(ax, [0 6.29]);
    ylim(ax, [0 3.15]);

     % Set axis ticks and labels in radians
    xticks([0 pi/2 pi 3*pi/2 2*pi]);
    xticklabels({'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'});

    yticks([0 pi/4 pi/2 3*pi/4 pi]);
    yticklabels({'$0$', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'});

    set(gca, 'TickLabelInterpreter', 'latex');

    title('Instrument Advantage for Dichotomic Trine Insrument Discrimination','Interpreter', 'latex', 'FontSize', 30);

    
    % Plot labels (for Instrument Advantage)
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$\phi$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$P_{Inst}$', 'Interpreter', 'latex', 'FontSize', 30);
   
    % Graph orientation (for Instrument Advantage)
    view(0, 90);

     % Plot Instrument discrimination success probability
    figure(2);
    surf(Theta, Phi, p_succI');
    shading interp;
    
    % Color map settings (custom color map) (for Instrument Discrimination)
    nColors = 256;
    nBands = 11;
    bandWidth = 0.2;        % very thin lines
    darkIntensity = 0.85;   % strong darkening
    boneMap = bone(nColors);
    bandCenters = round(linspace(1, nColors, nBands));
    darkMask = zeros(nColors,1);
    x = (1:nColors)';       % vectorized x
    for i = 1:nBands
        idx = bandCenters(i);
        darkMask = darkMask + exp(-((x - idx).^2)/(2*bandWidth^2));
    end
    darkMask = darkMask / max(darkMask);
    finalMap = boneMap .* (1 - darkIntensity*darkMask);
    colormap(finalMap);
    colorbar;
    
    % Plot styling (for Instrument Discrimination)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';
    ax.TickDir = 'out';
    ax.TickLength = [0.015 0.015];
    xlim(ax, [0 6.29]);
    ylim(ax, [0 3.15]);

     % Set axis ticks and labels in radians
    xticks([0 pi/2 pi 3*pi/2 2*pi]);
    xticklabels({'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'});

    yticks([0 pi/4 pi/2 3*pi/4 pi]);
    yticklabels({'$0$', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'});

    set(gca, 'TickLabelInterpreter', 'latex');

    
    title('Success Probability of Dichotomic Trine Insrument Discrimination','Interpreter', 'latex', 'FontSize', 30);

    
    % Plot labels (for Instrument Discrimination)
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$\phi$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$P_{Inst}$', 'Interpreter', 'latex', 'FontSize', 30);
   
    % Graph orientation (for Instrument Discrimination)
    view(0, 90);


    % Plot Measurement discrimination success probability
    figure(3);
    surf(Theta, Phi, p_succM');
    shading interp;
    

    % Color map settings (custom color map) (for Measurement Discrimination)
    nColors = 256;
    nBands = 11;
    bandWidth = 0.2;        % very thin lines
    darkIntensity = 0.85;   % strong darkening
    boneMap = bone(nColors);
    bandCenters = round(linspace(1, nColors, nBands));
    darkMask = zeros(nColors,1);
    x = (1:nColors)';       % vectorized x
    for i = 1:nBands
        idx = bandCenters(i);
        darkMask = darkMask + exp(-((x - idx).^2)/(2*bandWidth^2));
    end
    darkMask = darkMask / max(darkMask);
    finalMap = boneMap .* (1 - darkIntensity*darkMask);
    colormap(finalMap);
    colorbar;
    
    % Plot styling (for Measurement Discrimination)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';
    ax.TickDir = 'out';
    ax.TickLength = [0.015 0.015];
    xlim(ax, [0 6.29]);
    ylim(ax, [0 3.15]);
    
     % Set axis ticks and labels in radians
    xticks([0 pi/2 pi 3*pi/2 2*pi]);
    xticklabels({'$0$', '$\frac{\pi}{2}$', '$\pi$', '$\frac{3\pi}{2}$', '$2\pi$'});

    yticks([0 pi/4 pi/2 3*pi/4 pi]);
    yticklabels({'$0$', '$\frac{\pi}{4}$', '$\frac{\pi}{2}$', '$\frac{3\pi}{4}$', '$\pi$'});

    set(gca, 'TickLabelInterpreter', 'latex');


    title('Success Probability of Dichotomic Trine Measurement Discrimination','Interpreter', 'latex', 'FontSize', 30);

    
    % Plot labels (for Measurement Discrimination)
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$\phi$', 'Interpreter', 'latex', 'FontSize', 30);
    zlabel('$P_{Meas}$', 'Interpreter', 'latex', 'FontSize', 30);


   
    % Graph orientation (for Measurement Discrimination)
    view(0, 90);

else 

    fprintf('invalid value for PLOT')

end
