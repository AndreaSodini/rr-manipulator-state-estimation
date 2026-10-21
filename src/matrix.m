%% Matrice F
% Definizione delle variabili simboliche
syms theta1 theta2 theta1_dot theta2_dot Tm1 Tm2 Td1 Td2 real
syms I1 M1 h1 M2 l1 l2 h2 I2 c1 c2 g dt real

% Matrice di massa
M = [I1 + M1*h1^2 + M2*l1^2, l1*M2*h2*cos(theta1 - theta2);
     l1*M2*h2*cos(theta1 - theta2), I2 + M2*h2^2];

% Matrice N
N = [c1 + c2, -c2;
     -c2, c2];

% Vettore q
q = [l1*M2*h2*sin(theta1 - theta2)*theta2_dot^2 - (M1*h1 + M2*l1)*g*sin(theta1);
     -l1*M2*h2*sin(theta1 - theta2)*theta1_dot^2 - M2*h2*g*sin(theta2)];

% Matrice G
G = [1, 0;
     0, 1];

% Matrice T
T = [1, -1;
     0,  1];

% Accelerazioni
theta_ddot = pinv(M) * (G * [Tm1; Tm2] + T * [Td1; Td2] - N * [theta1_dot; theta2_dot] - q);

% Aggiornamento degli stati con Eulero
theta1_next = theta1 + theta1_dot * dt;
theta2_next = theta2 + theta2_dot * dt;
theta1_dot_next = theta1_dot + theta_ddot(1) * dt;
theta2_dot_next = theta2_dot + theta_ddot(2) * dt;

fk = [theta1_next, theta2_next, theta1_dot_next, theta2_dot_next];
xk = [theta1, theta2, theta1_dot, theta2_dot];
wk = [Td1, Td2];
F = sym(zeros(4,4));

% Derivate parziali rispetto agli stati - Matrice F
for i = 1:4
    for j = 1:4
        F(i,j) = diff(fk(i), xk(j));                    
    end
end

%% Matrice D
% Matrice di massa
M = [I1 + M1*h1^2 + M2*l1^2, l1*M2*h2*cos(theta1 - theta2);
     l1*M2*h2*cos(theta1 - theta2), I2 + M2*h2^2];

% Matrice N
N = [c1 + c2, -c2;
     -c2, c2];

% Vettore q
q = [l1*M2*h2*sin(theta1 - theta2)*theta2_dot^2 - (M1*h1 + M2*l1)*g*sin(theta1);
     -l1*M2*h2*sin(theta1 - theta2)*theta1_dot^2 - M2*h2*g*sin(theta2)];

% Matrice G
G = [1, 0;
     0, 1];

% Matrice T
T = [1, -1;
     0,  1];

% Accelerazioni
theta_ddot = pinv(M) * (G * [Tm1; Tm2] + T * [Td1; Td2] - N * [theta1_dot; theta2_dot] - q);

% Aggiornamento degli stati con Eulero
theta1_next = theta1 + theta1_dot * dt;
theta2_next = theta2 + theta2_dot * dt;
theta1_dot_next = theta1_dot + theta_ddot(1) * dt;
theta2_dot_next = theta2_dot + theta_ddot(2) * dt;

fk = [theta1_next, theta2_next, theta1_dot_next, theta2_dot_next];
xk = [theta1, theta2, theta1_dot, theta2_dot];
wk = [Td1, Td2];
Df = sym(zeros(4,2));

% Derivate parziali rispetto agli stati - Matrice D
for i = 1:4
    for j = 1:2
        Df(i,j) = diff(fk(i), wk(j));                    
    end
end

%% Matrice H
% Definizione delle variabili simboliche
syms theta1 theta2 theta1_dot theta2_dot v1 v2 real
syms D l1 real
hk = sym(zeros(2));
   
% if (x_next(1) > 0)
%     ang_mis = pi - theta1 + theta2;
%     x = D - l1 * sin(theta1);
% else
%     ang_mis = pi + theta1 - theta2;
%     x = D + l1 * sin(theta1);
% end

ang_mis = pi + theta1 - theta2;
x = D + l1 * sin(theta1);
hk(1) =  ang_mis + v1;
hk(2) = x + v2;

xk = [theta1, theta2, theta1_dot, theta2_dot];
H = sym(zeros(2,4));

% Derivate parziali rispetto agli stati - Matrice F
for i = 1:2
    for j = 1:4
        H(i,j) = diff(hk(i), xk(j));                    
    end
end

%% Matrice Mh
% Definizione delle variabili simboliche
hk = sym(zeros(2));
   
% if (x_next(1) > 0)
%     ang_mis = pi - theta1 + theta2;
%     x = D - l1 * sin(theta1);
% else
%     ang_mis = pi + theta1 - theta2;
%     x = D + l1 * sin(theta1);
% end 

ang_mis = pi - theta1 + theta2;
x = D - l1 * sin(theta1);
hk(1) =  ang_mis + v1;
hk(2) = x + v2;

xk = [theta1, theta2, theta1_dot, theta2_dot];
vk = [v1, v2];
Mh = sym(zeros(2,2));

% Derivate parziali rispetto agli stati - Matrice D
for i = 1:2
    for j = 1:2
        Mh(i,j) = diff(hk(i), vk(j));                    
    end
end

