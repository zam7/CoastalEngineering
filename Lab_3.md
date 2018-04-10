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

In shallow water,

$$ C_{g0} = C_{p0} $$
$$ C_{p0} = \frac{\lambda_0}{T} $$
$$ \frac{a(x)}{a_0} = \sqrt(\frac{C_{g0}}{\sqrt(gh(x))}) $$

In transitional water, $C_{g0}$ changes by
$$ n = \frac{1}{2}[1 + \frac{2kh}{sinh(2kh)}] $$
$$ C_{g0} = nC_{p0} $$

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
H0_cm = np.array([7.7, 7.1, 4.5, 2.9])
a0_cm = H0_cm / 2

x_amp_m = np.array([-1, -0.6, -0.3, 0, 0.1, 0.2])

W1_amp_cm = np.array([4.00, 1.63, 1.25, 0.6, 0, 0])
W2_amp_cm = np.array([4.25, 1.90, 1.55, 1.10, 0.85, 0.3])
W3_amp_cm = np.array([2.25, 2.05, 1.65, 0.9, 0.35, 0.25])
W4_amp_cm = np.array([1.5, 1.7, 1.1, 0.75, 0.5, 0.25])

W1_amp_nd = W1_amp_cm / a0_cm[0]
W2_amp_nd = W2_amp_cm / a0_cm[1]
W3_amp_nd = W3_amp_cm / a0_cm[2]
W4_amp_nd = W4_amp_cm / a0_cm[3]

W_lambda_cm = np.array([88.8, 148.75, 270.72, 270.72])
freq = np.array([1.25, 0.85, 0.5, 0.5])
T = 1/freq

Cg0 = W_lambda_cm/T
print(Cg0)

x_plot_m = np.linspace(-1, 0.001, num = 50)
h_cm = abs(x_plot_m) / 10
print(h_cm)
h_m = h_cm * 10
```

The nondimensional form is calculated by
```Python
W1_amp_nd = np.sqrt(Cg0[0])/(g.magnitude * h_m)**(1/4)
W2_amp_nd = np.sqrt(Cg0[1])/(g.magnitude * h_m)**(1/4)
W3_amp_nd = np.sqrt(Cg0[2])/(g.magnitude * h_m)**(1/4)
W4_amp_nd = np.sqrt(Cg0[3])/(g.magnitude * h_m)**(1/4)

plt.plot(x_plot_m, W1_amp_nd)
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Nondimensional Shoaling Formula', fontsize=14)
plt.suptitle('', fontsize=18)
plt.savefig('W1_amp_nd.png')
plt.show()

plt.plot(x_plot_m, W2_amp_nd)
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Nondimensional Shoaling Formula', fontsize=14)
plt.suptitle('', fontsize=18)
plt.savefig('W2_amp_nd.png')
plt.show()

plt.plot(x_plot_m, W3_amp_nd)
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Nondimensional Shoaling Formula', fontsize=14)
plt.suptitle('', fontsize=18)
plt.savefig('W3_amp_nd.png')
plt.show()

plt.plot(x_plot_m, W4_amp_nd)
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Nondimensional Shoaling Formula', fontsize=14)
plt.suptitle('', fontsize=18)
plt.savefig('W4_amp_nd.png')
plt.show()
```

![](/Users/Zoeannem/github/Coastal_Engineering/W1_amp_nd.png)
![](/Users/Zoeannem/github/Coastal_Engineering/W2_amp_nd.png)
![](/Users/Zoeannem/github/Coastal_Engineering/W3_amp_nd.png)
![](/Users/Zoeannem/github/Coastal_Engineering/W4_amp_nd.png)

##### Experimental Data


```python
plt.plot(x_amp_m, W1_amp_nd, 'ro')
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Wave Amplitude, nondimensional', fontsize=14)
plt.suptitle('Wave 1 Amplitude on Sloping Shore', fontsize=18)
plt.savefig('W1_amp.png')
plt.show()

plt.plot(x_amp_m, W2_amp_nd, 'ro')
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Wave Amplitude, nondimensional', fontsize=14)
plt.suptitle('Wave 2 Amplitude on Sloping Shore', fontsize=18)
plt.savefig('W2_amp.png')
plt.show()

plt.plot(x_amp_m, W3_amp_nd, 'ro')
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Wave Amplitude, nondimensional', fontsize=14)
plt.suptitle('Wave 3 Amplitude on Sloping Shore', fontsize=18)
plt.savefig('W3_amp.png')
plt.show()

plt.plot(x_amp_m, W4_amp_nd, 'ro')
plt.xlabel('x in on-shore direction (m)', fontsize=14)
plt.ylabel('Wave Amplitude, nondimensional', fontsize=14)
plt.suptitle('Wave 4 Amplitude on Sloping Shore', fontsize=18)
plt.savefig('W4_amp.png')
plt.show()
```
![](/Users/Zoeannem/github/Coastal_Engineering/W1_amp.png)
![](/Users/Zoeannem/github/Coastal_Engineering/W2_amp.png)
![](/Users/Zoeannem/github/Coastal_Engineering/W3_amp.png)
![](/Users/Zoeannem/github/Coastal_Engineering/W4_amp.png)

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
