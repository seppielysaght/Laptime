function [Output] = main(trackpath, trackfile, carpath, carfile, tyrepath, tyrefile)
%MAIN Summary of this function goes here
%   Detailed explanation goes here

track = strcat(trackpath,trackfile);
load(track)

if Track.curvdone == 0
    Track = curvature(Track);
end

Track = Apexfinder(Track);

car = strcat(carpath,carfile);
load(car)

tyre = strcat(tyrepath,tyrefile);
load(tyre)

Output = Simulation(Track, Car, Tyre);

%Time Output
Output.laptime = sum(Output.Time);


end

