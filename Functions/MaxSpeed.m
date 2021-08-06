function [Speed,CSpeed, ASpeed] = MaxSpeed(Tyre, FRTorque, FLTorque, RRTorque,...
    RLTorque, PreviousSpeed, Distance, Car, FRLatMax, FLLatMax, RRLatMax, ...
    RLLatMax, CornerRadius, FRVert, FLVert, RRVert, RLVert, dragF)
% *************************************************************************
% SCRIPT NAME:
%   MaxSpeed.m
%
% INPUTS:
% 
% OUTPUTS:
%   Acceleration Speed, corner speed and actual speed
% *************************************************************************
Accellspeed = StraightLineSpeed(Tyre, FRTorque, FLTorque, RRTorque, RLTorque,...
    PreviousSpeed, Distance, Car, FRVert, FLVert, RRVert, RLVert, dragF);

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

