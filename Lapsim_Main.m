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

%calculate curvature
if Track.curvdone == 0
    Track = curvature(Track);
end

%calculate apexs 
Track = Apexfinder(Track);

%Load Car parameters
load('C:\Laptime\Cars\Test.mat')