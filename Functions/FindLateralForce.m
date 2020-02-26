function [ FRLat, FLLat, RRLat, RLLat ] = FindLateralForce(Tyre, FRVert, FLVert, RRVert, RLVert, Car)
%FINDLATERALFORCE Summary of this function goes here
%   Detailed explanation goes here

%Determine Min and Max of the tyre lookup
minL = min(Tyre.LoadPoints);
maxL = max(Tyre.LoadPoints);

 % Front Right
if FRVert > maxL
    FRcor = 1;
elseif FRVert < minL
    FRcor = 0;
else
    FRcor = interp1(Tyre.LoadPoints,Tyre.LatValues,FRVert,'linear');
end

%Front Left 
if FLVert > maxL
    FLcor = 1;
elseif FLVert < minL
    FLcor = 0;
else
    FLcor = interp1(Tyre.LoadPoints,Tyre.LatValues,FLVert,'linear');
end

 % Rear Right
if RRVert > maxL
    RRcor = 1;
elseif RRVert < minL
    RRcor = 0;
else
    RRcor = interp1(Tyre.LoadPoints,Tyre.LatValues,RRVert,'linear');
end

%Rear Left 
if RLVert > maxL
    RLcor = 1;
elseif RLVert < minL
    RLcor = 0;
else
    RLcor = interp1(Tyre.LoadPoints,Tyre.LatValues,RLVert,'linear');
end

FRLat = FRVert*Tyre.cof*FRcor;
FLLat = FLVert*Tyre.cof*FLcor;
RRLat = RRVert*Tyre.cof*RRcor;
RLLat = RLVert*Tyre.cof*RLcor;
end

