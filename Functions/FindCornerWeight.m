function [FRLoad, FLLoad, RRLoad, RLLoad] = FindCornerWeight(Car, latG, dir, longG)
% *************************************************************************
% SCRIPT NAME:
%   FindCornerWeights.m
%
% INPUTS:
%   Car parameters Struct, Lateral Forces (G), Curvature direction from track file, Longitudinal Forces (G) 
% 
% OUTPUTS:
%   FRLoad (N), FLLoad (N), RRLoad (N), RLLoad (N)
% *************************************************************************

%Calculate Static Load 
fStaticRearAxle = ((Car.wheelbase-Car.COGposition)/Car.wheelbase)*(Car.mass*9.81);
fStaticFrontAxle = (Car.mass*9.81)-fStaticRearAxle;

%Calculate Lateral Weight Transfer 
latWeightTransferFront = (Car.LatWeightTransfer)*((Car.mass*latG*Car.COGheight)/Car.trackwidth);
latWeightTransferRear = (1-Car.LatWeightTransfer)*((Car.mass*latG*Car.COGheight)/Car.trackwidth);

%Calculate Long weight Transfer
longWeightTransfer = ((Car.COGheight/Car.wheelbase)*Car.mass*longG);

if dir == 0 
    %Going Straight only Longitudinal 
    FRLoad = fStaticFrontAxle/2 - (longWeightTransfer/2);
    FLLoad = fStaticFrontAxle/2 - (longWeightTransfer/2);
    RRLoad = fStaticRearAxle/2 + (longWeightTransfer/2);
    RLLoad = fStaticRearAxle/2 + (longWeightTransfer/2);
elseif dir == 1
    %Going left 
    FRLoad = (fStaticFrontAxle/2) + latWeightTransferFront - (longWeightTransfer/2);
    FLLoad = (fStaticFrontAxle/2) - latWeightTransferFront - (longWeightTransfer/2);
    RRLoad = (fStaticRearAxle/2) + latWeightTransferRear + (longWeightTransfer/2);
    RLLoad = (fStaticRearAxle/2) - latWeightTransferRear + (longWeightTransfer/2);
else
    %going right 
    FRLoad = (fStaticFrontAxle/2) - latWeightTransferFront - (longWeightTransfer/2);
    FLLoad = (fStaticFrontAxle/2) + latWeightTransferFront - (longWeightTransfer/2);
    RRLoad = (fStaticRearAxle/2) - latWeightTransferRear + (longWeightTransfer/2);
    RLLoad = (fStaticRearAxle/2) + latWeightTransferRear + (longWeightTransfer/2);
end  

end

