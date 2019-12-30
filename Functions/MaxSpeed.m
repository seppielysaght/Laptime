function [Speed,CSpeed, ASpeed] = MaxSpeed(Tyre, Torque, PreviousSpeed, Distance, Car, FRLatMax, FLLatMax, RRLatMax, RLLatMax, CornerRadius)
%MAXSPEED Summary of this function goes here
%   Detailed explanation goes here
Accellspeed = StraightLineSpeed(Tyre, Torque, PreviousSpeed, Distance, Car);
CornerSpeed =  MaxCornerSpeed(FRLatMax, FLLatMax, RRLatMax, RLLatMax, Car, CornerRadius);

if CornerRadius == 0
    Speed = Accellspeed;
elseif Accellspeed > CornerSpeed 
    Speed = CornerSpeed;
else
    Speed = Accellspeed;
end

CSpeed = CornerSpeed;
ASpeed = Accellspeed;
end

