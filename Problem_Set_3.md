# CEE 4350 Coastal Engineering
## Problem Set 3
## Zoe Maisel

```python
from aide_design.play import*
g = con.GRAVITY
```

### Variable definition:
$g$: gravity

$\sigma$: dispersion

$a$: amplitude

$h$: water depth

$H$: distance from wave crest to trough (2$a$)

$T$: wave period

$\lambda$: wavelength

$k$: wavenumber

$c_p$: celerity (wave phase speed)

$c_g$: group velocity

$n$: ratio of group velocity to phase velocity

$P$: pressure

$F$: force

$u$, $w$: x-velocity, z-velocity components

$E*c_g$: energy flux

$B$: width

### Governing Equations for Linear Wave Theory Analysis

$$ \lambda = \frac{2\pi}{\ k} $$

$$ c_g = n c_p $$

$$ {E_1 c_{g1}}{B_1} = {E_2 c_{g2}}{B_2} $$

$$ n = \frac{1}{2}(1+\frac{2kh}{sinh(2kh)}) $$

$$ \frac{a_2}{a_1} = \sqrt{\frac{c_{g1}}{c_{g2}}} $$

$$ \sigma = (\frac{2\pi}{T})^2 $$

$$ c_p = \frac{gT}{2 \pi}tanh(kh) $$

$$ \sigma^2 = gk*tanh(kh) $$

In deep water,
$$ c_p = \frac{gT}{2 \pi} $$

$$ n = \frac{1}{2} $$

$$ kh > \pi $$

In shallow water,
$$ c_p = \sqrt{gh} $$

$$ n = 1 $$

$$ kh < \frac{\pi}{10} $$

### Problem 1
1) Design a small pier supported by piles. Water depth at front row of piles is h(x) = 2 meters. Beach slope is 1/30. "Deep water" wave buoy measured wave amplitude $a$ = 0.5 m and wave period $T$ = 12 s.

Givens:
```python
slope = 1/30
depth = 5 * u.m
amp1 = 0.5 * u.m
period = 12 * u.s
h2 = 2 * u.m
sigma = 2 * np.pi / period
```

1a) What is the minimum clearance needed to maintain a dry deck?


The waves measured by the buoys are in deep water.
```python
c_p1 = g * period / (2*np.pi)
n1 = 0.5
c_g1 = n1 * c_p1
print(c_g1)
```
Assume that the waves at h(x) = 2m are shallow waves. This assumption will be checked in part 1b.
```python
c_p2 = np.sqrt(g*h2)
n2 = 1
c_g2 = n2 * c_p2
print(c_g2)

amp2 = amp1 * np.sqrt(c_g1/c_g2)
print(amp2)
```
The minimum clearance needed to maintain a dry deck is 0.73 meters.

1b) Are the waves at pile location "shallow water waves"?
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

k = wavenumber(period.magnitude, h2.magnitude) * 1/u.m
print(k)
shallow_limit = np.pi/10
deep_limit = np.pi
shallow_test = k * h2

if shallow_test < shallow_limit:
  print('The wave is a shallow water wave.')
elif shallow_test > deep_limit:
  print('The wave is a deep water wave.')
else:
  print('The wave is a transitional water wave.')
```

| $kh$ |  $\pi /10$   |
| ---- | --- |
|   0.238   |  0.314   |

Using the dispersion relationship and shallow water limits, $kh$ is less than $\pi /10$ and the wave at the piles is a shallow water wave. This confirms the answer found in 1a.

1c) What are the maximum onshore water particle velocity ($u$ & $w$) at the location of the pile?

The horizontal velocity can be found by
$$ u = a \sigma \frac{cosh(k(h+z))}{sinh(kh)} cos( kx - \sigma t)$$

Extreme horizontal velocity values occur at phase positions of kx - $\sigma$ t = 0, $\pi$, ... , which occur under the crest and trough positions. The cosine term of $u$ goes to 1.

$$ u = a \sigma \frac{cosh(k(h+z))}{sinh(kh)}$$

Vertical variation of velocity components should be analyzed at the bottom where

$$k(h+z)=0$$

and the cosh term of $u$ goes to 1. The next simplification is that in shallow water,

$$sinh(kh) = kh$$

Thus, the equation for maximum horizontal onshore water particle velocity can be given as

$$ u = \frac{a \sigma}{kh}$$

```python
u_max_shallow = (amp2*sigma)/(k*h2)
print(u_max_shallow)
```
The vertical velocity can be found by
$$ w = a \sigma \frac{sinh(k(h+z))}{sinh(kh)} sin( kx - \sigma t)$$

Extreme horizontal velocity values occur at phase positions of kx - $\sigma$ t = $\frac{\pi}{2}$, $\frac{3\pi}{2}$, ..., which occur at the mean water level (MWL) at $z$ = 0.

The sinh terms cancel out and the sine term goes to 1, so the equation for maximum vertical onshore water particle velocity can be given as

$$ w = a \sigma $$

```python
w_max_shallow = amp2*sigma
print(w_max_shallow)
```

| Shallow water onshore particle velocities | m/s    |
| ----------------------------------------- | ------ |
| $u_{max}$                                 | 1.597  |
| $w_{max}$                                 | 0.3807 |

### Problem 2
2) A simple harmonic small harmonic amplitude progressive wave train propagates in a rectangular channel with a constant depth, $h$, with wave frequency $\sigma$. The channel width transitions from $B_1$ with amplitude $a_1$ to $B_2$ with amplitude $a_2$. Find $a_2$.

Conservation of energy flux can be used to relate progressive energy, group velocity, and width.
$$ B_1 E_1 c_{g1} = B_2 E_2 c_{g2} $$

At constant wave depth, $c_{g1} = c_{g2}$.

$$ \frac{1}{2}\rho g a_1 ^2 B_1 c_{g1} = \frac{1}{2}\rho g a_2 ^2 B_2 c_{g2}$$
$$ \frac{a_2 ^2}{a_1 ^2} = \frac{B_1}{B_2} $$

$$ \frac{a_2}{a_1} = \sqrt\frac{B_1}{B_2} $$

$$ a_2 = a_1\sqrt\frac{B_1}{B_2} $$

```python
# To convert the document from markdown to pdf
pandoc Problem_Set_3.md -o Maisel_Problem_Set_3.pdf
```
