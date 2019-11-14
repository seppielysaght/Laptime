function [Output] = laptimeCalc(Output,Track)
% *************************************************************************
% SCRIPT NAME:
%   Laptime simualtion
%
% DESCRIPTION:
%   This script calculates the lap time for these settings
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   04/11/2019: Initial creation
% *************************************************************************

Output.time = zeros(Track.lenght,1);

for n = 2:Track.lenght
    Output.time(n) = 0.5/(0.5*(Output.Speed(n-1)+Output.Speed(n))); 
end

laptime = sum(Output.time)

end

