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

length_tank = 190 * u.m
width_tank = 4.5 * u.m
depth = 5 * u.m
amp = 1 * u.m
period = 4 * u.s

wavenumber(period.magnitude, depth.magnitude)
wavelength(period.magnitude, depth.magnitude)
celerity(period.magnitude, depth.magnitude)
```
The wavenumber is

1b) Find component water parcel velocities and pressure at 2 meters below the water level.

$$ u = a \sigma \frac{cosh(k(h+z))}{sinh(kh)} cos( kx - \sigma t)$$
$$ w = a \sigma \frac{sinh(k(h+z))}{sinh(kh)} sin( kx - \sigma t)$$

$$ P = -\rho gz + \rho ga\frac{cosh(k(h+z))}{cosh(kh)} cos( kx - \sigma t) $$

```python
def u_vel(T, h, a, x, t, z):
    """Return the x-velocity of a wave."""
    sigma = (2*np.pi)/T
    k = wavenumber(T,h)
    u_vel = a * sigma * (np.cosh(k*(h+z))/np.sinh(k*h)) * np.cos(k*x - sigma*t)
    return u_vel

def w_vel(T, h, a, x, t, z):
    """Return the z-velocity of a wave."""
    sigma = (2*np.pi)/T
    k = wavenumber(T,h)
    a = amp
    w_vel = a * sigma * (np.sinh(k*(h+z))/np.sinh(k*h))* np.sin(k*x - sigma*t)
    return w_vel    

def pressure(T, h, a, x, t, z):
    """Return the hydrostatic and dynamic pressure from a wave."""
    temp = 25 * u.degC
    sigma = (2*np.pi)/T
    rho = pc.density_water(temp).magnitude
    k = wavenumber(T, h)
    pressure = (-rho * g.magnitude * z) + rho * g.magnitude * a * np.cosh(k*(h+z))/np.cosh(k*h) * np.cos(k*x - sigma*t)
    return pressure

z = -2 * u.m
x = 0 * u.m
t = 0 * u.s

u_vel(period.magnitude, depth.magnitude, amp.magnitude, x.magnitude, t.magnitude, z.magnitude)
w_vel(period.magnitude, depth.magnitude, amp.magnitude, x.magnitude, t.magnitude, z.magnitude)
pressure(period.magnitude, depth.magnitude, amp.magnitude, x.magnitude, t.magnitude, z.magnitude)
```

NEED TO WRITE SENTENCES FOR THIS

### Problem 2
Design a seawall to prevent flooding of a coastal highway. The water depth of in front of the seawall is 3 m. The design wave characteristics are period T = 10 seconds and amplitude a = 0.5 m.

2a) Design the minimum height of the seawall to prevent flooding.

The height of a seawall ($h_s$) should be determined from the amplitude of the design wave ($a$) and the water depth ($h$).   

$$ h_s = (2 * a) + h $$

```python
a_designwave = 0.5 * u.m
h_designwave = 3 * u.m
h_s = (2 * a_designwave) + h_designwave
print(h_s)
```

The seawall should be designed to be 4 meters tall.

2b) The maximum total force on the seawall.



```python
def max_force(T, h, a, x, t, z):
    """Return the maximum force that a wave will induce on a seawall."""
    temp = 25 * u.degC
    sigma = (2*np.pi)/T
    rho = pc.density_water(temp).magnitude
    H = 2 * a
    k = wavenumber(T, h)
    max_force = (rho * g.magnitude) * ((4*h**2 + H**2)/8) + (rho * g.magnitude * h * a * np.tanh(k*h)/(k*h))
    return max_force

period_designwave = 10 * u.s
print(max_force(period_designwave.magnitude, h_designwave.magnitude, a_designwave.magnitude, x, t, z))

```
