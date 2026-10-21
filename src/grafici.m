%% Grafico EKF
stateNames = {'theta1', 'theta2', 'theta1.dot', 'theta2.dot'};
time_EKF = out.x_kk_EKF.Time;  % Tempo
states_EKF = out.x_kk_EKF.Data;  % Stati (colonne 2, 3, 4, 5)

% Creare la figura con quattro subplot
figure;
title('EKF');
for i = 1:4
    subplot(4, 1, i);
    plot(time_EKF, states_EKF(:, i), 'LineWidth', 1.5);
    xlabel('Tempo [s]');
    ylabel(stateNames{i});
    title(['Evoluzione di ', stateNames{i}]);
    grid on;
end

%% Grafico UKF
time_UKF = out.x_kk_UKF.Time;  % Tempo
% Estrarre i dati e rimuovere la seconda dimensione
states_UKF = squeeze(out.x_kk_UKF.Data);  % Risultato: 4x70001
% Trasporre la matrice per avere 70001 righe e 4 colonne
states_UKF = states_UKF';


% Creare la figura con quattro subplot
figure;
title('UKF');
for i = 1:4
    subplot(4, 1, i);
    plot(time_UKF, states_UKF(:, i), 'LineWidth', 1.5);
    xlabel('Tempo [s]');
    ylabel(stateNames{i});
    title(['Evoluzione di ', stateNames{i}]);
    grid on;
end

%% Grafico RTS
time_UKF = out.x_kk_UKF.Time;  % Tempo
states_UKF = x_smoothed;  % Stati (colonne 2, 3, 4, 5)

figure;
title('RTS');
for i = 1:4
    subplot(4, 1, i);
    plot(time_UKF, x_smoothed(:, i), 'LineWidth', 1.5);
    xlabel('Tempo [s]');
    ylabel(stateNames{i});
    title(['Evoluzione di ', stateNames{i}]);
    grid on;
end

%% Grafico Innovazione EKF
sensNames = {'Encoder', 'Sensore Ultrasuoni'};
e_EKF = squeeze(out.innovEKF.Data);
figure;
title('Innovazione EKF');
for i = 1:2
    subplot(2, 1, i);
    plot(time_EKF, e_EKF(i, :), 'LineWidth', 1.5);
    xlabel('Tempo [s]');
    ylabel(sensNames{i});
    title(['Evoluzione ', sensNames{i}]);
    grid on;
end

%% Grafico Innovazione UKF
e_UKF = squeeze(out.innovUKF.Data);
figure;
title('Innovazione UKF');
for i = 1:2
    subplot(2, 1, i);
    plot(time_UKF, e_UKF(i, :), 'LineWidth', 1.5);
    xlabel('Tempo [s]');
    ylabel(sensNames{i});
    title(['Evoluzione ', sensNames{i}]);
    grid on;
end

%% Grafico Outliers
sens = squeeze(out.y_meas);
figure;
title('Outliers Encoder Incrementale');
plot(time_UKF, sens(1, :), 'LineWidth', 1.5);
xlabel('Tempo [s]');
ylabel('Encoder Incrementale');
grid on;

figure;
title('Outliers Sensore ad Ultrasuoni');
plot(time_UKF, sens(2, :), 'LineWidth', 1.5);
xlabel('Tempo [s]');
ylabel('Sensore ad Ultrasuoni');
grid on;