model BouncingBallStable
  constant Real g = 9.81 "acceleration due to gravity";
  parameter Real c = 0.9 "coefficient of restitution";
  parameter Real radius = 0.1 "Radius of the ball";
  Real height(start = 1.0);
  Real velocity(start = 0.0);
  Boolean done;
initial equation
  done = false;
equation
  der(height) = velocity;
  der(velocity) = if done then 0 else -g;
  when {height<0, height<-0.001} then
    done = height<-0.001;
    reinit(velocity, (-c) * (if done then 0 else pre(velocity)));
  end when;
end BouncingBallStable;

