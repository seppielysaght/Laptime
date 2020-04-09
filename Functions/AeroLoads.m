function [FRLoad, FLLoad, RRLoad, RLLoad] = AeroLoads(Car, Speed, roh)
% *************************************************************************
% SCRIPT NAME:
%   AeroDrag.m
%
% INPUTS:
%   Frontal Area (m^2), Aero Lift Coefficent (n/a), Vehicle Speed (m/s), Air density (kg/m^3) 
% 
% OUTPUTS:
%   FRLoad (N), FLLoad (N), RRLoad (N), RLLoad (N)
% *************************************************************************

%Calculating total resultant downforce
DFTotal = ((Speed^2)*0.5*Car.Cl*Car.FrontalA*roh);

%Deviding per axle (COP location not used yet)
FAxleAero = DFTotal/2;
RAxleAero = DFTotal/2;

%Deviding per corner (COP not used yet)
FRLoad = FAxleAero/2;
FLLoad = FAxleAero/2;
RRLoad = RAxleAero/2;
RLLoad = RAxleAero/2;

end

