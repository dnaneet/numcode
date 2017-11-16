for i=0.1:-0.001:0.01
    umax = [umax funcBrktHole(i)];
end
plot(umax)