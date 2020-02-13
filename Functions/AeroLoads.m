function [FRLoad, FLLoad, RRLoad, RLLoad] = AeroLoads(Car, Speed, roh)
%AEROLOADS Summary of this function goes here
%   Detailed explanation goes here

DFTotal = ((Speed^2)*0.5*Car.Cl*Car.FrontalA*roh);
FAxleAero = DFTotal/2;
RAxleAero = DFTotal/2;

FRLoad = FAxleAero/2;
FLLoad = FAxleAero/2;
RRLoad = RAxleAero/2;
RLLoad = RAxleAero/2;

end

