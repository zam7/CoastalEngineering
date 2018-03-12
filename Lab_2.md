# CEE 4350 Coastal Engineering
## Problem Set 3
## Zoe Maisel

```python
from aide_design.play import*
import pandas as pd
g = pc.gravity
import os

cwd = os.getcwd()  # Get the current working directory (cwd)
files = os.listdir(cwd)  # Get all the files in that directory
print("Files in '%s': %s" % (cwd, files))
```

```python
# Import data files for wave gauges to determine dispersion relationship
# Delete the first two rows because they are headers
readwave1 = pd.read_excel('5_55.xlsx')
wave1 = np.array(readwave1)
print(len(wave1))
wave1 = np.delete(wave1, [0,1], 0)
print(len(wave1))

readwave2 = pd.read_excel('10_55.xlsx')
wave2 = np.array(readwave2)
print(len(wave2))
wave2 = np.delete(wave2, [0,1], 0)
print(len(wave2))

readwave3 = pd.read_excel('5_100.xlsx')
wave3 = np.array(readwave3)
print(len(wave3))
wave3 = np.delete(wave3, [0,1], 0)
print(len(wave3))

readwave4 = pd.read_excel('10_100.xlsx')
wave4 = np.array(readwave4)
print(len(wave4))
wave4 = np.delete(wave4, [0,1], 0)
print(len(wave4))

readwave5 = pd.read_excel('5_155.xlsx')
wave5 = np.array(readwave5)
print(len(wave5))
wave5 = np.delete(wave5, [0,1], 0)
print(len(wave5))

readwave6 = pd.read_excel('10_155.xlsx')
wave6 = np.array(readwave6)
print(len(wave6))
wave6 = np.delete(wave6, slice(0,4150), 0)  # this data has errors before 4150 so it is removed for analysis
print(len(wave6))
```

The dispersion relationship is given as
$$ \sigma^2 = gk*tanh(kh) $$

$$ T = \frac{1}{f} $$

```python
h = 20
freq = np.array([0.55, 1.00, 1.55])
period = 1/freq
sigma = 2*np.pi/period
```

#Calculation of $\frac{\sigma^2 h}{g}$
## Experimental
```python

# Experimental measurements of wavelength
lmbda_exp = np.array([1.19, 0.62, 0.34])  

# Find k using the experimentally measured wavelengths
k_exp = 2*np.pi/lmbda
print(k_exp)
```

## Theoretical
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

k_theor = np.array([wavenumber(period[0],h), wavenumber(period[1],h), wavenumber(period[2],h)])
print(k_theor)
```

## Comparison of Experimental and Theoretical Results
$\frac{\sigma^2 h}{g}$ as a function of $kh$

```python

sigh_g_exp = sigma**2 * h / g
kh_exp = k_exp * h
plt.plot(kh_exp, kh_exp)
plt.show()

sigh_g_theor = sigma**2 * h / g
kh_theor = k_theor * h
plt.plot(kh_theor, kh_theor)
plt.show()

```

# Calculation of Wave Celerity

## Experimental
```python

celerity_exp = lmbda_exp / period
print(celerity_exp)

```

## Theoretical
```python

def celerity(T,h):
    """Return the celerity of wave using period and water height from bed."""
    k = wavenumber(T,h)
    lmbda = 2 * np.pi / k
    celerity = lmbda / T
    return celerity

celerity_theor = np.array([celerity(period[0], h), celerity(period[1], h), celerity(period[2], h)])
print(celerity_theor)

```

## Comparison of Experimental and Theoretical Results
