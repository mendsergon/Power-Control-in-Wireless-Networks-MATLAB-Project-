clear all; close all; clc;

% =========================================================================
% THREE USER SYSTEM - PARAMETERS
% =========================================================================
% Channel gain matrix G[i,j]: receiver i, transmitter j
G = [1.0, 0.2, 0.1;
     0.2, 0.9, 0.3;
     0.2, 0.2, 1.0];

% Target SINR requirements for each user link
gamma_target = [1.5; 3.0; 1.5];

% Receiver noise power
noise = 0.1;

% Initial transmission powers (mW)
p = [1.0; 1.0; 1.0];
p_history = p';

% =========================================================================
% POWER CONTROL ALGORITHM - 3 USERS
% =========================================================================
fprintf('=== 3-USER POWER CONTROL SIMULATION ===\n');
fprintf('Initial powers: [%.1f, %.1f, %.1f] mW\n\n', p);

for t = 1:20
    gamma = zeros(3,1);
    
    % Calculate current SINR for each user
    for i = 1:3
        interference = 0;
        for j = 1:3
            if i ~= j
                interference = interference + G(i,j) * p(j);
            end
        end
        gamma(i) = (G(i,i) * p(i)) / (interference + noise);
    end
    
    % Distributed power control update
    for i = 1:3
        p(i) = (gamma_target(i) / gamma(i)) * p(i);
    end
    
    % Store power history for analysis
    p_history = [p_history; p'];
    
    % Display iteration results
    if t <= 5
        fprintf('Iteration %2d: p = [%.4f, %.4f, %.4f] mW, SINR = [%.4f, %.4f, %.4f]\n', ...
                t, p(1), p(2), p(3), gamma(1), gamma(2), gamma(3));
    end
end

% =========================================================================
% RESULTS ANALYSIS - 3 USERS
% =========================================================================
fprintf('\n--- 3-USER SYSTEM RESULTS ---\n');
fprintf('Power after 2 iterations: [%.4f, %.4f, %.4f] mW\n', p_history(3,:));

% Calculate final achieved SINR
gamma_final = zeros(3,1);
for i = 1:3
    interference = 0;
    for j = 1:3
        if i ~= j
            interference = interference + G(i,j) * p_history(end,j);
        end
    end
    gamma_final(i) = (G(i,i) * p_history(end,i)) / (interference + noise);
end

fprintf('Final converged powers:  [%.4f, %.4f, %.4f] mW\n', p_history(end,:));
fprintf('Final achieved SINR:    [%.4f, %.4f, %.4f]\n', gamma_final);
fprintf('Target SINR:            [%.4f, %.4f, %.4f]\n', gamma_target');
fprintf('SINR error:             [%.4f, %.4f, %.4f]\n', abs(gamma_final - gamma_target'));

% =========================================================================
% PLOT AND SAVE RESULTS - 3 USERS
% =========================================================================
figure;
plot(0:size(p_history,1)-1, p_history(:,1), 'b-o', 'LineWidth', 2, 'MarkerSize', 4);
hold on;
plot(0:size(p_history,1)-1, p_history(:,2), 'r-s', 'LineWidth', 2, 'MarkerSize', 4);
plot(0:size(p_history,1)-1, p_history(:,3), 'g-^', 'LineWidth', 2, 'MarkerSize', 4);
xlabel('Iteration');
ylabel('Transmission Power (mW)');
title('Distributed Power Control - 3 Users (Convergent)');
legend('User 1', 'User 2', 'User 3', 'Location', 'best');
grid on;
saveas(gcf, 'plot_3users.png', 'png');  % Save the plot

% =========================================================================
% FOUR USER SYSTEM - PARAMETERS
% =========================================================================
G4 = [1.0, 0.2, 0.1, 0.2;
      0.2, 0.9, 0.3, 0.25;
      0.2, 0.2, 1.0, 0.1;
      0.2, 0.2, 1.0, 1.0];

gamma_target4 = [1.5; 3.0; 1.5; 2.0];
noise4 = 0.1;
p4 = [1.0; 1.0; 1.0; 1.0];
p4_history = p4';

% =========================================================================
% POWER CONTROL ALGORITHM - 4 USERS
% =========================================================================
fprintf('\n\n=== 4-USER POWER CONTROL SIMULATION ===\n');
fprintf('Initial powers: [%.1f, %.1f, %.1f, %.1f] mW\n\n', p4);

for t = 1:20
    gamma4 = zeros(4,1);
    
    % Calculate current SINR for each user
    for i = 1:4
        interference = 0;
        for j = 1:4
            if i ~= j
                interference = interference + G4(i,j) * p4(j);
            end
        end
        gamma4(i) = (G4(i,i) * p4(i)) / (interference + noise4);
    end
    
    % Distributed power control update
    for i = 1:4
        p4(i) = (gamma_target4(i) / gamma4(i)) * p4(i);
    end
    
    p4_history = [p4_history; p4'];
    
    % Display iteration results
    if t <= 5
        fprintf('Iteration %2d: p = [%.4f, %.4f, %.4f, %.4f] mW\n', t, p4);
    end
end

% =========================================================================
% RESULTS ANALYSIS - 4 USERS
% =========================================================================
fprintf('\n--- 4-USER SYSTEM RESULTS ---\n');
fprintf('Final powers: [%.4f, %.4f, %.4f, %.4f] mW\n', p4_history(end,:));
fprintf('SYSTEM STATUS: DIVERGENT - Perron-Frobenius condition violated\n');
fprintf('Target SINRs are infeasible with given channel conditions\n');

% =========================================================================
% PLOT AND SAVE RESULTS - 4 USERS
% =========================================================================
figure;
plot(0:size(p4_history,1)-1, p4_history(:,1), 'b-o', 'LineWidth', 2, 'MarkerSize', 4);
hold on;
plot(0:size(p4_history,1)-1, p4_history(:,2), 'r-s', 'LineWidth', 2, 'MarkerSize', 4);
plot(0:size(p4_history,1)-1, p4_history(:,3), 'g-^', 'LineWidth', 2, 'MarkerSize', 4);
plot(0:size(p4_history,1)-1, p4_history(:,4), 'm-d', 'LineWidth', 2, 'MarkerSize', 4);
xlabel('Iteration');
ylabel('Transmission Power (mW)');
title('Distributed Power Control - 4 Users (Divergent)');
legend('User 1', 'User 2', 'User 3', 'User 4', 'Location', 'best');
grid on;
saveas(gcf, 'plot_4users.png', 'png');  % Save the plot

% =========================================================================
% PERRON-FROBENIUS EIGENVALUE CHECK
% =========================================================================
fprintf('\n--- FEASIBILITY ANALYSIS ---\n');

% Construct F matrix for 3 users
F = zeros(3,3);
for i = 1:3
    for j = 1:3
        if i == j
            F(i,j) = 0;
        else
            F(i,j) = (gamma_target(i) * G(i,j)) / G(i,i);
        end
    end
end
rho_F = max(abs(eig(F)));
fprintf('3-user system: ρ(F) = %.6f - %s\n', rho_F, ...
        ternary(rho_F < 1, 'FEASIBLE', 'INFEASIBLE'));

% Construct F matrix for 4 users
F4 = zeros(4,4);
for i = 1:4
    for j = 1:4
        if i == j
            F4(i,j) = 0;
        else
            F4(i,j) = (gamma_target4(i) * G4(i,j)) / G4(i,i);
        end
    end
end
rho_F4 = max(abs(eig(F4)));
fprintf('4-user system: ρ(F) = %.6f - %s\n', rho_F4, ...
        ternary(rho_F4 < 1, 'FEASIBLE', 'INFEASIBLE'));

% Helper function for ternary operator
function result = ternary(condition, true_val, false_val)
    if condition
        result = true_val;
    else
        result = false_val;
    end
end