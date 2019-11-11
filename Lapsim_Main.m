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
load('C:\Laptime\Tracks\CroixTernoisTrack.mat')
Track = curvature(Track); 