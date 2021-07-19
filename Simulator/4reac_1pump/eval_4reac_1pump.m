%% Simulation
sim('mdl_4reac_1pump','StopTime','100');
% save('data_4reac_1pump','out');
% save('data_4reac_1pump_diff_ref','out');

%% Evaluation
% load('data_4reac_1pump');
% load('data_4reac_1pump_diff_ref');
% time interval for plots [t_lower, t_upper]
t_lower = 0; % minutes
t_upper = 1000; % minutes
t_indices = (out.tout >= t_lower) == (out.tout <= t_upper);

figure(1);
subplot(2,1,1)
% plot actual flow
plot(out.tout(t_indices), out.actual_flow(t_indices,1));
grid on
hold on
plot(out.tout(t_indices), out.actual_flow(t_indices,2));
plot(out.tout(t_indices), out.actual_flow(t_indices,3));
plot(out.tout(t_indices), out.actual_flow(t_indices,4));
% plot desired flow
plot(out.tout(t_indices), out.desired_flow(t_indices,1));
plot(out.tout(t_indices), out.desired_flow(t_indices,2));
plot(out.tout(t_indices), out.desired_flow(t_indices,3));
plot(out.tout(t_indices), out.desired_flow(t_indices,4));
legend('actual flow reac1','actual flow reac2','actual flow reac3',...
'actual flow reac4','desired flow reac1','desired flow reac2',...
'desired flow reac3','desired flow reac4');

subplot(2,1,2)
% plot actual OD
plot(out.tout(t_indices), out.actual(t_indices,1));
grid on
hold on
plot(out.tout(t_indices), out.actual(t_indices,2));
plot(out.tout(t_indices), out.actual(t_indices,3));
plot(out.tout(t_indices), out.actual(t_indices,4));
% plot OD reference
plot(out.tout(t_indices), out.reference(t_indices,1));
plot(out.tout(t_indices), out.reference(t_indices,2));
plot(out.tout(t_indices), out.reference(t_indices,3));
plot(out.tout(t_indices), out.reference(t_indices,4));
legend('actual OD reac1','actual OD reac2','actual OD reac3',...
    'actual OD reac4','OD reference reac1','OD reference reac2',...
    'OD reference reac3','OD reference reac4');