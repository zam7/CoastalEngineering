# Lab 4

library(zoo)

# Read in data for Wave 1
Lab4_W1 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W1.csv")
Lab4_W2 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W2.csv")
Lab4_W3 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W3.csv")
Lab4_W4 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W4.csv")


# add 0.019s to force transducer time signal
# Convert everything to numeric values
Lab4_W1$time_s = as.numeric(Lab4_W1$time_s)
Lab4_W1$Force_newtons = as.numeric(Lab4_W1$Force_newtons)

Lab4_W2$time_s = as.numeric(Lab4_W2$time_s)
Lab4_W2$Force_newtons = as.numeric(Lab4_W2$Force_newtons)

Lab4_W3$time_s = as.numeric(Lab4_W3$time_s)
Lab4_W3$Force_newtons = as.numeric(Lab4_W3$Force_newtons)

Lab4_W4$time_s = as.numeric(Lab4_W4$time_s)
Lab4_W4$Force_newtons = as.numeric(Lab4_W4$Force_newtons)

# Reset the time series so it starts at 0 seconds
# correction factor
cf_per1 = 0.19 #s
cf_per05 = 0.17 #s
Lab4_W1$time_s = (Lab4_W1$time_s) - (Lab4_W1$time_s[1]) + cf_per05
Lab4_W2$time_s = (Lab4_W2$time_s) - (Lab4_W2$time_s[1]) + cf_per05
Lab4_W3$time_s = (Lab4_W3$time_s) - (Lab4_W3$time_s[1]) + cf_per1
Lab4_W4$time_s = (Lab4_W4$time_s) - (Lab4_W4$time_s[1]) + cf_per1

### 1. Plot the Wave Case 1 condition of force vs. time
plot(Lab4_W1$time_s, Lab4_W1$Force_newtons, ylab = "Force (N)", xlab = "Time (s)", main = "Wave Case 1")
plot(Lab4_W1$time_s[0:1000], Lab4_W1$Force_newtons[0:1000], ylab = "Force (N)", xlab = "Time (s)", main = "Wave Case 1")

# Plot Wave Case 2, 3, and 4 to determine the average maxima
plot(Lab4_W2$time_s, Lab4_W2$Force_newtons, ylab = "Force (N)", xlab = "Time (s)", main = "Wave Case 2")
plot(Lab4_W3$time_s, Lab4_W3$Force_newtons, ylab = "Force (N)", xlab = "Time (s)", main = "Wave Case 3")
plot(Lab4_W4$time_s, Lab4_W4$Force_newtons, ylab = "Force (N)", xlab = "Time (s)", main = "Wave Case 4")

### 2. Calculate D/lambda for each wave case and compare with slender body assumption
# Calculate lambda using the dispersion relationship
# sigma^2 = gktanh(kh)
# T = 1/freq
h_m = 0.2
W1_freq_Hz = 0.5
T12 = 2
T34 = 1
g_m = 9.81 # m/s^2

# Use root-solver function to find the k values for the different waves
W1_k = 2.3209 # 1/m
W2_k = 2.3209
W3_k = 5.17913
W4_k = 5.17913

# lambda = 2*pi/k #m
W1_lmbda = 2*pi/W1_k 
W2_lmbda = 2*pi/W2_k
W3_lmbda = 2*pi/W3_k
W4_lmbda = 2*pi/W4_k

# D/lambda to check slender body assumption
D = 0.0508 #m
W1_Dl = D/W1_lmbda
W2_Dl = D/W2_lmbda
W3_Dl = D/W3_lmbda
W4_Dl = D/W4_lmbda

W1_Dl = 0.0188
W2_Dl = 0.0188
W3_Dl = 0.0142
W4_Dl = 0.0142

# The slender body assumption may hold because wavelength is greater than D. However, it is unclear whether the
# difference is large enough for the slender body assumption to hold. 

### 3. Calculate the Reynolds number for each wave
W1_a = 0.013 #m
W2_a = 0.003
W3_a = 0.012
W4_a = 0.003

# Find sigma using sigma = 2*pi/T
W1_sig = 2*pi/T12 # 1/s
W2_sig = 2*pi/T12
W3_sig = 2*pi/T34
W4_sig = 2*pi/T34

# Find u using u = g*a*k/sigma
# or use sigma k
#shallow water wave assume velocity constant with depth
W1_u = g_m * W1_a * W1_k / W1_sig
W2_u = g_m * W2_a * W2_k / W2_sig
W3_u = g_m * W3_a * W3_k / W3_sig
W4_u = g_m * W4_a * W4_k / W4_sig

# Find Reynolds number using Re = u*D/v
v = 1*10^-6 #m^2/s
W1_Re = W1_u * D/v
W2_Re = W2_u * D/v
W3_Re = W3_u * D/v
W4_Re = W4_u * D/v

W1_Re = 4786
W2_Re = 1104
W3_Re = 4929
W4_Re = 1232

# We expect very large Reynolds number for the waves.

### 4. Find Cd and Cm for each wave case
rho_kg_m3 = 1000
# To find Cd, first find local maxima of Fd timeseries and take average to find Fd average
# At du/dt = 0, Ftot = Fd, which means that at the wave peak, the entire force is equal to the drag force
# There is an offset between the force gauge data and the wave amplitude data, as given above in the correction factor, cf
# The following Fd values were determined by taking the maximum force data, offset by the correction factor, to find the wave peak
# These values were then averaged to find estimates for the force values. It would be more precise if wave amplitude
# data was obtained to avoid these estimates. This simplification in analysis is imprecise but should suffice as a first attempt at analysis. 
W1_Fd = 0.2
W2_Fd = 0.018
W3_Fd = 0.35
W4_Fd = 0.07

# Cd = 2*Fd/(rho*A*u^2), from Dean and Dalrymple page 224
L = 0.2 #m
W1_Cd = 2* W1_Fd/(rho_kg_m3*(D*L)*(W1_u)^2)
W2_Cd = 2* W2_Fd/(rho_kg_m3*(D*L)*(W2_u)^2)
W3_Cd = 2* W3_Fd/(rho_kg_m3*(D*L)*(W3_u)^2)
W4_Cd = 2* W4_Fd/(rho_kg_m3*(D*L)*(W4_u)^2)

W1_Cd = 4.44
W2_Cd = 7.5
W3_Cd = 7.32
W4_Cd = 23.4

Cd = c(W1_Cd, W2_Cd, W3_Cd, W4_Cd)

# still use shallow water form of u and take temporal derivative of that
# u = a*sigma*cos(kx-sigmat)
# du/dt = a*sigma*(sigma*sin(sigma*t))
# use t at t = (1/4)T, because that is the time that the wave passes through the zero point and u = 0, assuming that the wave starts at a crest. 
t_12 = (1/4)*T12
t_34 = (1/4)*T34

der_u1 = W1_a * W1_sig^2 * sin(W1_sig*t_12)
der_u2 = W2_a * W2_sig^2 * sin(W2_sig*t_12)
der_u3 = W3_a * W3_sig^2 * sin(W3_sig*t_12)
der_u4 = W4_a * W4_sig^2 * sin(W4_sig*t_12)

# Fi values will be found in a similar manner to how Fd values were found. The force gauge data is offset from the 
# wave amplitude data. Accounting for the offset, all force should be inertial when the wave passes through the zero point
# The force data can be used find the point where the wave is at the node. 
W1_Fi = 0.02
W2_Fi = 0.005
W3_Fi = 0.03
W4_Fi = 0.003

# Cm = (Fi*2*4)/(L*rho*pi()*D^2*(du/dt))
W1_Cm = (W1_Fi*2*4)/(L*rho_kg_m3*pi*(D^2)*der_u1)
W2_Cm = (W2_Fi*2*4)/(L*rho_kg_m3*pi*(D^2)*der_u2)
W3_Cm = (W3_Fi*2*4)/(L*rho_kg_m3*pi*(D^2)*der_u3)
W4_Cm = (W4_Fi*2*4)/(L*rho_kg_m3*pi*(D^2)*der_u4)

W1_Cm = 0.79
W2_Cm = 0.86
W3_Cm = 0.323
W4_Cm = 0.129

Cm = c(W1_Cm, W2_Cm, W3_Cm, W4_Cm)

# Calculate KC values 
# KC = UT/D
W1_KC = (W1_u * T12) / D
W2_KC = (W2_u * T12) / D
W3_KC = (W3_u * T34) / D
W4_KC = (W4_u * T34) / D

KC = c(W1_KC, W2_KC, W3_KC, W4_KC)

plot(KC, Cd)
plot(KC, Cm)

# The values for Cd are at least an order of magnitude larger than they should be. Cm values are smaller than they should be.
# In general, the lab analysis is very different from the expected values as dictated in the lab. 
