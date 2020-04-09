function [dragF] = AeroDrag(Car, Speed, roh)
% *************************************************************************
% SCRIPT NAME:
%   AeroDrag.m
%
% INPUTS:
%   Frontal Area (m^2), Aero Drag Coefficent (n/a), Vehicle Speed (m/s), Air density (kg/m^3) 
% 
% OUTPUTS:
%   Drag Force (N) 
% *************************************************************************

%Using the drag formula
dragF = ((Speed^2)*0.5*Car.Cd*Car.FrontalA*roh);

end

