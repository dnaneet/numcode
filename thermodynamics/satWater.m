%Construction of thermodynamic property table for water (IAPWS)
%

clc;
clear;                                                                                                                                                                  
%Temperature range
T=[5:5:250]; %deg C

%Result tabulation and storage in text file
fileID = fopen('myfile.txt','w');
fprintf(fileID, '\n SATURATED WATER PROPERTIES');
fprintf(fileID, '\n T P_sat v_sat_L v_sat_V u_sat_L u_sat_V h_sat_L h_sat_V s_sat_L s_sat_V'); %columns
fprintf(fileID, '\n degC kPa m3/kg m3/kg kJ/kg kJ/kg kJ/kg kJ/kg kJ/kg-K kJ/kg-K');
fprintf(fileID, '\n');

% for i=1:length(T)
%      fprintf('%2.0f %2.0f %6.5f %6.4f %6.2f %5.1f %7.1f %5.1f %7.1f %6.2f %7.2f', T(i), xsteam('pSat_t', T(i))*100, ...
%         xsteam('vL_t', T(i)), xsteam('vV_t',T(i)), xsteam('uL_t', T(i)), xsteam('uV_t',T(i)), ...
%         xsteam('hL_t',T(i)), xsteam('hV_t', T(i)), xsteam('sL_t',T(i)), xsteam('sV_t', T(i))...
%     ) %P is in bar. It is converted to kPa by multiplication with 100.
%     fprintf('\n')
% end
for i=1:length(T)    
    fprintf(fileID, '%4.0f %4.0f %3.4f %3.4f %3.2f %3.2f %3.2f %3.2f %3.2f %3.2f %3.1f \n', T(i), xsteam('pSat_t', T(i))*100, ...
        xsteam('vL_t', T(i)), xsteam('vV_t',T(i)), xsteam('uL_t', T(i)), xsteam('uV_t',T(i)), ...
        xsteam('hL_t',T(i)), xsteam('hV_t', T(i)), xsteam('sL_t',T(i)), xsteam('sV_t', T(i))...
    ); %P is in bar. It is converted to kPa by multiplication with 100.
    fprintf(fileID, '\n') ;   
end
fclose(fileID);
%fprintf('\n degC kPa m3/kg   m3/kg  kJ/kg  kJ/kg  kJ/kg  kJ/kg  kJ/kg-K kJ/kg-K')

% % 
% A = magic(4);
% fileID = fopen('myfile.txt','w');
% nbytes = fprintf(fileID,'%5d %5d %5d %5d\n',A);
% fclose(fileID);



    


