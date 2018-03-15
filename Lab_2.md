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

# Load velocity datas from ADV
readvelwave1 = pd.read_csv('')
uvelwave1 = np.array(readwave1)
print(len(velwave1))

readvelwave2 = pd.read_csv('')
velwave2 = np.array(readvelwave2)
print(len(velwave2))

readvelwave3 = pd.read_csv('')
velwave3 = np.array(readvelwave3)
print(len(velwave3))

readvelwave4 = pd.read_csv('')
velwave4 = np.array(readvelwave4)
print(len(velwave4))

```

The dispersion relationship is given as
$$ \sigma^2 = gk*tanh(kh) $$

$$ T = \frac{1}{f} $$

```python
h = .20  # m
freq = np.array([0.55, 1.00, 1.55])
period = 1/freq
sigma = 2*np.pi/period
```

#Calculation of $\frac{\sigma^2 h}{g}$
## Experimental
```python

# Experimental measurements of wavelength
#lmbda_exp = np.array([1.19, 0.62, 0.34]) # meters
lmbda_exp = np.array([2.42678, 1.22178, 0.62578])


# Find k using the experimentally measured wavelengths
k_exp = 2*np.pi/lmbda_exp
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
# make experimental points on top of theoretical
sigh_g_exp = sigma**2 * h / g
kh_exp = k_exp * h
plt.plot(kh_exp, sigh_g_exp, 'ro')

sigh_g_theor = sigma**2 * h / g
kh_theor = k_theor * h
plt.plot(kh_theor, sigh_g_theor)
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
```python

cp_gh_exp = celerity_exp / (g*h)
plt.plot(kh_exp, cp_gh_exp, "ro")
cp_gh_theor = celerity_theor / (g*h)
plt.plot(kh_theor, cp_gh_theor)
plt.show()
```

# Water Particle Velocity
All of the data was collected in the DeFrees Fluids Lab using an ADV to collect velocity data at different z-elevations from the bed. $f_s$, the sampling frequency was 200 Hz. The wave paddle was set at 1.00 Hz. The data was truncated to ensure that all the wave analysis begins at the wave crest, and to ensure that all the data lengths are the same (8,000 points was chosen to ensure long enough datasets).

$$ u = a \sigma \frac{cosh(k(h+z))}{sinh(kh)} cos( kx - \sigma t)$$

$$ w = a \sigma \frac{sinh(k(h+z))}{sinh(kh)} sin( kx - \sigma t)$$

The $u$ and $w$ equations can be simplified to

$$ u = Acos( - \sigma * t)$$
$$ w = Asin( - \sigma * t)$$

First, the velocity amplitude $A$ was found by sorting the absolute values of the data. The mean of the largest 10% of data was chosen.

To find the different $A$s for each velocity, $u$ and $w$ can be plotted against $cos( - \sigma * t)$ and $sin( - \sigma * t)$, respectively.

## $u_{max}$ and $w_{max}$
## Experimental
```python
z = np.array([-0.075, -0.1, -0.125, -0.175])
uA_amp_75 = 0.07482475
uA_amp_100 = 0.06905375
uA_amp_125 = 0.062269875
uA_amp_175 = 0.059395
u_vel_amp = np.array([uA_amp_75, uA_amp_100, uA_amp_125, uA_amp_175])

plt.plot(u_vel_amp, z, "ro")

plt.show()

z = np.array([-0.075, -0.1, -0.125, -0.175])
wA_amp_75 = 0.0380575
wA_amp_100 = 0.032196125
wA_amp_125 = 0.022905125
wA_amp_175 = 0.009311
w_vel_amp = np.array([wA_amp_75, wA_amp_100, wA_amp_125, wA_amp_175])


plt.plot(w_vel_amp, z, "ro")
plt.xlabel('w velocity', fontsize=18)
plt.ylabel('z elevations', fontsize=16)
plt.show()


```

## Theoretical
$$ A = a \sigma \frac{sinh(k(h+z))}{sinh(kh)}$$
$$ a = \frac{A}{\sigma \frac{sinh(k(h+z))}{sinh(kh)}}$$

$$ T = \frac{1}{f} $$

$$ \sigma = 2\pi f $$

```python
f_wave = 1 # Hz

waveperiod_all = 1 # 1/s

k_all = wavenumber(waveperiod_all, h)

sgma = 2 * np.pi * f_wave
print(sgma)
```

After the different A values are used to find $a$, the average of all $a$ values were chosen. 

```python

ua_75_mm = sgma * uA_amp_75 * np.cosh(k_all*(h+z[0])) / np.sinh(k_all*h)
ua_100_mm = sgma * uA_amp_100 * np.cosh(k_all*(h+z[1])) / np.sinh(k_all*h)
ua_125_mm = sgma * uA_amp_125 * np.cosh(k_all*(h+z[2])) / np.sinh(k_all*h)
ua_175_mm = sgma * uA_amp_175 * np.cosh(k_all*(h+z[3])) / np.sinh(k_all*h)
print(type(a_75_mm))

a_avg = np.mean(a_75_mm, a_100_mm, a_125_mm, a_175_mm)

```

```python


```
