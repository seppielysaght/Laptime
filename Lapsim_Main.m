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
%   11/11/2019: Corner weight and corner speed added.
% *************************************************************************
clear

%Load Track Values 
load('C:\Laptime\Tracks\CroixTernoisTrack.mat')

%calculate curvature
Track = curvature(Track);

%calculate apexs 
Track = Apexfinder(Track);

%Create Result STRUCT
Output.steps = zeros(Track.lenght,1);

%Load Car parameters
load('C:\Laptime\Cars\RoughTestValuesFSCar.mat')

%Calculate Vertical Corner Loads
Output = cornerWeights(Car,Track,Output);

%Calculate max cornering speed
Output = maxCorneringSpeed(Track,Car,Output);

%calculate max straight line 
Output = maxSpeed(Output,Car,Track);

%calculate lap time 
Output = laptimeCalc(Output,Track);