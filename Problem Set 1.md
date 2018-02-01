# Problem Set 1
```python
from aide_design.play import*
```


g = 9.81 * u.m/u.s
sigma^2 = g * h * tanh(k*h)
((sigma^2) * h ) / g
k * h * tanh(k*h)

```python
kh = np.array(np.linspace(0.1,9.99,98))
print(kh)
y_axis1 = kh * np.tanh(kh)
test = np.sin(kh)
print(test)
print(y_axis1)
plt.figure
plt.plot(kh,y_axis1)
plt.show
```
