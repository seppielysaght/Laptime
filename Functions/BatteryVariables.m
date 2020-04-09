function [MaxVoltage, MaxChargeI, MaxDischargeI, Capacity] = BatteryVariables( Car )
% *************************************************************************
% SCRIPT NAME:
%   BatteryVariables.m
%
% INPUTS:
%   Car parameters Struct
% 
% OUTPUTS:
%   Max Pack Voltage (V), Max Charge Current (A), Max Discharge Current (A), Pack Capacity (kWh)
% *************************************************************************

%Calculating Max Pack Voltage
MaxVoltage = Car.MaxCellVoltage*Car.SeriesCells;

%calculate pack capacity
Capacity = Car.NominalCellVoltage*Car.CellCapacity*Car.ParralleCells*Car.SeriesCells;

%calculating pack max charge current 
MaxChargeI = Car.CellMaxChargeCurrent*Car.ParralleCells;

%calculating pack max discharge current 
MaxDischargeI = Car.CellMaxDischargeCurrent*Car.ParralleCells;

end

