# Problem Set 1
```python
from aide_design.play import*
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
  wavelength = ((g * T**2)/(2 * np.pi)) * np.sqrt(np.tanh((4 * np.pi**2 * h)/(T**2 * g)))
  return wavelength.to(u.m)

def celerity(wavelength,T):
  """Return the celerity of wave using wavelength and period."""
  cp = wavelength/T
  return cp.to(u.m/u.s)

def wavenumber(wavelength):
  """Return the wavenumber of wave using wavelength."""
  k = (2*np.pi)/wavelength
  return k.to(1/u.m)

# make arrays with all the values
periods = np.array([10, 2, 1, 2, 3]) * u.s
heights = ([10.0, 10.0, 0.15, 0.15, 0.15]) * u.m
wavelengths = wavelength(periods, heights)
print(wavelengths.magnitude,wavelengths.units)
celerities = celerity(wavelengths,periods)
#print(celerities.magnitude,celerities.units)
wavenumbers = wavenumber(wavelengths)
kh = wavenumbers * heights
print(kh.magnitude,kh.units)

# Determine whether they are shallow, transitional, deep by making a for loop and if loop with conditions
# Make a table to show all my results
```

## Problem 2

aeta(t) = sum(a*cos(sigma*t))
water surface(time) = sum(amplitude*cos(dispersion*time))
```python
# create a vector for time that is arbitrary but long enough to show 5-6 wavelengths
time = np.array(np.linspace(0.1,9.99,98)) * u.s

amplitude = np.array([0.5, 1.0, 0.1]) * u.m
sigma = np.array([(2*np.pi/15),(2*np.pi/20),(2*np.pi/25)]) * 1/u.s







def test(a , sigma, t):
  eta_test = []
  for i in range (len(t)):
    eta_test[i] = (sum(a*np.cos(sigma*t[i])))
    return eta_test.to(u.m)

test1 = test(0.5 * u.m, (2*np.pi/15) * 1/u.s, time)
print()




def surface(a, sigma, t):
  """Returns a vector for the surface of the water as a function of time using wave amplitude, dispersion and time."""
  eta_vector = []
    for i in range (len(t)):
      eta_test[i] = (sum(a[0]*np.cos(sigma[0]*t[i])))

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
