function [Speed,CSpeed, ASpeed, BrakingNeeded] = MaxSpeed(Tyre, Torque, PreviousSpeed, Distance, Car, FRLatMax, FLLatMax, RRLatMax, RLLatMax, CornerRadius)
%MAXSPEED Summary of this function goes here
%   Detailed explanation goes here
Accellspeed = StraightLineSpeed(Tyre, Torque, PreviousSpeed, Distance, Car);
CornerSpeed =  MaxCornerSpeed(FRLatMax, FLLatMax, RRLatMax, RLLatMax, Car, CornerRadius);

if CornerRadius == 0
    Speed = Accellspeed;
    BrakingNeeded = 0;
elseif Accellspeed > CornerSpeed 
    Speed = CornerSpeed;
    BrakingNeeded = 1;
else
    Speed = Accellspeed;
    BrakingNeeded = 0;
end

CSpeed = CornerSpeed;
ASpeed = Accellspeed;

end

