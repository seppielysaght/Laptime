function [Torque, Power] = MotorLookup(RPM, Car)
%MOTORLOOKUP Summary of this function goes here
%   Detailed explanation goes here

n = find(Car.MotorMap.RPM == RPM);
Torque = Car.MotorMap.Torque(n);
Power = Car.MotorMap.Power(n);

end

