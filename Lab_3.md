# CEE 4350 Coastal Engineering
## Lab 3
## Zoe Maisel

### Introduction:

Wave amplitude can be estimated by the shoaling formula until the point of wave break for mild slope and conservation of energy flux assumptions. Four waves were generated at different strokes and frequencies, and their heights were measured at different distances along the x-axis, on-shore direction. The initial wave heights and  wave lengths were used to calculate the Iribarren number, which was then compared to observed wave breaker type. Understanding energy flux, slopes, and wave height are important in understanding coastal systems.

![](/Users/Zoeannem/github/Coastal_Engineering/Lab3SWL.png)

![](/Users/Zoeannem/github/Coastal_Engineering/Lab3wave.png)

### Governing Equations:

$$ \xi = \frac{s}{\sqrt(H_0/\lambda_0)} $$

```Python
from aide_design.play import*
g = pc.gravity

def wavenumber(T, h):
  """Return the wavenumber of wave using period and water height from bed."""
  k = 800  # this is a guess to find what k is
  diff = (((2*np.pi)/T)**2)-(g.magnitude * k * np.tanh(k*h))
  while diff<0:
      LHS = ((2*np.pi)/T)**2
      RHS = g.magnitude * k * np.tanh(k*h)
      diff = LHS - RHS
      k = k - 0.5
  return k
```

### Wave Amplitude:
The hydraulic-powered wave paddle in the DeFrees Lab was used to generate waves for the experiment. Experimental wave conditions generated for the lab are shown below.
| Case | Stroke (mm) | Frequency (Hz) |
| ---- | ----------- | -------------- |
| W1   | 35          | 1.25           |
| W2   | 40          | 0.85           |
| W3   | 40          | 0.5            |
| W4   | 30          | 0.5            |

| slope | SWL (cm) | Distance from x=0 to flat bottom (m) |
| ----- | -------- | ------------------------------------ |
| 0.1   | 19.2     | 1.92                                 |


##### Non-dimensional plot of shoaling formula with experimental data

Experimental data was compared with theoretical calculations using the shoaling formula.

$$ C_{p0} = \frac{\lambda_0}{T} $$
$$ T = \frac{1}{frequency} $$

Constant width in the flume was assumed.

In transitional water,

$$ C_{g0} = n_0C_{p0} $$
$$ C_{p0} = \frac{\lambda_0}{T} $$
$$ \frac{a(x)}{a_0} = \sqrt(\frac{C_{g0}}{2n_1\sqrt(gh(x))}) $$

$$ n = \frac{1}{2}[1 + \frac{2kh}{sinh(2kh)}] $$

# NEED TO FIGURE OUT

Experimental results for amplitude are shown below.
| Case | $H_0$ (cm) | $a$ (cm) @ $x$=-1.0 m | $a$ (cm) @ $x$=-0.6 m | $a$ (cm) @ $x$=-0.3 m | $a$ (cm) @ $x$=0 m | $a$ (cm) @ $x$=0.1 m | $a$ (cm) @ $x$=0.2 m |
| ---- | ---------- | --------------------- | --------------------- | --------------------- | ------------------ | -------------------- | -------------------- |
| W1   | 7.70       | 4.00                  | 1.63                  | 1.25                  | 0.60               | 0                    | 0                    |
| W2   | 7.10       | 4.25                  | 1.90                  | 1.55                  | 1.10               | 0.85                 | 0.3                  |
| W3   | 4.5        | 2.25                  | 2.05                  | 1.65                  | 0.9                | 0.35                 | 0.25                     |
| W4   | 2.9        | 1.5                   | 1.7                   | 1.1                   | 0.75               | 0.5                  | 0.25                 |



```python
slope = 1/10
SWL_cm = 19.2
SWL_m = SWL_cm / 100
H0_cm = np.array([7.7, 7.1, 4.5, 2.9])
a0_cm = H0_cm / 2

H0_m = H0_cm/100
a0_m = a0_cm/100

x_m_exp = np.array([-1, -0.6, -0.3, 0, 0.1, 0.2])
h_m_exp = x_m_exp / 10
h_nd_exp = h_m_exp / SWL_m

W1_amp_cm = np.array([4.00, 1.63, 1.25, 0.6, 0, 0])
W2_amp_cm = np.array([4.25, 1.90, 1.55, 1.10, 0.85, 0.3])
W3_amp_cm = np.array([2.25, 2.05, 1.65, 0.9, 0.35, 0.25])
W4_amp_cm = np.array([1.5, 1.7, 1.1, 0.75, 0.5, 0.25])

W1_amp_m = W1_amp_cm/100
W2_amp_m = W2_amp_cm/100
W3_amp_m = W3_amp_cm/100
W4_amp_m = W4_amp_cm/100

W1_amp_nd_exp = W1_amp_m / a0_m[0]
W2_amp_nd_exp = W2_amp_m / a0_m[1]
W3_amp_nd_exp = W3_amp_m / a0_m[2]
W4_amp_nd_exp = W4_amp_m / a0_m[3]

W_lambda_cm = np.array([88.8, 148.75, 270.72, 270.72])
W_lambda_m = W_lambda_cm/100

freq = np.array([1.25, 0.85, 0.5, 0.5])
T = 1/freq

#this is actually Cp and need to find out Cg
# find n by doing k = 2pi/lambda0
Cp0_ms = W_lambda_m/T
k_theor_0 = np.array([wavenumber(T[0], SWL_m),
                      wavenumber(T[1], SWL_m),
                      wavenumber(T[2], SWL_m),
                      wavenumber(T[3], SWL_m)])

n_theor_0 = np.array([1/2 * (1 + (2 * k1_theor_0 * SWL_m)/np.sinh(2 * k1_theor_0 * SWL_m)),
                      1/2 * (1 + (2 * k2_theor_0 * SWL_m)/np.sinh(2 * k2_theor_0 * SWL_m)),
                      1/2 * (1 + (2 * k3_theor_0 * SWL_m)/np.sinh(2 * k3_theor_0 * SWL_m)),
                      1/2 * (1 + (2 * k4_theor_0 * SWL_m)/np.sinh(2 * k4_theor_0 * SWL_m))])

Cg0_ms = Cp0_ms * n_theor_0

x_plot_m = np.linspace(-1, 0.001, num = 50)
h_m_theor = abs(x_plot_m) / 10
h_nd_theor = h_m_theor/SWL_m

k1_theor = np.ones(len(h_m_theor))
k2_theor = np.ones(len(h_m_theor))
k3_theor = np.ones(len(h_m_theor))
k4_theor = np.ones(len(h_m_theor))

for i in range(0, len(h_m_theor)):
  k1_theor[i] = wavenumber(T[0], h_m_theor[i])
  k2_theor[i] = wavenumber(T[1], h_m_theor[i])
  k3_theor[i] = wavenumber(T[2], h_m_theor[i])
  k4_theor[i] = wavenumber(T[3], h_m_theor[i])

n1_theor = 1/2 * (1 + (2 * k1_theor * h_m_theor)/np.sinh(2 * k1_theor * h_m_theor))
n2_theor = 1/2 * (1 + (2 * k2_theor * h_m_theor)/np.sinh(2 * k2_theor * h_m_theor))
n3_theor = 1/2 * (1 + (2 * k3_theor * h_m_theor)/np.sinh(2 * k3_theor * h_m_theor))
n4_theor = 1/2 * (1 + (2 * k4_theor * h_m_theor)/np.sinh(2 * k4_theor * h_m_theor))

```
Assume that within x = 1, we are in shallow water so Cg = 2sqrt(gh)
The nondimensional form is calculated by
```Python
W1_amp_nd_theor = np.sqrt(Cg0_ms[0])/((np.sqrt(2))*(g.magnitude * h_m_theor)**(1/4))
W2_amp_nd_theor = np.sqrt(Cg0_ms[1])/((np.sqrt(2))*(g.magnitude * h_m_theor)**(1/4))
W3_amp_nd_theor = np.sqrt(Cg0_ms[2])/((np.sqrt(2))*(g.magnitude * h_m_theor)**(1/4))
W4_amp_nd_theor = np.sqrt(Cg0_ms[3])/((np.sqrt(2))*(g.magnitude * h_m_theor)**(1/4))

plt.plot(h_nd_theor, W1_amp_nd_theor, label = "Wave 1")
plt.plot(h_nd_theor, W2_amp_nd_theor, label = "Wave 2")
plt.plot(h_nd_theor, W3_amp_nd_theor, label = "Wave 3")
plt.plot(h_nd_theor, W4_amp_nd_theor, label = "Wave 4")
plt.xlabel('Nondimensional Water Depth', fontsize=14)
plt.ylabel('Nondimensional Shoaling Formula', fontsize=14)
plt.legend(loc='upper left', borderaxespad=0.)
plt.suptitle('Theoretical', fontsize=18)
plt.savefig('W_amp_nd_theor.png')
plt.show()


```

![](/Users/Zoeannem/github/Coastal_Engineering/W_amp_nd_theor.png)


##### Experimental Data


```python
plt.plot(h_nd_exp , W1_amp_nd_exp, 'ro', label = "Wave 1")
plt.plot(h_nd_exp , W2_amp_nd_exp, 'bo', label = "Wave 2")
plt.plot(h_nd_exp , W3_amp_nd_exp, 'go', label = "Wave 3")
plt.plot(h_nd_exp , W4_amp_nd_exp, 'mo', label = "Wave 4")
plt.xlabel('Nondimensional Water Depth', fontsize=14)
plt.ylabel('Nondimensional Shoaling Formula', fontsize=14)
plt.legend(loc='upper left', borderaxespad=0.)
plt.suptitle('Experimental', fontsize=18)
plt.savefig('W_amp_nd_exp.png')
plt.show()
```
![](/Users/Zoeannem/github/Coastal_Engineering/W_amp_nd_exp.png)

### Wave Breaker Types

Theoretical demarcations of the Iribarren number, $\xi$, are:
| $\xi$             | Breaker Type |
| ----------------- | ------------ |
| $\xi$ < 0.5       | Spilling     |
| 0.5 < $\xi$ < 3.3 | Plunging     |
| $\xi$ > 3.3       | Surging      |

The Iribarren number was calculated by
$$ \xi = \frac{s}{\sqrt(H_0/\lambda_0)} $$

```Python
iribarren = slope/np.sqrt(H0_cm/W_lambda_cm)
print(iribarren)
```

Experimental results for breaker type are shown below. $\lambda$ was measured experimentally and $\xi$ was calculated using the above equation.

| Case | $\lambda_0$ (cm) | $\xi$ | Predicted Breaker Type | Observed breaker Type |
| ---- | ---------------- | ----- | ---------------------- | --------------------- |
| W1   | 88.80            | 0.339 | Spilling               | Spilling              |
| W2   | 148.75           | 0.458 | Spilling               | Plunging              |
| W3   | 270.72           | 0.776 | Plunging               | Spilling              |
| W4   | 270.72           | 0.966 | Plunging               | Surging               |

Experimental results for breaker location are shown below.
| Case | $h_b$ (cm) | $H_b$ (cm) | $\frac{H_b}{h_b}$ |
| ---- | ---------- | ---------- | ----------------- |
| W1   | 7.5        | 4.9        | 0.653             |
| W2   | 6.4        | 5.7        | 0.891             |
| W3   | 4.9        | 4          | 0.816             |
| W4   | 3.5        | 3.5        | 1                 |

### Discussion

<br>

```python
# To convert the document from markdown to pdf
pandoc Lab_3.md -o Maisel_Lab_3.pdf
```
