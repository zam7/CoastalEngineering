# Problem Set 2

```python
from aide_design.play import*
g = pc.gravity
```
Dispersion Equation:
$$ \sigma^2 = gk*tanh(kh) $$

### Problem 1
1a) Find wave phase speed and wavelength

$$ \lambda = \frac{2\pi}{\ k} $$

$$ c_p = \frac{\lambda}{T} $$

$$ u = a \sigma * cos( kx - \sigma t)$$
$$ w = a \sigma * sin( kx - \sigma t)$$

$$ P = -\rho gz + \rho ga\frac{cosh(k(h+z))}{cosh(kh)} $$

```python

def wavenumber(T, h):
  """Return the wavenumber of wave using period and water height from bed."""
  k = 10  # this is a guess to find what k is
  diff = (((2*np.pi)/T)**2)-(g.magnitude * k * np.tanh(k*h))
  while diff<0:
      LHS = ((2*np.pi)/T)**2
      RHS = g.magnitude * k * np.tanh(k*h)
      diff = LHS - RHS
      k = k - 0.0001
  return k

def wavelength(T, h):
    """Return the wavelength of wave using period and water height from bed."""
    k = wavenumber(T, h)
    wavelength = 2 * np.pi / k
    return wavelength

def celerity(T,h):
    """Return the celerity of wave using period and water height from bed."""
    k = wavenumber(T,h)
    lmbda = 2 * np.pi / k
    celerity = lmbda / T
    return celerity

def u_vel(T,h,x,t):
    """Return the x-velocity of a wave."""
    sigma = (2*np.pi)/T
    k = wavenumber(T,h)
    a = h/2
    u_vel = a * sigma * np.cos(k*x - sigma*t)
    return u_vel

def w_vel(T,h,x,t):
    """Return the z-velocity of a wave."""
    sigma = (2*np.pi)/T
    k = wavenumber(T,h)
    a = h/2
    w_vel = a * sigma * np.sin(k*x - sigma*t)
    return w_vel    

def pressure(T,h,z):
    """Return the hydrostatic and dynamic pressure from a wave."""
    temp = 25 * u.degC
    rho = pc.density_water(temp).magnitude
    k = wavenumber(T,h)
    pressure = (-rho * g.magnitude * z) + rho * g.magnitude * np.cosh(k*(h+z))/np.cosh(k*z)
    return pressure

length_tank = 190 * u.m
width_tank = 4.5 * u.m
depth = 5 * u.m
amp = 1 * u.m
period = 4 * u.s

wavenumber(period.magnitude, depth.magnitude)
wavelength(period.magnitude, depth.magnitude)
celerity(period.magnitude, depth.magnitude)
```
1b) Find component water parcel velocities and pressure at 2 meters below the water level.
```python
z = -2 * u.m
x = 0 * u.m
t = 0 * u.s

u_vel(period.magnitude, depth.magnitude, x.magnitude, t.magnitude)
w_vel(period.magnitude, depth.magnitude, x.magnitude, t.magnitude)
pressure(period.magnitude, depth.magnitude, z.magnitude)
```

water depth + 2a
