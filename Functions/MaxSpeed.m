function [Speed,CSpeed, ASpeed] = MaxSpeed(Tyre, FRTorque, FLTorque, RRTorque, RLTorque, PreviousSpeed, Distance, Car, FRLatMax, FLLatMax, RRLatMax, RLLatMax, CornerRadius, FRVert, FLVert, RRVert, RLVert, dragF)
%MAXSPEED Summary of this function goes here
%   Detailed explanation goes here
Accellspeed = StraightLineSpeed(Tyre, FRTorque, FLTorque, RRTorque, RLTorque, PreviousSpeed, Distance, Car, FRVert, FLVert, RRVert, RLVert, dragF);
CornerSpeed =  MaxCornerSpeed(FRLatMax, FLLatMax, RRLatMax, RLLatMax, Car, CornerRadius, dragF);

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

