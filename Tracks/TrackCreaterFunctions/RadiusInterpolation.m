clear
load('C:\Laptime\Tracks\MainTrack.mat')
Track.Distance = zeros(Track.lenght,1);
NewTrack.Distance = sum(Track.Dis);
trackincrements = 0.5;
newpoints = round(NewTrack.Distance/trackincrements);
NewTrack.Dis = zeros(newpoints,1);
NewTrack.Radius = zeros(newpoints,1);
NewTrack.curv = zeros(newpoints,1);

for n=2:Track.lenght
    Track.Distance(n) = Track.Distance(n-1)+Track.Dis(n);
end

for n=2:newpoints
    dist = n*trackincrements;
    NewTrack.Radius(n) = interp1(Track.Distance,Track.Radius,dist,'linear');
    NewTrack.Dis(n) = NewTrack.Dis(n-1) + trackincrements;
    NewTrack.curv(n) = 1/NewTrack.Radius(n);
end

plot(Track.Distance,Track.curv);
hold on
plot(NewTrack.Dis,NewTrack.curv);

