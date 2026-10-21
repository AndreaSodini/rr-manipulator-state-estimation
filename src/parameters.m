% Definizione dei parametri del sistema
    l1 = 1;                              % Lunghezza del link 1
    l2 = 0.5;                            % Lunghezza del link 2
    M1 = 10;                             % Massa del primo corpo
    M2 = 5;                              % Massa del secondo corpo
    I1 = 1/3*M1*l1^2;                    % Momento d'inerzia del primo corpo
    I2 = 1/3*M2*l2^2;                    % Momento d'inerzia del secondo corpo
    h1 = 0.5;                            % Altezza del baricentro del primo corpo
    h2 = 0.25;                           % Altezza del baricentro del secondo corpo
    c1 = 0.07;                           % Coefficiente di attrito viscoso per il primo link
    c2 = 0.1;                            % Coefficiente di attrito viscoso per il secondo link
    g = 9.81;                            % Accelerazione gravitazionale (m/s^2)    
    dt = 0.001;                          % Periodo di Campionamento
    D = 2;
    sigma_W = 4;
    sigma1_V = 0.1;
    sigma2_V = 0.05;
    c = 340;


