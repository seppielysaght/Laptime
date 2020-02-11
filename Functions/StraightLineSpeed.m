function [Speed] = StraightLineSpeed(Tyre, Torque, PreviousSpeed, Distance, Car, FRVert, FLVert, RRVert, RLVert)
%STRAIGHTLINESPEED Summary of this function goes here
%   Detailed explanation goes here

%calculate motor deliverable
wheelT = Torque*Car.gearR;
MaxForwardForceMotor = wheelT/(Tyre.Dia/2);

%calculate tyre possible
[FRLong,FLLong,RRLong,RLLong] = FindLongForce(Tyre, FRVert, FLVert, RRVert, RLVert, Car);
MaxForwardForceTyre = FRLong + FLLong + RRLong +RLLong;

%which is smaller
if MaxForwardForceTyre > MaxForwardForceMotor
    ForwardForce = MaxForwardForceMotor;
else
    ForwardForce = MaxForwardForceTyre;
end

%calculate speed
Accell = ForwardForce/Car.mass;
Speed = sqrt((PreviousSpeed^2) + (2*Accell*Distance));

end

