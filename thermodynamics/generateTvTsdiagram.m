%% T-v diagram, water
close all;
T = linspace(0,500,1000); % range of temperatures
figure; hold on;

for P = [0.001 0.01 0.1 1 10 100 225] % bar
    %xsteam is not vectorized, so here is an easy way to compute a
    %vector of entropies
    v = arrayfun(@(t) xsteam('v_pT',P,t),T);
    plot(v,T,'k-')
    text(v(end),T(end),sprintf('%1.1f bar',P),'rotation',90)
end

set(gca,'Position',[0.13 0.11 0.775 0.7])
%saturated vapor and liquid specific volume lines
vvap = arrayfun(@(t) xsteam('vV_T',t),T);
vliq = arrayfun(@(t) xsteam('vL_T',t),T);

plot(vvap,T,'k-', 'LineWidth', 2)
plot(vliq,T,'k-', 'LineWidth', 2)
set(gca, 'XScale', 'log')
xlabel('Specific Volume (m^3/kg)', 'FontSize', 15)
ylabel('Temperature (^\circC)','FontSize', 15)
xlim([0 250]);
%% Saturated vapor at 100 deg C and 1 Bar
plot(xsteam('v_pT',1, 100), 100, 'rs', 'MarkerSize',8, 'MarkerFaceColor','r')
text(xsteam('v_pT',1, 100), 100,sprintf('  %3.4f m^3/kg',xsteam('v_pT',1, 100)),'rotation',60)
%% T-s diagram, water
T = linspace(0,800,200); % range of temperatures
figure; hold on
% we need to compute S-T for a range of pressures. Here
for P = [0.01 0.1 1 5 30 100 250 500 1000] % bar
    % xsteam is not vectorized, so here is an easy way to compute a
    % vector of entropies
    S = arrayfun(@(t) xsteam('s_PT',P,t),T);
    plot(S,T,'k-') %Draws an isobar
    text(S(end),T(end),sprintf('%1.1f bar',P),'rotation',90)
end
set(gca,'Position',[0.13 0.11 0.775 0.7])

% saturated vapor and liquid entropy lines
svap = arrayfun(@(t) xsteam('sV_T',t),T);
sliq = arrayfun(@(t) xsteam('sL_T',t),T);

plot(svap,T,'r-')
plot(sliq,T,'b-')
xlabel('Entropy (kJ/(kg K)')
ylabel('Temperature (^\circC)')

