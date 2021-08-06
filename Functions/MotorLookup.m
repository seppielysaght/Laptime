function [FRTorque, FRPower, FRMotorRPM, FLTorque, FLPower, FLMotorRPM, RRTorque, ...
    RRPower, RRMotorRPM, RLTorque, RLPower, RLMotorRPM] ...
    = MotorLookup(Car, PowerLimit, Tyre, Speed, RegenBit)
% *************************************************************************
% SCRIPT NAME:
%   MotorLookup.m
%
% INPUTS:
%   Car Struct, PowerLimit, Tyre and Entry speed
% 
% OUTPUTS:
%   Individual motor properties
% *************************************************************************

%Check if for accell or regen calcs
if RegenBit == 1
    %do regen stuff
    TSplit = Car.RegenSplit/100;
    multiplier = -1;
else
    %do normal stuff 
    TSplit = Car.TorqueSplit/100;
    multiplier = 1;
end

%Assuming all wheel speeds the same calculate motor RPM
MotorRPM = round((Speed/(2*pi()*(Tyre.Dia/2)))*60*Car.gearR,0);

%Conditioning the rpm, Lookup does not work with 0 
if MotorRPM == 0 
    MotorRPM = 0.0000001;
elseif MotorRPM > 19999
    MotorRPM = 19999;
end

%find max possible torque from motor at this rpm
MaxTorque = interp1(Car.MotorTorqueCurve.RPM,Car.MotorTorqueCurve.Torque,MotorRPM,'linear');

%Calculate the other torque
RearS = Car.TorqueSplit;
FrontS = 100 - RearS;
if RearS > FrontS 
    %other torque is Front 
    OtherTorque = (MaxTorque/RearS)*FrontS;
else 
    %other torque is Rear 
    OtherTorque = (MaxTorque/FrontS)*RearS;
end

%Find efficency for this torque and speed 
effMap = interp1(Car.MotorEffMap.RPM,Car.MotorEffMap.EFF,MotorRPM,'linear');
if MaxTorque < min(Car.MotorEffMap.T)
    eff1 = min(effMap);
else
    eff1 = interp1(Car.MotorEffMap.T,effMap,MaxTorque,'linear')/100;
end
if MaxTorque < min(Car.MotorEffMap.T)
    eff2 = min(effMap);
else
    eff2 = interp1(Car.MotorEffMap.T,effMap,OtherTorque,'linear')/100;
end

%Find Power by this torque
Poweratwheel1 = (MaxTorque * MotorRPM / 9.5488)/eff1;
Poweratwheel2 = (OtherTorque * MotorRPM / 9.5488)/eff2;

%With torque split what would total power be
Power = (Poweratwheel1*2) + (Poweratwheel2*2);

if Power < PowerLimit
    %find torque by power limit
    if TSplit > 0.5 
        RearT = MaxTorque*2;
        FrontT = OtherTorque*2;
    else 
        RearT = OtherTorque*2;
        FrontT = MaxTorque*2;
    end
else
    %Roughtly the Torque possible (Need to incorporate efficency)
    TotalT = (9.5488 * (PowerLimit*1000)) / MotorRPM;
    
    %With Torque split
    RearT = TotalT*TSplit;
    FrontT = TotalT - RearT; 
end

%Outputting the individual Motor speeds
FRMotorRPM = MotorRPM;
FLMotorRPM = MotorRPM;
RRMotorRPM = MotorRPM;
RLMotorRPM = MotorRPM;

%Front Right Motor 
if MotorRPM >= 19999
    FRPower = 0;
    FLPower = 0;
    RRPower = 0;
    RLPower = 0;
    FRTorque = 0;
    FLTorque = 0;
    RRTorque = 0;
    RLTorque = 0;
else
    %individula wheel torques
    Tf = FrontT/2;
    Tr = RearT/2;
    
    %check they dont break motor limits
    if Tf > MaxTorque
        Tf = MaxTorque;
        Tr = (MaxTorque/FrontS)*RearS;
    end
    if Tr > MaxTorque
        Tf = (MaxTorque/RearS)*FrontS;
        Tr = MaxTorque;
    end

    %Find efficency for this torque and speed
    effMap = interp1(Car.MotorEffMap.RPM,Car.MotorEffMap.EFF,MotorRPM,'linear');
    
    %Check for below min of torque lookup
    if Tf < min(Car.MotorEffMap.T)
        fronteff = min(effMap);
    else
        fronteff = interp1(Car.MotorEffMap.T,effMap,Tf,'linear')/100;
    end
    %same for rear torque
    if Tr < min(Car.MotorEffMap.T)
        reareff = min(effMap);
    else
        reareff = interp1(Car.MotorEffMap.T,effMap,Tr,'linear')/100;
    end
    
    %assign correct torque and power to each wheel 
    FRTorque = Tf*multiplier;
    FLTorque = Tf*multiplier;
    RRTorque = Tr*multiplier;
    RLTorque = Tr*multiplier;

    FRPower = (FRTorque * FRMotorRPM / 9.5488)/fronteff;
    FLPower = (FLTorque * FLMotorRPM / 9.5488)/fronteff;
    RRPower = (RRTorque * RRMotorRPM / 9.5488)/reareff;
    RLPower = (RLTorque * RLMotorRPM / 9.5488)/reareff;
end

end %FUNCTION END 

