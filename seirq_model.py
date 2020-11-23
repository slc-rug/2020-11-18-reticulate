import pandas as pd
import numpy as np

from scipy.integrate import ode
from scipy.integrate import odeint
from scipy.integrate import solve_bvp



def seirq(t,y,beta,delta,gamma, mu, ep):
    S = y[0]
    E = y[1]
    I = y[2]
    Q = y[3]
  
    ds_dt = -beta*S*I
    de_dt = beta*S*I - delta*E
    di_dt = delta*E  - gamma*I - mu*I
    dq_dt = mu*I - ep*Q  
    dr_dt = gamma*I + ep*Q
    
    return [ds_dt, de_dt, di_dt, dq_dt, dr_dt]



def seirq_model(N, s0, e0, i0, r0, q0, beta, delta, gamma, mu, ep):
  
    y0 = [s0,e0,i0,q0,r0]
    t = np.linspace(0,100, 5*100)
    y = np.zeros((len(t), len(y0)))
    y[0,:] = y0
  
    sir_ode = lambda t, y:seirq(t,y,beta,delta,gamma,mu,ep)
    sir_solver = ode(sir_ode).set_integrator('dopri5')
    sir_solver.set_initial_value(y0,0)
  
    for j in range(1,len(t)):
        y[j,:] = sir_solver.integrate((t[j]))
      
      
    seirq_df = pd.DataFrame({ 't': t
                        , 'S':y[:,0]*N
                        , 'E':y[:,1]*N
                        , 'I':y[:,2]*N
                        , 'R':y[:,4]*N
                        , 'Q':y[:,3]*N
                        })
    return(seirq_df)
    
