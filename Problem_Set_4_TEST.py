## Problem Set 4, Problem 3

from aide_design.play import*
import pandas as pd
g = pc.gravity
import timeit

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

def h_x(x, _del, xo):
  """Return the water height from the bed to determine bathymetry."""
  h_x = slope*(x + _del * xo * np.exp((-(x-xo)**2)/lmbda))
  return h_x

del_x = 50
slope = 1/50
del_zero = 0
del_pos = 0.5
del_neg = -0.5
lmbda = 5000 #m
T = 10 #s
xo = -4000 #m

length = abs(xo/del_x)
print(length)
length_init = int(length - 1)
# Need to initalize all the values
del_y = np.ones(length_init)
del_y[0] = 0

y = np.ones(length_init)
y[0] = 0 # arbitrary coordinate assignment

alpha = np.zeros(length_init)
alpha[0] = 30 # deg

x = np.linspace(-4000, 0, num = 80)
x[0] = -4000 #m

h = np.ones(length_init)
h[0] = abs(h_x(x[0], del_zero, xo))

k = np.ones(length_init)
k[0] = wavenumber(T, abs(h_x(x[0], del_zero, xo)))

cg = np.zeros(length_init)
ho = abs(h_x(x[0], del_zero, xo))
cg[0] = np.sqrt(g.magnitude * ho)
cgo = np.sqrt(g.magnitude * ho)

b = np.zeros(length_init)
bo = np.cos(alpha[0])

a = np.zeros(length_init)
a[0] = 1 #m
ao = 1 #m

xplot = np.linspace(-4000, 1, num = 79)
plt.plot(xplot, h_x(xplot, del_zero, xo))
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('h, water depth', fontsize=14)
plt.suptitle('Bathymetry expressed as h(x), del = 0', fontsize=18)
plt.savefig('bathydelzero.png')
plt.show()

xplot = np.linspace(-4000, 1, num = 79)
plt.plot(xplot, h_x(xplot, del_pos, xo))
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('h, water depth', fontsize=14)
plt.suptitle('Bathymetry expressed as h(x), del = 0.5', fontsize=18)
plt.savefig('bathydelpos.png')
plt.show()

xplot = np.linspace(-4000, 1, num = 79)
plt.plot(xplot, h_x(xplot, del_neg, xo))
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('h, water depth', fontsize=14)
plt.suptitle('Bathymetry expressed as h(x), del = -0.5', fontsize=18)
plt.savefig('bathydelneg.png')
plt.show()

# Calculate Kappa using initial k and alpha values
kappa = k[0] * np.sin(alpha[0])
print(kappa)

print(length_init)

for i in range(0, length_init):
    #start = time.time()
    #h[i] = abs(h_x(x[i], del_zero, xo))
    k[i] = wavenumber(T, abs(h_x(x[i], del_zero, xo)))
    del_y[i] = kappa / (np.sqrt(k[i]**2 + kappa**2)) * del_x
    y[i] = y[i-1] + del_y[i]
    alpha[i] = np.arctan(del_y[i] / del_x)
    cg[i] = np.sqrt(g.magnitude * abs(h_x(x[i], del_zero, xo)))
    b[i] = np.cos(alpha[i])
    a[i] = ao * np.sqrt(cgo/cg[i]) * np.sqrt(bo/b[i])
    #stop = time.time()
    #print(stop-start)

print(abs(h_x(x[1], del_zero, xo)))
print(wavenumber(T, abs(h_x(x[1], del_zero, xo))))

xplot = np.linspace(-4000, 1, num = 79)
plt.plot(xplot, y)
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('y in alongshore direction', fontsize=14)
plt.suptitle('Waveray from deep water to shoreline, del = 0', fontsize=18)
plt.savefig('waveraydel0.png')
plt.show()

#![uvel](/Users/Zoeannem/github/Coastal_Engineering/uvel.png)

plt.plot(xplot, a)
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('wave amplitude along wave ray', fontsize=14)
plt.suptitle('Wave amplitude from deep water to shoreline, del = 0', fontsize=18)
plt.savefig('waveampdel0.png')
plt.show()




##################################
def bathymetry_wave(_del):
    for i in range(0, length_init):
        #start = time.time()
        #h[i] = abs(h_x(x[i], del_zero, xo))
        k[i] = wavenumber(T, abs(h_x(x[i], _del, xo)))
        del_y[i] = kappa / (np.sqrt(k[i]**2 + kappa**2)) * del_x
        y[i] = y[i-1] + del_y[i]
        alpha[i] = np.arctan(del_y[i] / del_x)
        cg[i] = np.sqrt(g.magnitude * abs(h_x(x[i], _del, xo)))
        b[i] = np.cos(alpha[i])
        a[i] = ao * np.sqrt(cgo/cg[i]) * np.sqrt(bo/b[i])
        #stop = time.time()
        #print(stop-start)
    return k, del_y, y, alpha, cg, b, a

print(abs(h_x(x[1], del_zero, xo)))
print(wavenumber(T, abs(h_x(x[1], del_zero, xo))))

xplot = np.linspace(-4000, 1, num = 79)
plt.plot(xplot, bathymetry_wave(del_pos)[2])
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('y in alongshore direction', fontsize=14)
plt.suptitle('Waveray from deep water to shoreline, del = 0.5', fontsize=18)
plt.savefig('waveraydelpos.png')
plt.show()

plt.plot(xplot, bathymetry_wave(del_pos)[6])
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('wave amplitude along wave ray', fontsize=14)
plt.suptitle('Wave amplitude from deep water to shoreline, del = 0.5', fontsize=18)
plt.savefig('waveampdelpos.png')
plt.show()

xplot = np.linspace(-4000, 1, num = 79)
plt.plot(xplot, bathymetry_wave(del_neg)[2])
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('y in alongshore direction', fontsize=14)
plt.suptitle('Waveray from deep water to shoreline, del = -0.5', fontsize=18)
plt.savefig('waveraydelneg.png')
plt.show()

plt.plot(xplot, bathymetry_wave(del_neg)[6])
plt.xlabel('x in shore-perpendicular direction', fontsize=14)
plt.ylabel('wave amplitude along wave ray', fontsize=14)
plt.suptitle('Wave amplitude from deep water to shoreline, del = -0.5', fontsize=18)
plt.savefig('waveampdelneg.png')
plt.show()
