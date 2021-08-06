% *************************************************************************
% SCRIPT NAME:
%   Lapsim_Main
%
% DESCRIPTION:
%   This script simulates the fastest laptime arround a circuit.
% 
% KNOW ISSUES:
%   1-
%
% CHANGE LOG:
%   04/11/2019: Initial creation
%   11/11/2019: Corner weight and corner speed added.
%   11/02/2020: Weight transfer and traction limit added
%   13/02/2020: Aero drag and downforce added 
%   12/03/2020: Torque added to maintain top speed evenly
%   13/03/2020: Battery Calculation added
%   26/03/2020: Motor Model added for power consumtion and Enforced power limits
% *************************************************************************

clear

%Load Track Values 
load('C:\Laptime\Tracks\MainTrack_MorePoints.mat')
%load('\\brookesf1\s59\17031059\GitHub\Laptime\Tracks\FSGEnduranceDistanceRadiusCurvOnly.mat')

%calculate curvature
if Track.curvdone == 0
    Track = curvature(Track);
end

%calculate apexs 
Track = ApexFinder(Track);

%Load Car parameters
load('C:\Laptime\Cars\TorqueSplit\0.mat')
% load('\\brookesf1\s59\17031059\GitHub\Laptime\Cars\TestUpdatedMotorMapbiggergr.mat')

%Load Tyre Parameters
load('C:\Laptime\Tyres\Main_Tyre_Load.mat')
%load('\\brookesf1\s59\17031059\GitHub\Laptime\Tyres\TestTyre.mat')

%Run Simulation
Output = Simulation(Track, Car, Tyre);

%Time Output
Output.laptime = sum(Output.Time);

