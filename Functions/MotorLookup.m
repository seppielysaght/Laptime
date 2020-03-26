function [Torque, Power] = MotorLookup(RPM, Car, PowerLimit, TorqueSplit)
%MOTORLOOKUP Summary of this function goes here
%   Detailed explanation goes here

if RPM == 0 
    RPM = 0.000001;
end

if RPM >= 19999 %this would be done in the control software
    Torque = 0;
    Power = 0;
else
    TorqueMap = Car.MotorMap.T;
    PowerMap = interp1(Car.MotorMap.RPM,Car.MotorMap.Power,RPM,'linear');
    
    mapmax = max(PowerMap);
    
    if mapmax > PowerLimit
        Torque = interp1(PowerMap,TorqueMap,PowerLimit,'linear');
        Power = PowerLimit;
    else
        Torque = interp1(PowerMap,TorqueMap,mapmax,'linear');
        Power = mapmax;
    end
end

end

