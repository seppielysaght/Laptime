clear
load('C:\Laptime\Tracks\OptimumLap - Matlab\FSGAutocross.mat')

Track.lenght = length(Track.Dis);
Track.ang = zeros(Track.lenght,1);
Track.curv = zeros(Track.lenght,1);
Track.closed = 1;

for n = 1:Track.lenght
    if Track.Radius(n) > 0 
        Track.ang(n) = Track.Dis(n)/Track.Radius(n);
    else
        Track.ang(n) = 0; 
    end
end

plot(Track.ang)
figure

for n = 1:Track.lenght
    if Track.Radius(n) > 0 
        Track.curv(n) = 1/Track.Radius(n);
    else 
        Track.curv(n) = 0;
    end
end

%filter track radius
[C,D] = butter(2,0.05,'low');
Track.radiusfilt = filtfilt(C, D, Track.Radius);

plot(Track.curv)
hold on

%filter track curvature
[C,D] = butter(2,0.05,'low');
Track.curvfilt = filtfilt(C, D, Track.curv);

plot(Track.curvfilt)

