import numpy as np
np.set_printoptions(precision=2)

#First guess
x_guess_0 = np.array([1., 0., 1.22]);
x_guess_0.astype(float)
print x_guess_0.dtype
print x_guess_0 #printing for debugging only.

#Equations to solve using Gauss-Siedel iterative method:
# 12 x_1 + 3 x_2 - 5 x_3 = 1
# x_1 + 5 x_2 + 3 x_3 = 28
# 3 x_1 + 7 x_2 + 13 x_3 = 76
#

## One iteration
x_1 = (1-3.0*x_guess_0[1] + 5.0*x_guess_0[2])/12;
x_2 = (28-x_1 + 3*x_guess_0[2])/5;
x_3 = (76-3*x_1 -7*x_2)/13;
print "New values of x_1, x_2, x_3: "
print x_1, x_2, x_3
print "error: "
#print np.absolute((x_1-x_guess_0[0])/x_1)*100, \
#      np.absolute((x_2-x_guess_0[1])/x_2)*100, \
#      np.absolute((x_3-x_guess_0[2])/x_3)*100

err = np.array([(x_1-x_guess_0[0])/x_1*100,\
                  (x_2-x_guess_0[1])/x_2*100,\
                  (x_3-x_guess_0[2])/x_3*100]);
print err

## Testing for loop
for i in range(10):
    print i

## Using loop to perform Gauss-Siedel iteration


    
