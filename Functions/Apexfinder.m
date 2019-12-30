function [Track] = Apexfinder(Track)
% *************************************************************************
% SCRIPT NAME:
%   Apex finder
%
% DESCRIPTION:
%   This script looks at curvature and find apexes
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   04/11/2019: Initial creation
% *************************************************************************
Track.apex = zeros(Track.lenght,1);
curvature = abs(Track.curv);

for n = 5:Track.lenght-2
    if Track.Radius(n) > 5
        previous = Track.apex(n-1)+Track.apex(n-2)+Track.apex(n-3)+Track.apex(n-4);
        if curvature(n) > curvature(n-1) && curvature(n) > curvature(n+1) && previous < 0.9
            Track.apex(n) = 1;
        else
            Track.apex(n) = 0;
        end
    end
end

end

