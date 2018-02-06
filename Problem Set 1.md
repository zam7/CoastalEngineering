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

# make an array with all the values
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
