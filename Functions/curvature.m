function [Track] = curvature(Track)
% *************************************************************************
% FUNCTION NAME:
%   Curvature
%
% DESCRIPTION:
%   This function takes in a Struct with X,Y coordinates for the track and generates the curvature for the track.
%
% INPUTS:
%   Track current struct for track containing X and Y locations
%
% OUTPUTS:
%   Updated Track Struct to include curvature as Track.curv
% 
% KNOW ISSUES:
%
% CHANGE LOG:
%   04/11/2019: Initial creation
% *************************************************************************
Track.lenght = length(Track.X);
Track.curv = zeros(Track.lenght,1);
Track.closed = true;
Track.dxdy = Track.curv;

if Track.closed == true
    x1 = Track.X(Track.lenght);
    x2 = Track.X(1);
    x3 = Track.X(2);
    y1 = Track.Y(Track.lenght);
    y2 = Track.Y(1);
    y3 = Track.Y(2);
    A = (x1*(y2-y3))-(y1*(x2-x3))+(x2*y3)-(x3*y2);
    B = (x1^2+y1^2)*(y3-y2)+(x2^2+y2^2)*(y1-y3)+(x3^2+y3^2)*(y2-y1);
    C = (x1^2+y1^2)*(x2-x3)+(x2^2+y2^2)*(x3-x1)+(x3^2+y3^2)*(x1-x2);
    D = (x1^2+y1^2)*((x3*y2)-(x2*y3))+(x2^2+y2^2)*((x1*y3)-(x3*y1))+(x3^2+y3^2)*((x2*y1)-(x1*y2));
    Track.curv(1) = 1/sqrt((B^2+C^2-4*A*D)/(4*(A^2)));
    
    x1 = Track.X(Track.lenght-1);
    x2 = Track.X(Track.lenght);
    x3 = Track.X(1);
    y1 = Track.Y(Track.lenght-1);
    y2 = Track.Y(Track.lenght);
    y3 = Track.Y(1);
    A = (x1*(y2-y3))-(y1*(x2-x3))+(x2*y3)-(x3*y2);
    B = (x1^2+y1^2)*(y3-y2)+(x2^2+y2^2)*(y1-y3)+(x3^2+y3^2)*(y2-y1);
    C = (x1^2+y1^2)*(x2-x3)+(x2^2+y2^2)*(x3-x1)+(x3^2+y3^2)*(x1-x2);
    D = (x1^2+y1^2)*((x3*y2)-(x2*y3))+(x2^2+y2^2)*((x1*y3)-(x3*y1))+(x3^2+y3^2)*((x2*y1)-(x1*y2));
    Track.curv(Track.lenght) = 1/sqrt((B^2+C^2-4*A*D)/(4*(A^2)));
    
else
    Track.curv(1) = 0;
    Track.curv(Track.lenght)= 0;
end
n = 2;
while n < Track.lenght
    x1 = Track.X(n-1);
    x2 = Track.X(n);
    x3 = Track.X(n+1);
    y1 = Track.Y(n-1);
    y2 = Track.Y(n);
    y3 = Track.Y(n+1);
    A = (x1*(y2-y3))-(y1*(x2-x3))+(x2*y3)-(x3*y2);
    B = (x1^2+y1^2)*(y3-y2)+(x2^2+y2^2)*(y1-y3)+(x3^2+y3^2)*(y2-y1);
    C = (x1^2+y1^2)*(x2-x3)+(x2^2+y2^2)*(x3-x1)+(x3^2+y3^2)*(x1-x2);
    D = (x1^2+y1^2)*((x3*y2)-(x2*y3))+(x2^2+y2^2)*((x1*y3)-(x3*y1))+(x3^2+y3^2)*((x2*y1)-(x1*y2));
    Track.curv(n) = 1/sqrt((B^2+C^2-4*A*D)/(4*(A^2)));
    Track.dxdy(n) = (y2-y1)/(x2-x1);
    n = n + 1;
end

Track.mYaw = gradient(Track.dxdy);
Track.curvature = sign(Track.mYaw).*Track.curv;

%Remember to move these inputs
maxCurvature = 0.25;
N=2; 
Wn=.05;

[B,A] = butter(N,Wn,'low');
Track.unfilteredCurvature = Track.curvature;
Track.curvature = filtfilt(B, A, Track.curvature);

for n = 1:Track.lenght
    if abs(Track.curvature(n)) > maxCurvature
        Track.curvature(n) = sign(Track.curvature(n))*maxCurvature;
    end
end

plot(Track.curvature)
