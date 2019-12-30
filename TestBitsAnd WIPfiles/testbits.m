Track.mYaw = gradient(Track.dxdy);
fmYaw = sign(Track.mYaw);

Track.curvature = fmYaw.*Track.curv;
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
Track.radius = 

plot(Track.curvature)
