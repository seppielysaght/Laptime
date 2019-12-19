function [Output] = Simulation(Track,Car)
%SIMULATION Summary of this function goes here
%   Detailed explanation goes here

%Set up Output Data
Output.Distance = zeros(Track.lenght,1);
Output.Time = zeros(Track.lenght,1);
Output.FRVerticalLoad = zeros(Track.lenght,1);
Output.FLVerticalLoad = zeros(Track.lenght,1);
Output.RRVerticalLoad = zeros(Track.lenght,1);
Output.RLVerticalLoad = zeros(Track.lenght,1);
Output.Speed = zeros(Track.lenght,1);
Output.FRLateralForce = zeros(Track.lenght,1);
Output.FLLateralForce = zeros(Track.lenght,1);
Output.RRLateralForce = zeros(Track.lenght,1);
Output.RLLateralForce = zeros(Track.lenght,1);
Output.YawRate = zeros(Track.lenght,1);
Output.GLong = zeros(Track.lenght,1);
Output.Glat = zeros(Track.lenght,1);
Output.FRMotorRPM = zeros(Track.lenght,1);
Output.FLMotorRPM = zeros(Track.lenght,1);
Output.RRMotorRPM = zeros(Track.lenght,1);
Output.RLMotorRPM = zeros(Track.lenght,1);
Output.AccelSpeed = zeros(Track.lenght,1);
Output.DeccelSpeed = zeros(Track.lenght,1);
Output.CornerSpeed = zeros(Track.lenght,1);
Output.FRPower = zeros(Track.lenght,1);
Output.FRTorque = zeros(Track.lenght,1);
Output.FLPower = zeros(Track.lenght,1);
Output.FLTorque = zeros(Track.lenght,1);
Output.RRPower = zeros(Track.lenght,1);
Output.RRTorque = zeros(Track.lenght,1);
Output.RLPower = zeros(Track.lenght,1);
Output.RLTorque = zeros(Track.lenght,1);

%Calculate per Input step 

for n=2:Track.lenght
    Output.Distance(n) = Output.Distance(n-1)+Track.Dis(n);
    Output.FRTorque(n) = TorqueLookup(Output.FRMotorRPM(n-1),Car);
    Output.FLTorque(n) = TorqueLookup(Output.FLMotorRPM(n-1),Car);
    Output.RRTorque(n) = TorqueLookup(Output.RRMotorRPM(n-1),Car);
    Output.RLTorque(n) = TorqueLookup(Output.RLMotorRPM(n-1),Car);
    Output.FRPower(n) = PowerLookup(Output.FRMotorRPM(n-1),Car);
    Output.FLPower(n) = PowerLookup(Output.FLMotorRPM(n-1),Car);
    Output.RRPower(n) = PowerLookup(Output.RRMotorRPM(n-1),Car);
    Output.RLPower(n) = PowerLookup(Output.RLMotorRPM(n-1),Car);
    Output.FRLateralForce(n) = 
    Output.FLLateralForce(n) = 
    Output.RRLateralForce(n) = 
    Output.RLLateralForce(n) =
end

end

