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
load('C:\Laptime\Tracks\FSGEnduranceDistanceRadiusCurvOnly.mat')
%load('\\brookesf1\s59\17031059\GitHub\Laptime\Tracks\FSGEnduranceDistanceRadiusCurvOnly.mat')

%calculate curvature
if Track.curvdone == 0
    Track = curvature(Track);
end

%calculate apexs 
Track = Apexfinder(Track);

%Load Car parameters
load('C:\Laptime\Cars\Main_car.mat')
%load('\\brookesf1\s59\17031059\GitHub\Laptime\Cars\TestUpdatedMotorMapbiggergr.mat')

%Load Tyre Parameters
load('C:\Laptime\Tyres\Main_Tyre.mat')
%load('\\brookesf1\s59\17031059\GitHub\Laptime\Tyres\TestTyre.mat')

%Run Simulation
Output = Simulation(Track, Car, Tyre);

%Time Output
laptime = sum(Output.Time)