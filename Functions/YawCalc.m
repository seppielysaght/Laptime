function [Track, Output ] = YawCalc(Track, Output)
% *************************************************************************
% SCRIPT NAME:
%   YawCalc
%
% DESCRIPTION:
%   This script calculates the yaw angle and direction.
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   25/11/2019: Initial Creation 
% *************************************************************************
Track.CornerDirection = zeros(Track.lenght,1);
Track.Slope = zeros(Track.lenght,1);

for n = 2:Track.lenght
   Track.Slope(n) = (Track.Y(n) - Track.Y(n-1))/(Track.X(n) - Track.X(n-1));
end

YawDer = gradient(Track.Slope);
Ones = sign(YawDer);

plot(Ones)

for n = 1:Track.lenght-4
   if Ones(n) == 1
       if Ones(n+1)+Ones(n+2)+Ones(n+3)+Ones(n+4) > 0
           Ones(n) = 1;
       else
           Ones(n) = -1;
       end
   elseif Ones(n) == -1
       if Ones(n+1)+Ones(n+2)+Ones(n+3)+Ones(n+4) < 0
           Ones(n) = -1;
       else
           Ones(n) = 1;
       end
   end
end

hold on
plot(Ones)

end

