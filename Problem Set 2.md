# Problem Set 2

```python
from aide_design.play import*
import wsuipa

g = pc.gravity
length_tank = 190 * u.m
width_tank = 4.5 * u.m
h_tank = 5 * u.m
amp = 1 * u.m
period = 4 * u.s

```
Dispersion Equation:
$$ \sigma^2 = gk*tanh(kh) $$

### Problem 1
1a) Find wave phase speed and wavelength

$$ \lambda = \frac{2\pi}{\ k} $$

$$ c_p = \sqrt{\frac{tanh(kh)}{kh}}\sqrt{gh} $$

$$ u = a \sigma * cos( kx - \sigma t)$$
$$ w = a \sigma * sin( kx - \sigma t)$$

$$ P = -\rho gz + \rho ga\frac{cosh(h+z)}{cosh(kh)} $$

```python
# @u.wraps(1 / u.m, [u.s, u.m], False)
def wavenumber(T,h):
  """Return the wavenumber of wave using period and water height from bed."""
  k = 10 # this is a guess to find what k is
  diff = (((2*np.pi)/T)**2)-(g.magnitude * k * np.tanh(k*h))
  while diff<0:
      LHS = ((2*np.pi)/T)**2
      RHS = g.magnitude * k * np.tanh(k*h)
      diff = LHS - RHS
      k = k - 0.0001
  return k

  def wavelength(T,h):
    """Return the wavelength of wave using period and water height from bed."""
    k = wavenumber(T,h)
    wavelength = 2 * np.pi / k
    return wavelength

def celerity(T,h):
    """Return the celerity of wave using period and water height from bed."""
    k = wavenumber(T,h)
    celerity = np.sqrt(np.tanh(k*h) / k*h) * np.sqrt(g.magnitude * h)
    return celerity

def celerity(T,h):
    """Return the celerity of wave using period and water height from bed."""
    k = wavenumber(T,h)
    celerity = np.sqrt(np.tanh(k*h) / k*h) * np.sqrt(g.magnitude * h)
    return celerity

def pressure(T,h,z):
    """Return the pressure ______________________."""
    temp = 25 * u.degC
    rho = pc.density_water(temp).magnitude
    k = wavenumber(T,h)
    pressure = (-rho * g.magnitude * z) + rho * g.magnitude * np.cosh(h+z)/np.cosh(k*z)
    return pressure

wavenumber(4,5)
wavelength(4,5)
celerity(4,5)
pressure(4,5,-2)
```
