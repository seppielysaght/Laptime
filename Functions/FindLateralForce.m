function [ FRLat, FLLat, RRLat, RLLat ] = FindLateralForce(Tyre, FRVert, FLVert, RRVert, RLVert, Car)
%FINDLATERALFORCE Summary of this function goes here
%   Detailed explanation goes here
FRcor = interp1(Tyre.LoadPoints,Tyre.LatValues,FRVert,'spline');
FLcor = interp1(Tyre.LoadPoints,Tyre.LatValues,FLVert,'spline');
RRcor = interp1(Tyre.LoadPoints,Tyre.LatValues,RRVert,'spline');
RLcor = interp1(Tyre.LoadPoints,Tyre.LatValues,RLVert,'spline');

FRLat = FRVert*Tyre.cof*FRcor;
FLLat = FLVert*Tyre.cof*FLcor;
RRLat = RRVert*Tyre.cof*RRcor;
RLLat = RLVert*Tyre.cof*RLcor;
end

