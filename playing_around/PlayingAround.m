
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
% dad = 100*rand(1);
% e = 0.5*randi(2*(30-10), 5)+10;
% f = randn(1)*(20)+278;
% j = 2*((simulation_time-f1.duration)-fault_start_time);
% k = 2*((simulation_time/fault_count-f1.duration)-fault_start_time);
% fx = linspace(1,30, 30);
% fmean = mean(f);
% % plot(fx,f);
%     d_rand_var = 100*rand(4,1);
%     d_prob = 1;
%     d_table = [d_rand_var(1)<d_prob;d_rand_var(2)<d_prob;d_rand_var(3)<d_prob;d_rand_var(4)<d_prob];
Ca0 = 0.2;
k_rate = 0.002923; 
dur = 50;
t_test = linspace(1, dur, dur);
Ca = exp(log(Ca0)-k_rate.*t_test);
Caoarr = (zeros(dur, 1) + Ca0)';
Cp = Caoarr - Ca;
ext_eff = (-100.*Cp.*0.146)./(4.244)+1;
strip_eff = (-100.*Cp.*0.088)./(1.752)+1;
subplot(2,1,1)
plot(t_test, ext_eff, '-c', t_test, strip_eff, 'ro');
subplot(2,1,2)
plot(t_test, Ca);