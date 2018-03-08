"""Includes all of the relevant functions for coastal engineering calculations.

Based on information from Dean and Dalrymple, Coastal Engineering Manual, and
CEE 4350 class notes.

This code needs to be modified to include unit wrappers.
"""

# Import relevant packages for unit wrappers and physical constants
from aide_design.play import*
g = pc.gravity

# Variable definition
#g: gravity

#sigma: dispersion

#a: amplitude

#h: water depth

#H: distance from wave crest to trough (2$a$)

#T: wave period

#lambda: wavelength

#k: wavenumber

#c_p: celerity (wave phase speed)

#P: pressure

#F: force

#u, w: x-velocity, z-velocity components



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

def wavelength(T, h):
    """Return the wavelength of wave using period and water height from bed."""
    k = wavenumber(T, h)
    wavelength = 2 * np.pi / k
    return wavelength

def celerity(T,h):
    """Return the celerity of wave using period and water height from bed."""
    k = wavenumber(T,h)
    lmbda = 2 * np.pi / k
    celerity = lmbda / T
    return celerity

def u_vel(T, h, a, x, t, z):
    """Return the x-velocity of a wave."""
    sigma = (2*np.pi)/T
    k = wavenumber(T,h)
    u_vel = a * sigma * (np.cosh(k*(h+z))/np.sinh(k*h)) * np.cos(k*x - sigma*t)
    return u_vel

def w_vel(T, h, a, x, t, z):
    """Return the z-velocity of a wave."""
    sigma = (2*np.pi)/T
    k = wavenumber(T,h)
    a = amp
    w_vel = a * sigma * (np.sinh(k*(h+z))/np.sinh(k*h))* np.sin(k*x - sigma*t)
    return w_vel

def pressure(T, h, a, x, t, z):
    """Return the hydrostatic and dynamic pressure from a wave."""
    temp = 25 * u.degC
    sigma = (2*np.pi)/T
    rho = pc.density_water(temp).magnitude
    k = wavenumber(T, h)
    pressure = (-rho * g.magnitude * z) + rho * g.magnitude * a*
    np.cosh(k*(h+z))/np.cosh(k*h) * np.cos(k*x - sigma*t)
    return pressure

def prog_wave_energy(a, temp):
    """Return the average energy for a progressive wave."""
    rho = pc.density_water(temp).magnitude
    energy = (rho * g * a**2)/2
    return energy
