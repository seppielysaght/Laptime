function [Output] = Simulation(Track,Car,Tyre)
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
Output.FRMotorRPM = ones(Track.lenght,1);
Output.FLMotorRPM = ones(Track.lenght,1);
Output.RRMotorRPM = ones(Track.lenght,1);
Output.RLMotorRPM = ones(Track.lenght,1);
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
Output.CSpeed = zeros(Track.lenght,1);
Output.ASpeed = zeros(Track.lenght,1);

%Calculate per Input step 

for n=5:Track.lenght
    %Motor Torque and Power use
    Output.Distance(n) = Output.Distance(n-1)+Track.Dis(n);
    [Output.FRTorque(n), Output.FRPower(n)] = MotorLookup(Output.FRMotorRPM(n-1), Car);
    [Output.FLTorque(n), Output.FLPower(n)] = MotorLookup(Output.FLMotorRPM(n-1), Car);
    [Output.RRTorque(n), Output.RRPower(n)] = MotorLookup(Output.RRMotorRPM(n-1), Car);
    [Output.RLTorque(n), Output.RLPower(n)] = MotorLookup(Output.RLMotorRPM(n-1), Car);
    
    [Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n)] = FindCornerWeight(Car, Track.Radius(n), Output.Speed(n-1));
    %How do I calculate new Motor RPM?
    [Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRVerticalForceMax(n),Output.RLVerticalForceMax(n)] = FindLateralForce(Tyre, Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n), Car);
    %This is max i need to add whats used
    Torque = Output.FRTorque(n) + Output.FLTorque(n) + Output.RRTorque(n) + Output.RLTorque(n);%Here is wher torque vectoring needs to be added
    [Output.Speed(n),Output.CSpeed(n),Output.ASpeed(n)] = MaxSpeed(Tyre, Torque, Output.Speed(n-1), Track.Dis(n), Car, Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRVerticalForceMax(n),Output.RLVerticalForceMax(n), Track.Radius(n));
    Output.time(n) = Track.Dis(n)/(Track.Dis(n)*(Output.Speed(n-1)+Output.Speed(n)));
end

end

