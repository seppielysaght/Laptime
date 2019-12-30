function [FRLoad, FLLoad, RRLoad, RLLoad] = FindCornerWeight(Car, Radius, Speed )
%FINDCORNERWEIGHT Summary of this function goes here
%   Detailed explanation goes here

fStaticRearAxle = ((Car.wheelbase-Car.COGposition)/Car.wheelbase)*(Car.mass*9.81);
fStaticFrontAxle = (Car.mass*9.81)-fStaticRearAxle;
FRLoad = fStaticFrontAxle/2;
FLLoad = fStaticFrontAxle/2;
RRLoad = fStaticRearAxle/2;
RLLoad = fStaticRearAxle/2; 

end

