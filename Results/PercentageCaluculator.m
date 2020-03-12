function [ difference, mn ] = PercentageCaluculator(comp1, comp2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

lenght1 = length(comp1.Speed);
lenght2 = length(comp2.Speed);

if lenght1 < lenght2
    points = lenght2;
    for n=1:points
        dist = comp2.Distance(n);
        val1(n) = interp1(comp1.Distance,comp1.Speed,dist,'linear');
        val2(n) = interp1(comp2.Distance,comp2.Speed,dist,'linear');
        diffe(n) = val1(n)-val2(n);
        if val1(n) == 0 
            val1(n) = 0.00000001;
        end
    end
else
    points = lenght1;
    for n=1:points
        dist = comp2.Distance(n);
        val1(n) = interp1(comp1.Distance,comp1.Speed,dist,'linear');
        val2(n) = interp1(comp2.Distance,comp2.Speed,dist,'linear');
        diffe(n) = val1(n)-val2(n);
        if val1(n) == 0 
            val1(n) = 0.00000001;
        end
    end
end
plot(val1)
hold on
plot(val2)
hold off
difference = abs(diffe)./val1;
plot(difference)
difference(find(isnan(difference)))=[]
mn = mean(difference)
end

