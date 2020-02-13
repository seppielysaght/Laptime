function [dragF] = DragCalc(Car, Speed, roh)
%DRAGCALC Summary of this function goes here
%   Detailed explanation goes here

dragF = ((Speed^2)*0.5*Car.Cd*Car.FrontalA*roh);

end

