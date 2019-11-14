function [Output,Car] = maxSpeed(Output,Car,Track)
% *************************************************************************
% SCRIPT NAME:
%   maxStraighLineSpeed
%
% DESCRIPTION:
%   This script calculates the max straight line speed.
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   04/11/2019: Initial creation
% *************************************************************************
Tyreradius = Car.tyreDia/2;

wheelTorque = Car.maxT*Car.gearR;

totalcarT = wheelTorque*4;

forceF = totalcarT*Tyreradius;

Car.a = forceF/Car.mass;


Output.maxVstraight = zeros(Track.lenght,1);
Output.Vbraking = zeros(Track.lenght,1);
Output.Speed = zeros(Track.lenght,1);
Output.maxVstraight(1) = 0;

for n = 2:Track.lenght
    if Track.radiusfilt(n) > 5
        a = 0;
    else
        a = Car.a;
    end
    if Track.apex(n-1) == 1 
        if Output.maxVstraight(n-1) > Output.VmaxCorner(n-1)
            Output.maxVstraight(n) = sqrt(Output.VmaxCorner(n-1)^2 + 2*a*(0.5));
        else
            Output.maxVstraight(n) = sqrt(Output.maxVstraight(n-1)^2 + 2*a*(0.5));
        end
    else
        Output.maxVstraight(n) = sqrt(Output.maxVstraight(n-1)^2 + 2*a*(0.5));
    end
end

i = Track.lenght-1;
while i > 1
    d = 9.81;
    if Track.apex(i) == 1
        Output.Vbraking(i) = sqrt(Output.VmaxCorner(i+1)^2 + 2*d*(0.5));
    else
        Output.Vbraking(i) = sqrt(Output.Vbraking(i+1)^2 + 2*d*(0.5));
    end
    i = i -1;
end

for n = 1:Track.lenght
    if Output.Vbraking(n) < Output.maxVstraight(n)
        Output.Speed(n) = Output.Vbraking(n);
    else
        Output.Speed(n) = Output.maxVstraight(n);
    end
end

figure('Name','Speed');
% plot(Output.maxVstraight)
% hold on 
% plot(Output.Vbraking)
% hold on 
plot(Output.Speed)
end
