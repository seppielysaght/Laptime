function [Torque, Power] = MotorLookup(RPM, Car)
%MOTORLOOKUP Summary of this function goes here
%   Detailed explanation goes here

if RPM >= 19999
    Torque = 0;
    Power = 0;
else
    n = find(Car.MotorMap.RPM == RPM);
%     Torque = Car.MotorMap.Torque(n);
%     Power = Car.MotorMap.Power(n);
    Torque = interp1(Car.MotorMap.RPM,Car.MotorMap.Torque,n,'linear');
    Power = interp1(Car.MotorMap.RPM,Car.MotorMap.Power,n,'linear');
end

end

