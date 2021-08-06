clear
close all 

load('AchnaTrack.mat')

% Calculate most of the points
for i=1:(length(Track.x)-2) %a=i, b=i+1, c=i+2
    %Find the midpoint and gradient of ab
    midABx(i) = (Track.x(i)+Track.x(i+1))/2;
    midABy(i) = (Track.y(i)+Track.y(i+1))/2; %Use this y
    
    %Find the mid point and gradient of bc
    midBCx(i) = (Track.x(i+1)+Track.x(i+2))/2;
    midBCy(i) = (Track.y(i+1)+Track.y(i+2))/2;
    gradient(i) = (Track.y(i+1)-Track.y(i+2))/(Track.x(i+1)-Track.x(i+2));
    perpgrad(i) = 1/-gradient(i);
    
    %Equation of the line for perpendicular bisector
    x(i) = (-(perpgrad(i)*midBCx(i))-midABy(i)-midBCy(i))/perpgrad(i); %Use this X
    
    %Find the radius at point b
    R(i+1) = sqrt((Track.x(i+1)-x(i))^2+(Track.y(i+1)-midABy(i))^2);

    %Calculate curvature
    curv(i+1) = 1/R(i+1);
end

%% Calculate first point using same method as above
last = length(Track.x);
midABx(last) = (Track.x(last)+Track.x(1))/2;
midABy(last) = (Track.y(last)+Track.y(1))/2;
midBCx(last) = (Track.x(1)+Track.x(2))/2;
midBCy(last) = (Track.y(1)+Track.y(2))/2;
gradient(last) = (Track.y(1)-Track.y(2))/(Track.x(1)-Track.x(2));
perpgrad(last) = 1/-gradient(last);
x(last) = (-(perpgrad(last)*midBCx(last))-midABy(last)-midBCy(last))/perpgrad(last); %Use this X
R(1) = sqrt((Track.x(1)-x(last))^2+(Track.y(1)-midABy(last))^2);
curv(1) = 1/R(1);

%% Calculate last point
last1 = length(Track.x);
last = length(Track.x)-1;
midABx(last) = (Track.x(last)+Track.x(last1))/2;
midABy(last) = (Track.y(last)+Track.y(last1))/2;
midBCx(last) = (Track.x(last1)+Track.x(1))/2;
midBCy(last) = (Track.y(last1)+Track.y(1))/2;
gradient(last) = (Track.y(last1)-Track.y(1))/(Track.x(last1)-Track.x(1));
perpgrad(last) = 1/-gradient(last);
x(last) = (-(perpgrad(last)*midBCx(last))-midABy(last)-midBCy(last))/perpgrad(last); %Use this X
R(last1) = sqrt((Track.x(last1)-x(last))^2+(Track.y(last1)-midABy(last))^2);
curv(last1) = 1/R(last1);

%% Calc distance 
for i=2:(length(Track.x))
   Track.Distance(i) = sqrt((Track.x(i-1)-Track.x(i))^2+(Track.y(i-1)-Track.y(i))^2);  
end
Track.Distance(1)=0;
    
plot(Track.x,Track.y)
hold on
plot(Track.x(1),Track.y(1),'*')
figure 
plot(R)
figure
plot(curv)