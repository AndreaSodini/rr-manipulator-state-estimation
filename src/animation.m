function animation(theta1, theta2, theta1_UKF, theta2_UKF, theta1_EKF, theta2_EKF, l1, l2, type)
    % Creazione della figura
    figure;
    hold on;
    axis equal;
    grid on;
    xlim([-1.5*(l1+l2), 1.5*(l1+l2)]); % Limiti sull'asse x
    ylim([-1.5*(l1+l2), 1.5*(l1+l2)]); % Limiti sull'asse y
    title('Animazione del manipolatore planare');
    xlabel('X [m]');
    ylabel('Y [m]');

    % Disegno iniziale
    link1 = plot([0, 0], [0, 0], 'r-', 'LineWidth', 2); % Primo link
    link2 = plot([0, 0], [0, 0], 'b-', 'LineWidth', 2); % Secondo link
    joint1 = plot(0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Primo giunto
    joint2 = plot(0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Secondo giunto
    end_effector = plot(0, 0, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Punta reale
    end_effector_UKF = plot(0, 0, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g'); % Punta UKF
    end_effector_EKF = plot(0, 0, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'm'); % Punta EKF
    trajectory = plot(NaN, NaN, 'r-', 'LineWidth', 1); % Traiettoria reale
    trajectory_UKF = plot(NaN, NaN, 'g-', 'LineWidth', 1); % Traiettoria UKF
    trajectory_EKF = plot(NaN, NaN, 'm-', 'LineWidth', 1); % Traiettoria EKF

    % Aggiunta della legenda
    if (type == "RTS")
        legend([trajectory, trajectory_UKF, trajectory_EKF], {'Traiettoria Reale', 'Traiettoria sm', 'Traiettoria EKF'}, 'Location', 'bestoutside');
    else
        legend([trajectory, trajectory_UKF, trajectory_EKF], {'Traiettoria Reale', 'Traiettoria UKF', 'Traiettoria EKF'}, 'Location', 'bestoutside');
    end

    % Variabili per la traiettoria
    trajectory_x = [];
    trajectory_y = [];
    trajectory_x_UKF = [];
    trajectory_y_UKF = [];
    trajectory_x_EKF = [];
    trajectory_y_EKF = [];

    % Animazione
    for i = 1:length(theta1)
        % Calcolo delle posizioni
        x1 = l1 * sin(theta1(i));
        y1 = l1 * cos(theta1(i));
        x2 = x1 + l2 * sin(theta2(i));
        y2 = y1 + l2 * cos(theta2(i));
        
        % UKF
        x1_UKF = l1 * sin(theta1_UKF(i));
        y1_UKF = l1 * cos(theta1_UKF(i));
        x2_UKF = x1 + l2 * sin(theta2_UKF(i));
        y2_UKF = y1 + l2 * cos(theta2_UKF(i));
        
        % EKF
        x1_EKF = l1 * sin(theta1_EKF(i));
        y1_EKF = l1 * cos(theta1_EKF(i));
        x2_EKF = x1 + l2 * sin(theta2_EKF(i));
        y2_EKF = y1 + l2 * cos(theta2_EKF(i));

        % Aggiornamento della traiettoria
        trajectory_x = [trajectory_x, x2];
        trajectory_y = [trajectory_y, y2];
        trajectory_x_UKF = [trajectory_x_UKF, x2_UKF];
        trajectory_y_UKF = [trajectory_y_UKF, y2_UKF];
        trajectory_x_EKF = [trajectory_x_EKF, x2_EKF];
        trajectory_y_EKF = [trajectory_y_EKF, y2_EKF];

        % Aggiornamento del grafico
        set(link1, 'XData', [0, x1], 'YData', [0, y1]);
        set(link2, 'XData', [x1, x2], 'YData', [y1, y2]);
        set(joint1, 'XData', x1, 'YData', y1);
        set(joint2, 'XData', x2, 'YData', y2);
        set(end_effector, 'XData', x2, 'YData', y2);
        set(end_effector_UKF, 'XData', x2_UKF, 'YData', y2_UKF);
        set(end_effector_EKF, 'XData', x2_EKF, 'YData', y2_EKF);
        set(trajectory, 'XData', trajectory_x, 'YData', trajectory_y);
        set(trajectory_UKF, 'XData', trajectory_x_UKF, 'YData', trajectory_y_UKF);
        set(trajectory_EKF, 'XData', trajectory_x_EKF, 'YData', trajectory_y_EKF);

        % Pausa per creare l'animazione
        pause(0.001);
    end
end
