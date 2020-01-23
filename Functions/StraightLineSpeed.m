function [Speed] = StraightLineSpeed(Tyre, Torque, PreviousSpeed, Distance, Car)
%STRAIGHTLINESPEED Summary of this function goes here
%   Detailed explanation goes here

wheelT = Torque*Car.gearR;
MaxForwardForce = wheelT/(Tyre.Dia/2);
Accell = MaxForwardForce/Car.mass;
Speed = sqrt((PreviousSpeed^2) + (2*Accell*Distance));

end

