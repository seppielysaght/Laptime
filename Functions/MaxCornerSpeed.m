function [CarCornerSpeed] = MaxCornerSpeed(FRLatMax, FLLatMax, RRLatMax, RLLatMax, Car, CornerRadius)
%MAXCORNERSPEED Summary of this function goes here
%   Detailed explanation goes here

maxLatForce= (FRLatMax + FLLatMax + RRLatMax + RLLatMax);
CarCornerSpeed  = sqrt((maxLatForce*CornerRadius)/Car.mass);

end

