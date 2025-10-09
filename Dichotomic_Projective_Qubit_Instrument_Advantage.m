%Make sure to clear variables before running a second time, otherwise
%uncomment the next line (to avoid array size issues)
%clear

% Samples (/Samples-1)
b=100;


% 0 for plotting success probabilities, 1 for plotting with instrument advantage
% (PLOT = 1 does not compute values at 0 to avoid floating point errors)
PLOT = 0;


% Z basis measurment:
% |0><0|
N(:,:,1,1) = Qubit(0,0);
% |1><1|
N(:,:,2,1) = Qubit(pi,0);

% Choi operator of the quantum channel corresponding to the Lüders' Instrument of the Z basis measurment
C(:,:,1) = LudInstChan(N(:,:,:,1));
% Choi operator of the quantum channel corresponding to the Z basis measurment
G(:,:,1) = MeasChan(N(:,:,:,1));


if PLOT == 0 

    %Initializing Variables
    p_succM=zeros(b+1);
    p_succI=zeros(b+1); 

    %Main Loop
    for j = 0:b
        
        
        %update \theta variable
        theta(j+1) = (j)*pi/(b);

        %Progress Percentage
        clc;
        prog =   j/b *100;
        fprintf('Current Progress: %.3f %% \n', prog);
        
        %Rotated measurement
        N(:,:,1,2) = Qubit(theta(j+1),0);
        N(:,:,2,2) = Qubit(theta(j+1)+pi,0);
        
        %Corresponding Choi Operators
        C(:,:,2) = LudInstChan(N(:,:,:,2));
        G(:,:,2) = MeasChan(N(:,:,:,2));
        
        % Instrument Discrimination Success Probability
        [~,p_succI(j+1)]=Nchannels_1copy_discriminationexample(C, [2,4]);
        % Measurement Discrimination Success Probability
        [~,p_succM(j+1)]=Nchannels_1copy_discriminationexample(G, [2,2]);
    end

    % Instrument Advantage (Not ploted, may have floating point error at 0)
    IvM = (p_succI-0.5)./(p_succM-0.5);


    %plot
    figure(1);
    plot(theta,p_succI,theta,p_succM,'LineWidth', 1, 'MarkerSize', 6)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';              % cleaner look
    ax.TickDir = 'out';          % ticks outside
    ax.TickLength = [0.015 0.015];
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$p_{succ}$', 'Interpreter', 'latex', 'FontSize', 30);
    title('Success Probability of Dichotomic Projective Qubit Measurement and Insrument Discrimination','Interpreter', 'latex', 'FontSize', 30);

elseif PLOT == 1 

    %Initializing Variables
    IvM=zeros(b);
    p_succM=zeros(b);
    p_succI=zeros(b); 
    
    %Main Loop (starts at 1 to avoid floating point errors in IvM)
     for j = 1:b
        clc;

        %Progress Percentage
        theta(j) = (j)*pi/(b);
        prog =   j/b *100;
        fprintf('Current Progress: %.3f %% \n', prog);
        
        %Rotated measurement
        N(:,:,1,2) = Qubit(theta(j),0);
        N(:,:,2,2) = Qubit(theta(j)+pi,0);
        
        %Corresponding Choi Operators
        C(:,:,2) = LudInstChan(N(:,:,:,2));
        G(:,:,2) = MeasChan(N(:,:,:,2));
        
        % Instrument Success Probability  
        [~,p_succI(j)]=Nchannels_1copy_discriminationexample(C, [2,4]);
        % Measurement Success Probability
        [~,p_succM(j)]=Nchannels_1copy_discriminationexample(G, [2,2]);
    end

    % Instrument Advantage
    IvM = (p_succI-0.5)./(p_succM-0.5);

    %plot instrument advantage
    figure(1);
    plot(theta,IvM,'LineWidth', 1, 'MarkerSize', 6)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';              % cleaner look
    ax.TickDir = 'out';          % ticks outside
    ax.TickLength = [0.015 0.015];
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$\Delta$', 'Interpreter', 'latex', 'FontSize', 30);
    title('Instrument Advantage','Interpreter', 'latex', 'FontSize', 30);

    %plot success probabilities
    figure(2);
    plot(theta,p_succI,theta,p_succM,'LineWidth', 1, 'MarkerSize', 6)
    ax = gca;
    ax.FontSize = 20;
    ax.LineWidth = 1.2;
    ax.Box = 'off';              % cleaner look
    ax.TickDir = 'out';          % ticks outside
    ax.TickLength = [0.015 0.015];
    xlabel('$\theta$', 'Interpreter', 'latex', 'FontSize', 30);
    ylabel('$p_{succ}$', 'Interpreter', 'latex', 'FontSize', 30);
    title('Success Probability of Dichotomic Projective Qubit Measurement and Insrument Discrimination','Interpreter', 'latex', 'FontSize', 30);


    

else 

    fprintf('invalid value for PLOT')
end
