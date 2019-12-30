function [Torque] = TorqueLookup(RPM,Car)
    n = find(Car.MotorMap==RPM);
    Torque = Car.MotorMap(n+1);
end