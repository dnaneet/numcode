model BouncingBall 
 constant Real g = 9.81 "acceleration due to gravity";
 parameter Real c = 0.9 "coefficient of restitution";
 parameter Real radius = 0.1 "Radius of the ball" ;
 Real height(start = 1);
 Real velocity(start=0);
equation
 der(height) = velocity;
 der(velocity) = -g;
 when height <= radius then
  reinit(velocity, -c*pre(velocity));
 end when;
end BouncingBall;
