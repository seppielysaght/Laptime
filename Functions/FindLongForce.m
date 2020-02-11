function [ FRLong, FLLong, RRLong, RLLong ] = FindLongForce(Tyre, FRVert, FLVert, RRVert, RLVert, Car)
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
    FRcor = interp1(Tyre.LoadPoints,Tyre.LongValues,FRVert,'linear');
end

%Front Left 
if FLVert > maxL
    FLcor = 1;
elseif FLVert < minL
    FLcor = 0;
else
    FLcor = interp1(Tyre.LoadPoints,Tyre.LongValues,FLVert,'linear');
end

 % Rear Right
if RRVert > maxL
    RRcor = 1;
elseif RRVert < minL
    RRcor = 0;
else
    RRcor = interp1(Tyre.LoadPoints,Tyre.LongValues,RRVert,'linear');
end

%Rear Left 
if RLVert > maxL
    RLcor = 1;
elseif RLVert < minL
    RLcor = 0;
else
    RLcor = interp1(Tyre.LoadPoints,Tyre.LongValues,RLVert,'linear');
end

FRLong = FRVert*Tyre.cof*FRcor;
FLLong = FLVert*Tyre.cof*FLcor;
RRLong = RRVert*Tyre.cof*RRcor;
RLLong = RLVert*Tyre.cof*RLcor;
end

