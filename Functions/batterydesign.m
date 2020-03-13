function [MaxVoltage, MaxChargeI, MaxDischargeI, Capacity] = batterydesign( Car )
%BATTERYDESIGN Summary of this function goes here
%   Detailed explanation goes here

%Calculating Max Pack Voltage
MaxVoltage = Car.MaxCellVoltage*Car.SeriesCells;

%calculate pack capacity
Capacity = Car.NominalCellVoltage*Car.CellCapacity*Car.ParralleCells*Car.SeriesCells;

%calculating pack max charge current 
MaxChargeI = Car.CellMaxChargeCurrent*Car.ParralleCells;

%calculating pack max discharge current 
MaxDischargeI = Car.CellMaxDischargeCurrent*Car.ParralleCells;

end

