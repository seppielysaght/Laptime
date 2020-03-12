%%%Run to calc percentage difference

[diff,val] = PercentageCaluculator(Output, results);
difference = diff./val;
difference(1) = 0;
difference(2) = 0;
difference(3) = 0;
difference(4) = 0;
difference(5) = 0;
difference(6) = 0;
% meandifference = sum(difference:202)
plot(difference)
aver = mean(difference:1)*100
