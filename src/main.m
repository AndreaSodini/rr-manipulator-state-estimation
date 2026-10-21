clc;
close all;

run('parameters.m');

% Nome del modello Simulink
% simulink_name = 'RobotRRPlanare';
% 
% Carica il modello
% load_system(simulink_name);
% 
% Definisci i parametri di simulazione (se necessario)
% simTime = 500; % Tempo di simulazione in secondi
% 
% Esegui la simulazione
% out = sim(simulink_name, 'SimulationMode', 'normal', ...
%           'StartTime', '0', 'StopTime', num2str(simTime), ...
%           'SaveOutput', 'on', 'OutputSaveName', 'yout', ...
%           'SaveTime', 'on', 'TimeSaveName', 'tout', ...
%           'SimulationMode', 'normal', 'Solver', 'ode45');

% % Dati restituiti da x_next
theta1 = out.x_next.Data(:,1); % Primo giunto
theta2 = out.x_next.Data(:,2); % Secondo giunto

% Dati restituiti da traj_d
theta1_d = out.theta_d.signals.values(1,:); % Primo giunto
theta2_d = out.theta_d.signals.values(2,:); % Secondo giunto

% Dati restituiti da UKF
theta1_UKF = out.x_kk_UKF.Data(1,:); % Primo giunto
theta2_UKF = out.x_kk_UKF.Data(2,:); % Secondo giunto

% Dati restituiti da EKF
theta1_EKF = out.x_kk_EKF.Data(:,1); % Primo giunto
theta2_EKF = out.x_kk_EKF.Data(:,2); % Secondo giunto

% Dati restituiti da RTS
% theta1_sm = x_smoothed(:,1); % Primo giunto
% theta2_sm = x_smoothed(:,2); % Secondo giunto

e_EKF = squeeze(out.innovEKF.Data);
[h1_ekf,p1_ekf] = lbqtest(e_EKF(1,:));
[h2_ekf,p2_ekf] = lbqtest(e_EKF(2,:));

e_UKF = squeeze(out.innovUKF.Data);
[h1_ukf,p1_ukf] = lbqtest(e_UKF(1,:));
[h2_ukf,p2_ukf] = lbqtest(e_UKF(2,:));

% Confronto Modello Reale - EKF - UKF
animation(theta1, theta2, theta1_UKF, theta2_UKF, theta1_EKF, theta2_EKF, l1, l2, 'UKF');

% Confronto Modello Reale - EKF - RTS
% animation(theta1, theta2, theta1_sm, theta2_sm, theta1_EKF, theta2_EKF, l1, l2, "RTS");





