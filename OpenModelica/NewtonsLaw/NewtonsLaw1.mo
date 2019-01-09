model NewtonsLaw1
 constant Real g = 9.81 "Acceleration due to gravity on Earth";
 Real x(start=0) "position";
 Real v(start=0.1) "velocity";
 parameter Real F = 1 "Newton";
 parameter Real m = 1 "kilogram"; 
equation
 der(x) = v ;
 der(v) = F/m ;
end NewtonsLaw1;
