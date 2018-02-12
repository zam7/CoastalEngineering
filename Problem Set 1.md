# Problem Set 1
```python
from aide_design.play import*
from sympy.solvers import solve
from sympy import Symbol
import math
from mpmath import *
```
## Problem 1
sigma^2 = g * h * tanh(k*h)

((sigma^2) * h ) / g

k * h * tanh(k*h)

cp = lambda/T = sigma/k

cp/sqrt(gh) = sqrt(tan(kh_plot)/kh_plot)

```python
g = pc.gravity
kh_plot = np.array(np.linspace(0.1,9.99,98))
y_axis1 = kh_plot * np.tanh(kh_plot)

plt.figure()
plt.plot(kh_plot,y_axis1)
plt.ylabel('sigma^2*h/g')
plt.xlabel('kh_plot')
plt.show()

y_axis2 = np.sqrt(np.tanh(kh_plot)/kh_plot)

plt.figure()
plt.plot(kh_plot,y_axis2)
plt.ylabel('cp/sqrt(gh)')
plt.xlabel('kh_plot')
plt.show()


def wavelength(T,h):
  """Return the wavelength of wave using period and water height from bed."""

  lmbda = Symbol('lmbda')
  wavelength[0] = solve((np.sqrt(2 * np.pi / T)) / ((g * 2 * np.pi/lmbda) * math.tanh(h.magnitude * 2 * np.pi / lmbda)))

  #wavelength = ((g * T**2)/(2 * np.pi)) * np.sqrt(np.tanh((4 * np.pi**2 * h)/(T**2 * g)))
  return wavelength[0].to(u.m)



### THIS WORKS
# New testing method - still just trying to find k, now trying to use a while loop
k = 10 # this is a guess to find what k is
T = 10
h = 10
diff = (((2*np.pi)/T)**2)-(pc.gravity.magnitude * k *np.tanh(k*h))
while diff<0:
    LHS = ((2*np.pi)/T)**2
    RHS = pc.gravity.magnitude * k *np.tanh(k*h)
    diff = LHS - RHS
    k = k - 0.0001

print(k)

# @u.wraps(1 / u.m, [u.s, u.m], False)
def k_value(T,h):
  """Return the wavelength of wave using period and water height from bed."""
  k = 10 # this is a guess to find what k is
  diff = (((2*np.pi)/T)**2)-(pc.gravity.magnitude * k *np.tanh(k*h))
  while diff<0:
      LHS = ((2*np.pi)/T)**2
      RHS = pc.gravity.magnitude * k *np.tanh(k*h)
      diff = LHS - RHS
      k = k - 0.0001
  return k

k_value(2,10)


def surface(a, sigma, t):
  """Returns a vector for the surface of the water as a function of time using wave amplitude, dispersion and time."""
  eta_vector = []
    for i in range (len(t)):
      eta_test[i] = ((a[0]*np.cos(sigma[0]*t[i]))+(a[1]*np.cos(sigma[1]*t[i]))+(a[2]*np.cos(sigma[2]*t[i])))

      return eta_test.to(u.m)

for k in range (len(a)):
print(surface(amplitude,sigma,time))





def surface(a, sigma, t):
  """Returns a vector for the surface of the water as a function of time using wave amplitude, dispersion and time."""
  eta_vector = []
  for i in range (len(t)):
    return eta_vector.extend(sum(a[k]*np.cos(sigma[k]*t[i])))

for k in range (len(a)):
print(surface(amplitude,sigma,time))

```
