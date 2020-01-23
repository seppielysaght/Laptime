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
Working.Speeds.Entry = zeros(Track.lenght,1);
Working.Speeds.Exit = zeros(Track.lenght,1);

%Calculate forward per Input step 
for n=2:Track.lenght
    %Motor Torque and Power use
    Output.Distance(n) = Output.Distance(n-1)+Track.Dis(n);
    
    %Rough RPM calculation for the time being
    Output.FRMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    Output.FLMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    Output.RLMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    Output.RRMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    
    %Torque and Power Lookup
    [Output.FRTorque(n), Output.FRPower(n)] = MotorLookup(Output.FRMotorRPM(n-1), Car);
    [Output.FLTorque(n), Output.FLPower(n)] = MotorLookup(Output.FLMotorRPM(n-1), Car);
    [Output.RRTorque(n), Output.RRPower(n)] = MotorLookup(Output.RRMotorRPM(n-1), Car);
    [Output.RLTorque(n), Output.RLPower(n)] = MotorLookup(Output.RLMotorRPM(n-1), Car);
    
    %Lateral Acceleration Calc 
    Output.Glat(n) = (Output.Speed(n-1)^2)/Track.Radius(n-1);
    
    %Calculates Vertical load at each corner
    [Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n)] = FindCornerWeight(Car, Output.Glat(n), Track.Dir(n));
    
    %Calculates Max lateral force availble at the tyre
    [Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRLateralForceMax(n),Output.RLLateralForceMax(n)] = FindLateralForce(Tyre, Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n), Car);
    
    %Calculate used lateral force of each wheel
    
    %Total forward torque (TV not implemented currently to all torque
    %forward
    FTorque = Output.FRTorque(n) + Output.FLTorque(n) + Output.RRTorque(n) + Output.RLTorque(n);
    
    %Speed Calculation
    [Output.Speed(n),Output.CornerSpeed(n),Output.AccelSpeed(n),Working.Speeds.Entry(n),Working.Speeds.Exit(n)] = MaxSpeed(Tyre, FTorque, Output.Speed(n-1), Track.Dis(n), Car, Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRLateralForceMax(n),Output.RLLateralForceMax(n), Track.Radius(n));
    
    %Lap time calculated
    Output.time(n) = Track.Dis(n)/(0.5*(Output.Speed(n-1)+Output.Speed(n)));
end %forward end 

%Calculate backwards per input step 
n = Track.lenght-1;
while n >= 2 
    
    FLBrakingForce = Output.FLVerticalLoad(n)*Tyre.longcof;
    FRBrakingForce = Output.FRVerticalLoad(n)*Tyre.longcof;
    RRBrakingForce = Output.RRVerticalLoad(n)*Tyre.longcof;
    RLBrakingForce = Output.RLVerticalLoad(n)*Tyre.longcof;
    TotalBraking = FLBrakingForce + FRBrakingForce + RRBrakingForce + RLBrakingForce;
    decella = TotalBraking/Car.mass;
    Output.DeccelSpeed(n) = sqrt((Output.Speed(n+1)^2) + (2*decella*Track.Dis(n)));
    n = n - 1;
end %Back cal end

end %Function end 

