function [Power] = PowerLookup(RPM,Car)
    n = find(Car.MotorMap== RPM);
    Power = Car.MotorMap(n+2);
end

