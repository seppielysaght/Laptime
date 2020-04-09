function [Track] = ApexFinder(Track)
% *************************************************************************
% SCRIPT NAME:
%   ApexFinder.m
%
% INPUTS:
%   Track Data
% 
% OUTPUTS:
%   Updated Track Data
% *************************************************************************

%Adds the apex array to the track struct
Track.apex = zeros(Track.lenght,1);

%Initilises a curvature array which is the absolute of the curv from track file incase there is direction indicated in the array of the track file. 
curvature = abs(Track.curv);

%For loop to check if the current point is a apex
for n = 5:Track.lenght-2
    if Track.Radius(n) > 5
        previous = Track.apex(n-1)+Track.apex(n-2)+Track.apex(n-3)+Track.apex(n-4);
        if curvature(n) > curvature(n-1) && curvature(n) > curvature(n+1) && previous < 0.9
            Track.apex(n) = 1;
        else
            Track.apex(n) = 0;
        end
    end
end %For loop end 

end %Function end 

