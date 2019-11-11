function [Output] = cornerWeights(Car,Track,Output)
% *************************************************************************
% FUNCTION NAME:
%   cornerWeights
%
% DESCRIPTION:
%   This function takes in a Struct for Car info and Track and outputs corner weights
%   for each section. 
%
% INPUTS:
%   Track and Car Struck
%
% OUTPUTS:
%   Output Struct filled with results
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   11/11/2019: Initial creation with only statis laods
% *************************************************************************
Output.FRVerticalLoad = zeros(Track.lenght,1);
Output.FLVerticalLoad = zeros(Track.lenght,1);
Output.RRVerticalLoad = zeros(Track.lenght,1);
Output.RLVerticalLoad = zeros(Track.lenght,1);

for n = 1:Track.lenght
    fRearAxle = ((Car.wheelbase-Car.COGposition)/Car.wheelbase)*(Car.mass*9.81);
    fFrontAxle = (Car.mass*9.81)-fRearAxle;
    Output.FRVerticalLoad(n) = fFrontAxle/2;
    Output.FLVerticalLoad(n) = fFrontAxle/2;
    Output.RRVerticalLoad(n) = fRearAxle/2;
    Output.RLVerticalLoad(n) = fRearAxle/2;
end

%Uncomment to see load graphs
% plot(Output.FRVerticalLoad)
% hold on
% plot(Output.FLVerticalLoad)
% hold on
% plot(Output.RRVerticalLoad)
% hold on
% plot(Output.RLVerticalLoad)

end

