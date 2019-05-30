# https://scipy-cookbook.readthedocs.io/items/LoktaVolterraTutorial.html
# This example describe how to integrate ODEs with scipy.integrate module, and how
# to use the matplotlib module to plot trajectories, direction fields and other
# useful information.
#
# == Presentation of the Lokta-Volterra Model ==
#
# We will have a look at the Lokta-Volterra model, also known as the
# predator-prey equations, which are a pair of first order, non-linear, differential
# equations frequently used to describe the dynamics of biological systems in
# which two species interact, one a predator and one its prey. They were proposed
# independently by Alfred J. Lotka in 1925 and Vito Volterra in 1926:
# du/dt =  a*u -   b*u*v
# dv/dt = -c*v + d*u*v
#
# with the following notations:
#
# *  u: number of preys (for example, rabbits)
#
# *  v: number of predators (for example, foxes)
#
# * a, b, c, d are constant parameters defining the behavior of the population:
#
#   + a is the natural growing rate of rabbits, when there's no fox
#
#   + b is the natural dying rate of rabbits, due to predation
#
#   + c is the natural dying rate of fox, when there's no rabbit
#
#   + d is the factor describing how many caught rabbits let create a new fox
#
# We will use X=[u, v] to describe the state of both populations.
#
# Definition of the equations:
#
# from numpy import *
import numpy as np
import pylab as p

# Definition of parameters
a = 1.0
b = 0.005
c = 0.6
d = 0.005

T_start, T_end = 0.0, 20.0
dt = 0.05

U_init, V_init = 50, 100 # init. rabbits, foxs


def dX_dt(X, t=0):
    """ Return the growth rate of fox and rabbit populations. """
    return np.array([ a*X[0] -   b*X[0]*X[1] ,
                  -c*X[1] + d*X[0]*X[1] ])

def getU(ut, vt):
    return ut + (a*ut - b*ut*vt)*dt

def getV(ut, vt):
    return vt + (-c*vt + d*ut*vt)*dt


X_f0 = np.array([     0. ,  0.])
X_f1 = np.array([ c/d, a/b])
print 'X_f1:', X_f1
all(dX_dt(X_f0) == np.zeros(2) ) and all(dX_dt(X_f1) == np.zeros(2)) # => True

def d2X_dt2(X, t=0):
    """ Return the Jacobian matrix evaluated in X. """
    return np.array([[a -b*X[1],   -b*X[0]     ],
                  [d*X[1] ,   -c + d*X[0]] ])

# Near X_f1, we have:
A_f1 = d2X_dt2(X_f1)                    # >>> np.array([[ 0.  , -2.  ],
                                        #            [ 0.75,  0.  ]])
print 'A_f1:', A_f1

from scipy import integrate

# params
T = np.arange(T_start, T_end+dt, dt)
X0 = np.array([U_init, V_init])                     # initials conditions: 10 rabbits and 5 foxes
print T.shape

# scipy integrate ode
X, infodict = integrate.odeint(dX_dt, X0, T, full_output=True)
print infodict['message']                     # >>> 'Integration successful.'

# Forward euler
def forwardeuler():
    Ut = []
    Vt = []
    Ut.append(U_init)
    Vt.append(V_init)
    print 'init', Ut[0], Vt[0]
    for t_sample in range(len(T)-1):
        Ut.append(getU(Ut[t_sample], Vt[t_sample]))
        Vt.append(getV(Ut[t_sample], Vt[t_sample]))

def iterate(U,V):
    cU = U
    cV = V
    while cU > 0 and cV > 0:
        pyorpd = np.random.choice([0,1],p=[(1.0 * cU)/(cU+cV),(1.0 * cV)/(cU+cV)])
        if pyorpd == 0:
            cU -= 1
            mork = np.random.choice([0,1])
            if mork == 0 or U == 0:
                U += np.random.choice([1,0],p=[dt*a,1-dt*a])
            else:
                p = min(dt*b*V, 1)
                U += np.random.choice([-1,0],p=[p,1-p])
        else:
            cV -= 1
            korm = np.random.choice([0,1])
            if korm == 0 and V > 0:
                V += np.random.choice([-1,0],p=[dt*c,1-dt*c])
            else:
                p = min(dt*d*U, 1)
                V += np.random.choice([1,0],p=[p,1-p])
    return (U,V)

def gillespie():
    Ut = []
    Vt = []
    Ut.append(U_init)
    Vt.append(V_init)
    print 'init', Ut[0], Vt[0]
    for t_sample in range(len(T)-1):
        (nU, nV) = iterate(Ut[t_sample],Vt[t_sample])
        Ut.append(nU)
        Vt.append(nV)
    return (Ut,Vt)

(Ut,Vt) = gillespie()
print 'GIL lens', len(T), len(Ut), len(Vt)

# lets plot
rabbits, foxes = X.T
print 'SCP lens', len(T), len(rabbits), len(foxes)

f1 = p.figure()
p.plot(T, rabbits, 'r-', label='scipy Integrate - Rabbits')
p.plot(T, foxes  , 'b-', label='scipy Integrate - Foxes')
p.plot(T, Ut, label='Gillespie - Rabbits')
p.plot(T, Vt, label='Gillespie - Foxes')
p.grid()
p.legend(loc='best')
p.xlabel('time')
p.ylabel('population')
p.title('Evolution of fox and rabbit populations')
f1.savefig('forward_euler_fox_rabit_evolution.png')



p.show()
