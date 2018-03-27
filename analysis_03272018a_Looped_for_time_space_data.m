data = porous;
clear size_time;
clear size_x;
clear size_row;
clear size_col;
[size_time, size_x] = size(data);
%%
clc;
rqa = zeros(1,13);
for i=1:2:1600
    rqa = [rqa; crqa(data(i,:), 1, 1, .2, size_x, 1, 'euc', 'silent')];
end

%% 
[x_rqa, y_rqa] = size(rqa);
figure ;
subplot(3,1,1)
plot(rqa(:,1), 'k-.', 'LineWidth', 2)
axis([0 x_rqa 0 max(rqa(:,1))])
title('Recurrence Rate')
xlabel('Time instance', 'fontsize', 14)
xt = get(gca, 'XTick');
set(gca, 'FontSize', 15)

subplot(3,1,2)
plot(rqa(:,6), 'k-.', 'LineWidth', 2)
axis([0 x_rqa 0.96 max(rqa(:,6))])
title('Laminarity')
xlabel('Time instance', 'fontsize', 14)
xt = get(gca, 'XTick');
set(gca, 'FontSize', 15)

subplot(3,1,3)
plot(rqa(:,7), 'k-.', 'LineWidth', 2)
axis([0 x_rqa 0 max(rqa(:,7))])
title('Trapping Time')
xlabel('Time instance', 'fontsize', 14)
xt = get(gca, 'XTick');
set(gca, 'FontSize', 15)

