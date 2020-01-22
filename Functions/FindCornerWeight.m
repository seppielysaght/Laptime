function [FRLoad, FLLoad, RRLoad, RLLoad] = FindCornerWeight(Car, latG, dir)
%FINDCORNERWEIGHT Summary of this function goes here
%   Detailed explanation goes here

%Calculate Static Load 
fStaticRearAxle = ((Car.wheelbase-Car.COGposition)/Car.wheelbase)*(Car.mass*9.81);
fStaticFrontAxle = (Car.mass*9.81)-fStaticRearAxle;

%Calculate Lateral Weight Transfer 
latWeightTransferFront = (Car.LatWeightTransfer)*((Car.mass*latG*Car.COGheight)/Car.trackwidth);
latWeightTransferRear = (1-Car.LatWeightTransfer)*((Car.mass*latG*Car.COGheight)/Car.trackwidth);

if dir == 0 
    %Going Straight only Longitudinal 
    FRLoad = fStaticFrontAxle/2;
    FLLoad = fStaticFrontAxle/2;
    RRLoad = fStaticRearAxle/2;
    RLLoad = fStaticRearAxle/2;
elseif dir == 1
    %Going left 
    FRLoad = (fStaticFrontAxle/2) + latWeightTransferFront;
    FLLoad = (fStaticFrontAxle/2) - latWeightTransferFront;
    RRLoad = (fStaticRearAxle/2) + latWeightTransferRear;
    RLLoad = (fStaticRearAxle/2) - latWeightTransferRear;
else
    %going right 
    FRLoad = (fStaticFrontAxle/2) - latWeightTransferFront;
    FLLoad = (fStaticFrontAxle/2) + latWeightTransferFront;
    RRLoad = (fStaticRearAxle/2) - latWeightTransferRear;
    RLLoad = (fStaticRearAxle/2) + latWeightTransferRear;
end  

end

