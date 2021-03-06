import numpy as np
np.set_printoptions(precision=4)

x_guess_0 = np.array([1, 1, 1]);
x_guess_0.astype(float)
err_tol = 0.1;
run = 1;
err_max = 1.; #Initial value
err_max_ARRAY = np.array([0]);
while (err_max >= err_tol):
    if(run == 1):
        x_guess_old = x_guess_0;
    else:
        x_guess_old = x_new
    run = run+1;    
    x_1_new = (1-3.0*x_guess_old[1] + 5.0*x_guess_old[2])/12;
    x_2_new = (28 - x_1_new - 3*x_guess_old[2])/5;
    x_3_new = (76-3*x_1_new -7*x_2_new)/13;
    #Strain gage problem
    
    x_new = np.array([x_1_new, x_2_new, x_3_new]);
    print 'New values of [x_1, x_2, x_3]:'
    print x_new
    err_1 = (x_1_new-x_guess_old[0])*100/x_1_new;
    err_2 = (x_2_new-x_guess_old[1])*100/x_2_new;
    err_3 = (x_3_new-x_guess_old[2])*100/x_3_new;
    err = np.array([err_1, err_2, err_3]);
    err_max = np.amax(err)
    print 'Max error: '
    print err_max
    print ''
    if(err_max <= err_tol):
        print ' '
        print'*******************************'
        print 'Converged solution!' 
        print x_new
        print '******************************'
