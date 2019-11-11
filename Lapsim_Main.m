% *************************************************************************
% SCRIPT NAME:
%   Lapsim_Main
%
% DESCRIPTION:
%   This script simulates the fastest laptime arround a circuit.
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   04/11/2019: Initial creation
% *************************************************************************
clear

%Load Track Values 
load('C:\Laptime\Tracks\CroixTernoisTrack.mat')

%calculate curvature
Track = curvature(Track);

%Create Result STRUCT
Output.steps = zeros(Track.lenght,1);

%Load Car parameters
load('C:\Laptime\Cars\RoughTestValuesFSCar.mat')

%Calculate Vertical Corner Loads
Output = cornerWeights(Car,Track,Output);

%Calculate max cornering speed
Output = maxCorneringSpeed(Track,Car,Output);
