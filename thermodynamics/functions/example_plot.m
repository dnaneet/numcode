T_low=0;
T_high=375;
plotTV(T_low, T_high, pressures) 


%%
T_1 = xsteam('Tsat_p', 1);
v_1 = xsteam('v_pt', 10, T_1)
v_2 = 100;
T_2=130;
plotStateOnTV(v_1, T_1, v_2, T_2)