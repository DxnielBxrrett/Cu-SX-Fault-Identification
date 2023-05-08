rng(6);

N = 100;
a = 50*rand(N,1)+10;
b = zeros(N,2);
b(:, 2) = 1;
% t = linspace(0,simulation_time,simulation_time/step_time+1)';
% P_faultttt  = zeros(simulation_time*2,2);
% P_faultttt(:, 1) = linspace(0,simulation_time,simulation_time/step_time+1)';
% P_faultttt(:, 2) = 100*rand(simulation_time*2,1);
% A = linspace(0,simulation_time,simulation_time/step_time+1)'; 
% B = 100*rand(simulation_time*2+1,1);
% P_faulttt = [A B];
% Daddy = [linspace(0,simulation_time,simulation_time/step_time+1)' 100*rand(simulation_time*2+1,1)];
% sssum = size(simulation_results.DAN.Data);
% ts = timeseries(Daddy, linspace(0,simulation_time,simulation_time/step_time+1)');
dad = 100*rand(1);