function [ FRLat, FLLat, RRLat, RLLat ] = FindLateralForce(Tyre, FRVert, FLVert, RRVert, RLVert, Car)
%FINDLATERALFORCE Summary of this function goes here
%   Detailed explanation goes here
FRLat = FRVert*Tyre.cof;
FLLat = FLVert*Tyre.cof;
RRLat = RRVert*Tyre.cof;
RLLat = RLVert*Tyre.cof;
end

