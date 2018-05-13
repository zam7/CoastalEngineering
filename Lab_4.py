from aide_design.play import*
g = con.GRAVITY

def wavenumber(T, h):
    """Return the wavenumber of wave using period and water height from bed."""
    k = 20  # this is a guess to find what k is
    diff = (((2*np.pi)/T)**2)-(g.magnitude * k * np.tanh(k*h))
    while diff < 0:
        LHS = ((2*np.pi)/T)**2
        RHS = g.magnitude * k * np.tanh(k*h)
        diff = LHS - RHS
        k = k - 0.0001
        return k


freq_W1 = 1
h = (20*u.cm).to(u.m).magnitude
T_W1 = 2*np.pi/freq_W1

lmbda_W1 = wavenumber(T_W1, h)
lmbda_W1
print(lmbda_W1)
