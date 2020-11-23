import pandas as pd
import numpy as np

from scipy.integrate import ode
from scipy.integrate import odeint
from scipy.integrate import solve_bvp

### set up sir model differential equations
def sir(t,y,beta,gamma):
    S = y[0]
    I = y[1]
    
    ds_dt = -beta*S*I
    di_dt = beta*S*I - gamma*I
    dr_dt = gamma*I
    return [ds_dt, di_dt, dr_dt]
    
    
def sir_model(N, s0, i0, r0, beta, gamma):
    
    ## initial conditions vector
    y0 = [s0,i0,r0]
    
    ## time grid
    t = np.linspace(0,100, 5*100)
    y = np.zeros((len(t), len(y0)))
    y[0,:] = y0
  
    ## initalize ode solver
    sir_ode = lambda t, y:sir(t,y,beta,gamma)
    sir_solver = ode(sir_ode).set_integrator('dopri5')
    sir_solver.set_initial_value(y0,0)
    
    
    ## Integrate the SIR equations over t
    for j in range(1,len(t)):
        y[j,:] = sir_solver.integrate((t[j]))
      
      
    sir_df = pd.DataFrame({ 't': t
                        , 'S':y[:,0]*N
                        , 'I':y[:,1]*N
                        , 'R':y[:,2]*N
                        })
    return(sir_df)
    
