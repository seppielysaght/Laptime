function [Output] = maxCorneringSpeed(Track,Car,Output)
% *************************************************************************
% FUNCTION NAME:
%   maxCorneringSpeed
%
% DESCRIPTION:
%   This function takes in Track and Car values and calculates maximum
%   cornering speed for each sector
%
% INPUTS:
%   Track struct after curvature and radius calc and Car struct
%
% OUTPUTS:
%   Updated Track Struct to include max corner speed
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   11/11/2019: Initial creation
% *************************************************************************
Output.maxCornerSpeed = zeros(Track.lenght,1);
Output.FRLatMax = zeros(Track.lenght,1);
Output.FLLatMax = zeros(Track.lenght,1);
Output.RRLatMax = zeros(Track.lenght,1);
Output.RLLatMax = zeros(Track.lenght,1);

%Calculating max lateral force
for n = 1:Track.lenght
    %Calculate max lateral forces for each wheel and for total car
    Output.FRLatMax(n) = Output.FRVerticalLoad(n).*Car.cof;
    Output.FLLatMax(n) = Output.FLVerticalLoad(n).*Car.cof;
    Output.RRLatMax(n) = Output.RRVerticalLoad(n).*Car.cof;
    Output.RLLatMax(n) = Output.RLVerticalLoad(n).*Car.cof;
    Output.maxLatForce(n) = (Output.FRLatMax(n) + Output.FLLatMax(n) + Output.RRLatMax(n) + Output.RLLatMax(n));
    
    %Calculate max corner speed
    Output.VmaxCorner(n) = sqrt((Output.maxLatForce(n)*Track.radius(n))/Car.mass);
end

end

