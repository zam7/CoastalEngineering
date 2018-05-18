Zoe Maisel
CEE 4350: Coastal Engineering
Final Exam

```python
from aide_design.play import*
g = con.GRAVITY
```

1. The free surface elevation of a deep water wave system is given by
$ \eta = a_1cos(k_1x - \sigma_1t))+a_2cos(k_2x - \sigma_2t)) $

```python
a_1 = 0.5*u.m
a_2 = 1.0*u.m
lambda_1 = 30*u.m
lambda_2 = 60*u.m
```

i) Determine wave frequencies, $\sigma_1$ and $\sigma_2$, and wave celerities, $C_{p1}$ and $C_{p2}$.

The dispersion relationship is:
$$ \sigma^2 = gk_0tanh(kh_0) $$

In deep water, the dispersion relationship simplifies to:
$$ \sigma^2 = gk_0 $$

and

$$ \lambda = \frac{2\pi}{k} $$

Using the given $\lambda$ values to find $k$,

$$k = \frac{2\pi}{\lambda}$$

```python
k_1 = 2*np.pi/lambda_1
k_2 = 2*np.pi/lambda_2
```
$$ \sigma = \sqrt(gk_0) $$

```python
sigma_1 = np.sqrt(g*k_1)
sigma_2 = np.sqrt(g*k_2)
```
In deep water, wave celerity can be found by:

$$ C_p = \frac{g}{\sigma} $$
```python
C_p1 = g/sigma_1
C_p2 = g/sigma_2
```


|                 | 1     | 2     |
| --------------- | ----- | ----- |
| $a$   (m)       | 0.5   | 1.0   |
| $\lambda$ (m)   | 30    | 60    |
| $k$  (1/m)      | 0.209 | 0.105 |
| $\sigma$  (1/s) | 1.433 | 1.013 |
| $C_p$   (m/s)   | 6.843 | 9.677 |

ii) At what depth will the maximum horizontal velocity be 1\% of the free surface velocity?

For a deep water wave system, at deeper than half of the wavelength the water is unaffected by wave energy. This means that the depth at which the wave will no longer be felt is $\frac{\lambda}{2}$. Because the wave 2 is the longer wavelength, it should be considered as the dominating force, so $depth = \frac{\lambda_2}{2}$

```python
depth = lambda_2/2
```
$depth = 30 m $.

2. In a wave tank experiment, a wave gauge is used to record the oscillations of the
free surface, which can be described by

$$ \eta (t) = a cos(\sigma t) $$

where amplitude $a$ and the radian frequency $\sigma$ can be obtained from the data. The water depth and wavelength, $\lambda$, are unknown. However, you do have access to a pressure gauge so that you can measure the dynamic pressure under the wave, $P_d(t)$.

The following procedure was adapted from Dean and Dalrymple derivations provided on page 85 of Water Wave Mechanics for Engineers and Scientists.

Pressure gauges placed in water columns or channels measure hydrostatic pressure and the oscillating dynamic pressure. The wave is responsible for creating the dynamic pressure, and can be used to find the free surface displacement $\eta$. Dynamic pressure can be found by subtracting the mean hydrostatic pressure from total pressure gauge data. Equations for analysis are given as

$$ \eta(t) = \frac{P_d(t)}{\rho g \frac{1}{cosh(kh)}} $$

Pressure sensor systems must be carefully placed to ensure that they are measuring the correct wave. For example, if a pressure sensor to calculate dynamic pressure of deep water waves is placed on the bottom of a channel, it will not perform well because the energy decays by the time the deep water wave reaches the bottom of the channel. However, if pressure sensors are placed above the bed at a height certain to be less than half the wavelength, the pressure sensor can be used. To solve the above equation, information must be known about water depth, and wavenumber or wavelength. 

a) Find the water depth and wavelength for $a = 5 cm$, $\sigma = 6.1 \frac{rad}{s}$, and $P_d(t) = 165 cos(\sigma t)$ $Pa$

Information is not provided about whether the wave is deep or shallow. For analysis purposes, the wave is assumed to be deep.

First, period $T$ is calculated by $T = \frac{2\pi}{\sigma}$
```Python
sgma = 6.1
T = 2*np.pi/sgma
```
Period $T = 1.03 s$
Then, the dispersion relationship was used to solve for kh in deep water waves where
$$ \sigma^2 = gktanh(kh) $$
simplifies to
$$ \sigma^2 = gk $$
as $tanh(kh)$ approaches 1.

Because the wave is analyzed as a deep water wave, $k = \frac{\sigma^2}{g}$

```python
k = sgma**2/g.magnitude
```
$k$ is found to be 3.8 $\frac{1}{m}$.

Wavelength can be found as $ \lambda = \frac{2\pi}{k}$

```python
lmbda = 2*np.pi/k
```
$\lambda$ is found to be 1.66 meters.

Lastly, $h$ can be found by the full dispersion relationship, $\sigma^2 = gktanh(kh)$.
$h$ is found to be 0.92 meters.


3. In a wave tank experiment, a wave gauge is used to record the oscillations of the free surface, which can be described by
$$ \eta = acos(kx-\sigma t) + aRcos(kx + \sigma t + \theta) $$

where R (< 1) is the reflection coefficient, and $\theta$ is the phase shift. (Note: If R =1 1 and $\theta$ = 0, we have a standing wave). A seawall is located at x=0 and the depth of the water is $h$.

a) In terms of $\sigma$, $R$, and $\theta$, find an expression for the values of time, $t$, when the wave peaks or troughs occur at the seawall.

Analysis was done following Dean and Dalrymple derivations provided on pages 90-93 of Water Wave Mechanics for Engineers and Scientists.

In a wave tank, waves are a result of incident waves and reflected waves. The equation for free surface, $\eta$ can be rewritten as:

$$ \eta = a(cos(kx)cos(\sigma t) + sin(kx)sin(\sigma t)) + aR(cos(kx + \theta)cos(\sigma t) - sin(kx + \theta)sin(\sigma t)) $$

which simplifies to:

$$ \eta = [acos(kx)+aRcos(kx+\theta)]cos(\sigma t) + [asin(kx)-aRsin(kx+\theta)]sin(\sigma t) $$

and can be denoted using I(x) and F(x) for incident and reflection terms:
$$ \eta = I(x)cos(\sigma t) + F(x)sin(\sigma t) $$

To find the maximum and minimum wave heights in the wave envelope, the derivative of $\eta$ with respect to time and setting it equal to zero yields:

$$ \frac{\delta \eta}{\delta t} = -I(x)\sigma sin(\sigma t) + F(x) \sigma cos(\sigma t) = 0$$

Using trigonometric simplifications,

$$ cos(\sigma t) = \frac{I(x)}{\sqrt(I^2(x) + F^2(x))} $$
$$ sin(\sigma t) = \frac{F(x)}{\sqrt(I^2(x) + F^2(x))} $$

Therefore, at maxima and minima,

$$ \eta(x) = \frac{+}{-}\sqrt((a^2)+(aR)^2 + Ra^2cos(2kx+ \theta)) $$

The seawall is at $x=0$ so,

$$ \eta(0) = \frac{+}{-}\sqrt((a^2)+(aR)^2 + Ra^2cos(\theta)) $$

```python
def eta_ext(a, R, theta):
  return np.sqrt((a**2) + (a*R)**2 + R*a**2*np.cos(theta))
```

b) Find the value of the maximum positive displacement of the free surface at the seawall when
i) a = 1 m, R = 0.5, $\theta$ = 0
```python
eta_ext(1, 0.5, 0)
```
The maximum positive displacement is 1.32 meters.
ii) a = 1 m, R = 0.5, $\theta$ = $\frac{\pi}{4}$
```python
eta_ext(1, 0.5, np.pi/4)
```
The maximum positive displacement is 1.27 meters.

c) Find the value of the maximum negative displacement of the free surface at the seawall when
i) a = 1 m, R = 0.5, $\theta$ = 0
ii) a = 1 m, R = 0.5, $\theta$ = $\frac{\pi}{4}$

The maximum positive and negative displacement heights are equal because the wave is symmetric about the mean water level (MWL). Therefore,
ci) The maximum positive displacement is 1.32 meters.
c.ii) The maximum positive displacement is 1.27 meters.

d) Find the maximum force acting on the seawall when
a = 1 m, R = 0.5, $\theta$ = $\frac{\pi}{4}$, h = 10 m, $\sigma$ = $\frac{2\pi}{3}$

The maximum force on a seawall is a result of hydrostatic pressure and dynamic pressure, and can be found by
$$ F_{max} = \frac{1}{2}\rho gh^2 + \rho g h a\frac{1}{kh}\frac{sinh(kh)}{cosh(kh)+\frac{1}{2}\rho ga^2} $$

First, $\sigma$ and $h$ can be used to find k.

```python

R = 0.5
thta = np.pi/4
sgma = 2*np.pi/3
T = 2*np.pi/sgma
h = 10 #m
rho_water = 1000 #kg/m^3

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

k = wavenumber(T, h)
```
k = 0.447 $m^{-1}$

$a$ is a function of $\eta$ and maximum displacement on the seawall. For the given conditions, the maximum displacement was found to be 1.27 meters, so that will be the value used for a.
```python
a = 1.27 #m
g = g.magnitude
F = (1/2)*rho_water*g*h**2 + rho_water*g*h*a*(1/(k*h))*(np.sinh(k*h)/
        (np.cosh(k*h)+0.5*rho_water*g*a**2))

```
The maximum force on the seawall is $49.05 * 10^4 (\frac{N}{m})$.

4. An incident wave train with amplitude of 1 m and a period of 10 s propagates in a
channel in which the water depth changes gradually from 10 m to 5 m, and the channel width
diverges from 10 m to 20 m over a long transition section.

a) Assuming that the reflected wave is negligible, what is the amplitude of the transmitted wave?

The governing equation to determine wave amplitude in shoaling conditions is:
$$ a(x) = a_0 \sqrt(\frac{C_{g0}}{C_g(x)})\sqrt(\frac{b_0}{b(x)}) $$

where

$$ \frac{C_{g0}}{C_g(x)} = \frac{k(x)(1+\frac{2k_0h_0}{sinh(k_0h_0)})}{k_0(1+\frac{2k(x)h(x)}{sinh(k(x)h(x))})} $$

Analysis of the wave train will first be done using x=0 as the beginning of the channel in which the water depth is 10 m and the width is 10 m. The end of the channel, for now simply denoted as $L$, is where the water depth is 5 m and the width is 20 m.

```Python
a1 = 1 #m
T = 10 #s
h1 = 10 #m
h2 = 5 #m
b1 = 10 #m
b2 = 20 #m
g = con.GRAVITY

k1 = wavenumber(T, h1)
k2 = wavenumber(T, h2)

ratio_Cg = (k2*(1+(2*k1*h1)/(np.sinh(k1*h1)))) / (k1*(1+(2*k2*h2)/(np.sinh(k2*h2))))
print(ratio_Cg)

a2 = a1*np.sqrt(ratio_Cg)*np.sqrt(b1/b2)
print(a2)
```

The transmitted wave at the end of the channel is 0.815 meters in amplitude.

The above analysis is true for waves before they break onshore. Therefore, the transition region must be long enough such that the waves do not break before being transmitted through the end of the channel. Breaking waves are governed by

$$ H_b = \kappa h_b $$

where $\kappa = 0.78$, $h_b$ is the water depth at breaking, and $H_b$ is the wave height at breaking.

The initial and final condition are checked to ensure that a wave did not break.

```Python
kap = 0.78
H_b1 = kap*h1
H_b2 = kap*h2

print(H_b2)

```

The initial wave breaking height condition is 7.8 meters and the final wave breaking height condition is 3.9 meters. In both cases, the actual wave height is 2 meters or less, so the waves are not expected to break. The middle of the channel is checked to determine what the breaking height would be there, where water depth is 7.5 m and width is 15.
```Python
h_mid = 7.5 #m
k_mid = wavenumber(T, h_mid)
b_mid = 15 #m

ratio_Cg = (k_mid*(1+(2*k1*h1)/(np.sinh(k1*h1)))) / (k1*(1+(2*k_mid*h_mid)/(np.sinh(k_mid*h_mid))))
print(ratio_Cg)

a_mid = a1*np.sqrt(ratio_Cg)*np.sqrt(b1/b_mid)
print(a_mid)
```
In the middle of the channel, where water height is 7.5 meters, the expected amplitude is 0.86 meters, so the wave would not be expected to break.

Because the water depth is always great enough to ensure that the wave will not break at the calculated wave amplitudes and heights, the transition region is not of great concern. It is important for the region to be continuous and smooth to avoid areas of discontinuity. Slopes in flumes can be 1/10 while beach slopes may be closer to 1/50. Therefore, the transition region could range from 50 meters long to 250 meters long.
