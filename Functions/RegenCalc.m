function [FRPower,FLPower,RRPower,RLPower, FRTorque, FLTorque, RRTorque, RLTorque] = RegenCalc( Speed, Car, MaxChargePower, Tyre)
%REGENCALC Summary of this function goes here
%   Detailed explanation goes here

%Calculate Wheel Speed
FRMotorRPM = round((Speed/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
FLMotorRPM = round((Speed/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
RRMotorRPM = round((Speed/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
RLMotorRPM = round((Speed/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);

%Divide the pack charge limit to 
MaxWheelPower = MaxChargePower/4;

%Look Up availible torque and used power at that speed
[FRTorque, FRPower] = MotorLookup(FRMotorRPM, Car, MaxWheelPower, Car.TorqueSplit);
[FLTorque, FLPower] = MotorLookup(FLMotorRPM, Car, MaxWheelPower, Car.TorqueSplit);
[RRTorque, RRPower] = MotorLookup(RRMotorRPM, Car, MaxWheelPower, Car.TorqueSplit);
[RLTorque, RLPower] = MotorLookup(RLMotorRPM, Car, MaxWheelPower, Car.TorqueSplit);

%Convert to negative for regen
FRTorque = FRTorque * -1;
FLTorque = FLTorque * -1;
RRTorque = RRTorque * -1;
RLTorque = RLTorque * -1;
FRPower = FRPower * -1;
FLPower = FLPower * -1;
RRPower = RRPower * -1;
RLPower = RLPower * -1;


end