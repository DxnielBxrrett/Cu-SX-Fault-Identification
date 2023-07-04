% rng(18);
% N = 100;
% a = 50*rand(N,1)+10;
% b = zeros(N,2);
% dad = zeros(simulation_time/step_time+1,1);
% % t = linspace(0,simulation_time,simulation_time/step_time+1)';
% % P_faultttt  = zeros(simulation_time*2,2);
% % P_faultttt(:, 1) = linspace(0,simulation_time,simulation_time/step_time+1)';
% % P_faultttt(:, 2) = 100*rand(simulation_time*2,1);
% % A = linspace(0,simulation_time,simulation_time/step_time+1)'; 
% % B = 100*rand(simulation_time*2+1,1);
% % P_faulttt = [A B];
% % Daddy = [linspace(0,simulation_time,simulation_time/step_time+1)' 100*rand(simulation_time*2+1,1)];
% % sssum = size(simulation_results.DAN.Data);
% % ts = timeseries(Daddy, linspace(0,simulation_time,simulation_time/step_time+1)');
% % dad = 100*rand(1);
% % e = 0.5*randi(2*(30-10), 5)+10;
% f = randn(30, 1)*(7);
% % j = 2*((simulation_time-f1.duration)-fault_start_time);
% % k = 2*((simulation_time/fault_count-f1.duration)-fault_start_time);
% % fx = linspace(1,30, 30);
% % fmean = mean(f);
% % plot(fx,f);
% %     d_rand_var = 100*rand(4,1);
% %     d_prob = 1;
% %     d_table = [d_rand_var(1)<d_prob;d_rand_var(2)<d_prob;d_rand_var(3)<d_prob;d_rand_var(4)<d_prob];
% % Ca0 = 0.2;
% % k_rate = 0.002923*10; 
% % dur = 50;
% % t_test = linspace(1, dur, dur);
% % Ca = exp(log(Ca0)-k_rate.*t_test);
% % Caoarr = zeros(1,dur) + Ca0;
% % Cp = Caoarr - Ca;
% % ext_eff = (-100.*Cp.*0.146)./(4.244)+1;
% % strip_eff = (-100.*Cp.*0.088)./(1.752)+1;
% % subplot(2,1,1)
% % plot(t_test, ext_eff, '-c', t_test, strip_eff, 'ro');
% % subplot(2,1,2)
% % plot(t_test, Ca);
% sf = false;
% while sf == false
%     magnitude = randn(1)*20;
%     if abs(magnitude) > 10
%         sf = true;
%     end
% end

% tuning_data = table(simulation_results.tout, simulation_results.vLO_control.data, simulation_results.vLE_control.data, simulation_results.c_LO_measured.data, simulation_results.c_RE_measured.data);
% tuning_data.Properties.VariableNames = ["Time (s)", "vLO control", "vLE control", "cLO (g/L)", "cRE (g/L)"];
% writetable(tuning_data,"controller_tuning\data\feedback\vLO_step_feedback.csv");
% apple = [0:gamma_max/0.5];
% oranges = vLE_step.MSE_cLO;
rng(21);
simulation_time = 60*60*24*7;
step_time = 0.5;
f1.duration = step_time*randi((max_fault_duration-min_fault_duration)/step_time)+min_fault_duration;
        f1.start_time = step_time*randi(((simulation_time-f1.duration)-fault_start_time)/step_time)+fault_start_time;
        while safeguard == false
            f1.magnitude = randn(1)*(7);
            if abs(f1.magnitude) > 3.5
                safeguard = true;
            end
        end
        f1.magnitude = randn(1)*(7);
        f1.input = zeros(simulation_time/step_time+1,1);
        for p = (f1.start_time/step_time+1):((f1.start_time+f1.duration)/step_time+1)
            f1.input(p) = f1.magnitude;
        end
        aMitch = 5;
f2.duration = step_time*randi((max_fault_duration-min_fault_duration)/step_time)+min_fault_duration;
        f2.start_time = step_time*randi(((simulation_time-f2.duration-settle_time)-fault_start_time)/step_time)+fault_start_time;
        safeguard = false;
        while safeguard == false
            f2.magnitude = randn(1)*(20);
            if abs(f2.magnitude) > 27.8
                safeguard = true;
            end
        end
        
        f2.input = zeros(simulation_time/step_time+1,1);
        for z = (f2.start_time/step_time+1):((f2.start_time+f2.duration)/step_time+1)
            f2.input(z) = f2.magnitude;   
        end
        aDan = 6;
    amy = table();    
    amy.f1_magnitude = f1.input(1:(sampling_rate/step_time):end);
    amy.f2_magnitude = f2.input(1:(sampling_rate/step_time):end);
    writetable(amy, "process_model/output_test/measured_data.csv");
