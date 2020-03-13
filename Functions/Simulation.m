function [Output] = Simulation(Track,Car,Tyre)
%SIMULATION Summary of this function goes here
%   Detailed explanation goes here
tic
%Set up Output Data
Output.Distance = zeros(Track.lenght,1);
Output.Time = zeros(Track.lenght,1);
Output.FRVerticalLoad = zeros(Track.lenght,1);
Output.FLVerticalLoad = zeros(Track.lenght,1);
Output.RRVerticalLoad = zeros(Track.lenght,1);
Output.RLVerticalLoad = zeros(Track.lenght,1);
Output.FRVerticalAeroLoad = zeros(Track.lenght,1);
Output.FLVerticalAeroLoad = zeros(Track.lenght,1);
Output.RRVerticalAeroLoad = zeros(Track.lenght,1);
Output.RLVerticalAeroLoad = zeros(Track.lenght,1);
Output.FRVerticalMechLoad = zeros(Track.lenght,1);
Output.FLVerticalMechLoad = zeros(Track.lenght,1);
Output.RRVerticalMechLoad = zeros(Track.lenght,1);
Output.RLVerticalMechLoad = zeros(Track.lenght,1);
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
Output.Braking = zeros(Track.lenght,1);

Output.Time(2) = 0.00000000001;

%calculate battery specifications
[MaxVoltage, MaxChargeI, MaxDischargeI, Capacity] = batterydesign( Car );

%Calculate forward per Input step 
for n=3:Track.lenght
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
    if Track.Radius(n-1) == 0 
        Output.Glat(n) = 0;
    else
        Output.Glat(n) = (Output.Speed(n-1)^2)/Track.Radius(n-1);
    end
    
    %Longitdudinal Acceleration Calc
    Output.GLong(n) = (Output.Speed(n-1)-Output.Speed(n-2))/Output.Time(n-1);

    %Calculates Vertical load at each corner
    [Output.FRVerticalMechLoad(n),Output.FLVerticalMechLoad(n),Output.RRVerticalMechLoad(n),Output.RLVerticalMechLoad(n)] = FindCornerWeight(Car, Output.Glat(n), Track.Dir(n), Output.GLong(n));
    
    %Calculate the aero effects on load transfer
    [Output.FRVerticalAeroLoad(n),Output.FLVerticalAeroLoad(n),Output.RRVerticalAeroLoad(n),Output.RLVerticalAeroLoad(n)] = AeroLoads(Car, Output.Speed(n-1),Track.roh);
        
    %Sum together to get new loads
    Output.FRVerticalLoad(n) = Output.FRVerticalAeroLoad(n)+Output.FRVerticalMechLoad(n);
    Output.FLVerticalLoad(n) = Output.FLVerticalAeroLoad(n)+Output.FLVerticalMechLoad(n);
    Output.RRVerticalLoad(n) = Output.RRVerticalAeroLoad(n)+Output.RRVerticalMechLoad(n);
    Output.RLVerticalLoad(n) = Output.RLVerticalAeroLoad(n)+Output.RLVerticalMechLoad(n);
    
    %Calculates Max lateral force availble at the tyre
    [Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRLateralForceMax(n),Output.RLLateralForceMax(n)] = FindLateralForce(Tyre, Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n), Car);
    
    %Calculate used lateral force of each wheel
    
    %Total forward torque 
    FTorque = Output.FRTorque(n) + Output.FLTorque(n) + Output.RRTorque(n) + Output.RLTorque(n);
    
    %Calculate reward force caused by Aero Drag
    [dragF] = DragCalc(Car, Output.Speed(n-1), Track.roh);
    
    %Speed Calculation
    [Output.Speed(n),Output.CornerSpeed(n),Output.AccelSpeed(n)] = MaxSpeed(Tyre, FTorque, Output.Speed(n-1), Track.Dis(n), Car, Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRLateralForceMax(n),Output.RLLateralForceMax(n), Track.Radius(n),Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n),dragF);

    %Lap time calculated     
    Output.Time(n) = Track.Dis(n)/(0.5*(Output.Speed(n-1)+Output.Speed(n)));
    
end %forward end 

%Calculate backwards per input step 
n = Track.lenght-1;
Output.DeccelSpeed(Track.lenght) =  Output.Speed(Track.lenght);
while n >= 2 
    
    %Calculate max long at tyres.
    [FRLong,FLLong,RRLong,RLLong] = FindLongForce(Tyre, Output.FRVerticalLoad(n), Output.FLVerticalLoad(n), Output.RRVerticalLoad(n), Output.RLVerticalLoad(n), Car);
    
    TotalBraking = FLLong + FRLong + RRLong + RLLong;
    decella = TotalBraking/Car.mass;
    
    Output.DeccelSpeed(n) = sqrt((Output.DeccelSpeed(n+1)^2) + (2*decella*Track.Dis(n)));
    
    if Output.Speed(n) < Output.DeccelSpeed(n)
        Output.DeccelSpeed(n) = Output.Speed(n);
    end
    
    n = n - 1;
end %Back cal end

%Track is closed so exit speed from last point becomes entry speed to first point 
Output.Speed(2) = Output.Speed(Track.lenght);

%Forward calculate to make reassure correct values
for n=3:Track.lenght
    
    %Rough RPM calculation for the time being
    Output.FRMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    Output.FLMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    Output.RLMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    Output.RRMotorRPM(n) = round((Output.Speed(n-1)/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);
    
    %Torque and Power Lookup
    [Output.FRTorque(n), Output.FRPower(n)] = MotorLookup(Output.FRMotorRPM(n), Car);
    [Output.FLTorque(n), Output.FLPower(n)] = MotorLookup(Output.FLMotorRPM(n), Car);
    [Output.RRTorque(n), Output.RRPower(n)] = MotorLookup(Output.RRMotorRPM(n), Car);
    [Output.RLTorque(n), Output.RLPower(n)] = MotorLookup(Output.RLMotorRPM(n), Car);
    
    %Total forward torque 
    FTorque = Output.FRTorque(n) + Output.FLTorque(n) + Output.RRTorque(n) + Output.RLTorque(n);
    
    %calculate max regen power
    MaxChargePower = (MaxVoltage*MaxChargeI)/1000;
    
    if Output.DeccelSpeed(n) < Output.Speed(n)
        Output.Speed(n) = Output.DeccelSpeed(n);
        Output.Braking(n) = 1;
        Output.FRTorque(n) = Output.FRTorque(n)*-1;
        Output.FLTorque(n) = Output.FLTorque(n)*-1;
        Output.RRTorque(n) = Output.RRTorque(n)*-1;
        Output.RLTorque(n) = Output.RLTorque(n)*-1;
        if Output.FRPower(n)>MaxChargePower
            Output.FRPower(n) = MaxChargePower*-1;
        else
            Output.FRPower(n) = Output.FRPower(n)*-1;
        end
        if Output.FLPower(n)>MaxChargePower
            Output.FLPower(n) = MaxChargePower*-1;
        else
            Output.FLPower(n) = Output.FLPower(n)*-1;
        end
        if Output.RRPower(n)>MaxChargePower
            Output.RRPower(n) = MaxChargePower*-1;
        else
            Output.RRPower(n) = Output.RRPower(n)*-1;
        end
        if Output.RLPower(n)>MaxChargePower
            Output.RLPower(n) = MaxChargePower*-1;
        else
            Output.RLPower(n) = Output.RLPower(n)*-1;
        end

    else
        %Speed Calculation
        [Output.Speed(n),Output.CornerSpeed(n),Output.AccelSpeed(n)] = MaxSpeed(Tyre, FTorque, Output.Speed(n-1), Track.Dis(n), Car, Output.FRLateralForceMax(n),Output.FLLateralForceMax(n),Output.RRLateralForceMax(n),Output.RLLateralForceMax(n), Track.Radius(n),Output.FRVerticalLoad(n),Output.FLVerticalLoad(n),Output.RRVerticalLoad(n),Output.RLVerticalLoad(n),dragF);
        Output.Braking(n) = 0;
    end
    
    %Lateral Acceleration Calc 
    Output.Glat(n) = (Output.Speed(n)^2)/Track.Radius(n);
    
    %Longitdudinal Acceleration Calc
    Output.GLong(n) = (Output.Speed(n)-Output.Speed(n))/Output.Time(n);
    
    %Lap time calculated
    Output.Time(n) = Track.Dis(n)/(0.5*(Output.Speed(n-1)+Output.Speed(n))); 
    
end %End of final speed selection

Output.Speed(1) = Output.Speed(2);
toc %Stop Simulation timing
end %Function end 

