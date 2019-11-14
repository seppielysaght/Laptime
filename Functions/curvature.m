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
%   14/11/2019: filter added to radius
% *************************************************************************
Track.lenght = length(Track.X);
Track.radius = zeros(Track.lenght,1);
Track.closed = true;
Track.dxdy = Track.radius;
Track.curv = Track.radius;
curvStraight = 0.0025;

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
    Track.radius(1) = sqrt((B^2+C^2-4*A*D)/(4*(A^2)));
    
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
    Track.radius(Track.lenght) = sqrt((B^2+C^2-4*A*D)/(4*(A^2)));
    
else
    Track.radius(1) = 0.00001;
    Track.radius(Track.lenght)= 0.00001;
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
    Track.radius(n) = sqrt((B^2+C^2-4*A*D)/(4*(A^2)));
    Track.curv(n) = 1/Track.radius(n);
    if Track.curv(n) <= curvStraight
        Track.radius(n) = 0;
    end
    n = n + 1;
end

if Track.closed == true
    if Track.curv(Track.lenght) <= curvStraight
        Track.radius(Track.lenght) = 0.00001;
    end
    if Track.curv(1) <= curvStraight
        Track.radius(1) = 0.00001;
    end
end

%filter track radius
[B,A] = butter(2,0.5,'low');
Track.radiusfilt = filtfilt(B, A, Track.radius);
for n = 1:Track.lenght
    if Track.radiusfilt(n) < 0
        Track.radiusfilt(n) = 0;
    end
end

%filter track curvature
[C,D] = butter(2,0.05,'low');
Track.curvfilt = filtfilt(C, D, Track.curv);

%plotting outputs (Used for design phaze will be removed
figure('Name','Curvature');
plot(Track.curv)
hold on
plot(Track.curvfilt)
figure('Name','Radius');
plot(Track.radius)
hold on 
plot(Track.radiusfilt)
figure('Name','Track');
plot(Track.X,Track.Y)

