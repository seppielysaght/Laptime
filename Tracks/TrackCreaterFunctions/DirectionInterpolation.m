clear
load('C:\Laptime\Tracks\MainTrack.mat')
Track.Distance = zeros(Track.lenght,1);
NewTrack.Distance = sum(Track.Dis);
trackincrements = 0.5;
newpoints = round(NewTrack.Distance/trackincrements);
NewTrack.Dis = zeros(newpoints,1);
NewTrack.Dir = zeros(newpoints,1);

for n=2:Track.lenght
    Track.Distance(n) = Track.Distance(n-1)+Track.Dis(n);
end

for n=2:newpoints
    dist = n*trackincrements;
    NewTrack.Dir(n) = round(interp1(Track.Distance,Track.Dir,dist,'linear'));
    NewTrack.Dis(n) = NewTrack.Dis(n-1) + trackincrements;
end

plot(Track.Distance,Track.Dir);
hold on
plot(NewTrack.Dis,NewTrack.Dir);

