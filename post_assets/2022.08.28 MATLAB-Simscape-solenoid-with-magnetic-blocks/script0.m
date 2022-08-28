% clc, clear
% 
% sym = 'ssc_solenoid_magnetic';
% open(sym)
% sim(sym)

mmf1 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.mmf.series.values;
phi1 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.phi.series.values;
unit1 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.mmf.series.unit;
unit2 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Magnetic_Core.phi.series.unit;

R1 = mmf1./phi1;

mmf2 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.mmf.series.values;
phi2 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.phi.series.values;
unit3 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.mmf.series.unit;
unit4 = simlog_ssc_solenoid_magnetic.Solenoid_with_Magnetic_Effects.Plunger_Core_Fixed_Air_Gap.phi.series.unit;

R2 = mmf2./phi2;

R1(2)
8*(1e-2)/(4000*4*pi*(1e-7)*4*(1e-4))
R2(2)
0.65*(1e-3)/(4*pi*(1e-7)*4*(1e-4))
