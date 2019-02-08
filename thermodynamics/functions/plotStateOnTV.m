function plotStateOnTV(v_1, v_2, T_1, T_2)

close all;
T = linspace(0,500,1000); % range of temperatures
figure; hold on;

for P = [0.001 0.01 0.1 1 10 100 225] % bar
    v = arrayfun(@(t) xsteam('v_pT',P,t),T);
    plot(v,T,'b-', 'LineWidth', 1.75)
    text(v(end),T(end),sprintf('%1.1f bar',P),'rotation',90)
end

set(gca,'Position',[0.13 0.11 0.775 0.7])
%saturated vapor and liquid specific volume lines
vvap = arrayfun(@(t) xsteam('vV_T',t),T);
vliq = arrayfun(@(t) xsteam('vL_T',t),T);

plot(vvap,T,'k-', 'LineWidth', 2)
plot(vliq,T,'k-', 'LineWidth', 2)
set(gca, 'XScale', 'log')
set(gca, 'FontSize', 14);
xlabel('Specific Volume (m^3/kg)', 'FontSize', 15)
ylabel('Temperature (^\circC)','FontSize', 15)
xlim([0 250]);

plot(v_1, T_1, 'rs', 'MarkerSize',8, 'MarkerFaceColor','r')
%text(v_1, T_1+5,sprintf('  %3.4f m^3/kg',v_1),'rotation',60)
plot(v_2, T_2, 'rs', 'MarkerSize',8, 'MarkerFaceColor','r')
%text(v_2, T_2+5,sprintf('  %3.4f m^3/kg',v_2),'rotation',60)


