clear
n = 2;
Car1.Motor.RPM(1) = 0;
Car1.Motor.Torque(1) = 21;
Car1.Motor.Power(1) = 0;

while n < 20001
    if n < 16001
        Car1.Motor.RPM(n) = n-1;
        Car1.Motor.Torque(n) = 21; 
        Car1.Motor.Power(n) = 0.00225*(n-1);
     else
         Car1.Motor.RPM(n) = n-1;
         Car1.Motor.Torque(n) = Car1.Motor.Torque(n-1)-0.00325; 
         Car1.Motor.Power(n) = Car1.Motor.Power(n-1)-0.00175;
    end
    n = n + 1;
end
Car1.Motor.RPM(20002) = 20001;
Car1.Motor.Torque(20002) = 0;
Car1.Motor.Power(20002) = 0;

plot(Car1.Motor.Power)
hold on 
plot(Car1.Motor.Torque)
