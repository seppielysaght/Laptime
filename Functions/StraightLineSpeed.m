function [Speed] = StraightLineSpeed(Tyre, FRTorque, FLTorque, ...
    RRTorque, RLTorque, PreviousSpeed, Distance, Car, FRVert, FLVert, RRVert, RLVert, dragF)

% *************************************************************************
% SCRIPT NAME:
%   StraightLineSpeed.m
%
% INPUTS:
%   Car Struct, Tyre and Entry speed, vertiacl loads, drag and Torque
% 
% OUTPUTS:
%   Straight line speed
% *************************************************************************

%Check motors have not hit a limitor
if FRTorque > 0 
    %calculate motor deliverable
    FRwheelT = FRTorque*Car.gearR;
    MaxForwardForceFRMotor = FRwheelT/(Tyre.Dia/2);
    FLwheelT = FLTorque*Car.gearR;
    MaxForwardForceFLMotor = FLwheelT/(Tyre.Dia/2);
    RRwheelT = RRTorque*Car.gearR;
    MaxForwardForceRRMotor = RRwheelT/(Tyre.Dia/2);
    RLwheelT = RLTorque*Car.gearR;
    MaxForwardForceRLMotor = RLwheelT/(Tyre.Dia/2);
    
    %calculate tyre possible
    [FRLong,FLLong,RRLong,RLLong] = FindLongForce(Tyre, FRVert, FLVert, RRVert, RLVert, Car);
    
    %Use the biggest forward force on each wheel
    %Front Right
    if MaxForwardForceFRMotor < FRLong
        FRf = MaxForwardForceFRMotor;
    else
        FRf = FRLong;
    end
    
    %Front Left 
    if MaxForwardForceFLMotor < FLLong
        FLf = MaxForwardForceFLMotor;
    else
        FLf = FLLong;
    end
    
    %Rear Right 
    if MaxForwardForceRRMotor < RRLong
        RRf = MaxForwardForceRRMotor;
    else
        RRf = RRLong;
    end
    
    %Rear left 
    if MaxForwardForceRLMotor < RLLong
        RLf = MaxForwardForceRLMotor;
    else
        RLf = RLLong;
    end
    
    accellforce = FRf + FLf + RRf + RLf;
    
    %subract drag from forward force
    ForwardForce = accellforce - dragF;
    
    %calculate speed
    Accell = ForwardForce/Car.mass;
    Speed = sqrt((PreviousSpeed^2) + (2*Accell*Distance));
else
    Speed = PreviousSpeed;
end

end

