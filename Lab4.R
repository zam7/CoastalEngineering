# Lab 4

library(zoo)

# Read in data for Wave 1
Lab4_W1 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W1.csv")
Lab4_W2 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W2.csv")
Lab4_W3 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W3.csv")
Lab4_W4 <- read.csv("~/github/Coastal_Engineering/Lab 4/Lab4_W4.csv")

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
Lab4_W1$time_s = (Lab4_W1$time_s) - (Lab4_W1$time_s[1])
Lab4_W2$time_s = (Lab4_W2$time_s) - (Lab4_W2$time_s[1])
Lab4_W3$time_s = (Lab4_W3$time_s) - (Lab4_W3$time_s[1])
Lab4_W4$time_s = (Lab4_W4$time_s) - (Lab4_W4$time_s[1])

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
h_cm = 20
W1_freq_Hz = 0.5
T12 = 2
T34 = 1

# Use root-solver function to find the k values for the different waves
W1_k = 2.3209
W2_k = 2.3209
W3_k = 5.17913
W4_k = 5.17913

# lambda = 2*pi/k
W1_lmbda = 2*pi/W1_k
W2_lmbda = 2*pi/W2_k
W3_lmbda = 2*pi/W3_k
W4_lmbda = 2*pi/W4_k

# D/lambda to check slender body assumption
D = 0.0508
W1_Dl = D/W1_lmbda
W2_Dl = D/W2_lmbda
W3_Dl = D/W3_lmbda
W4_Dl = D/W4_lmbda

### 3. Calculate the Reynolds number for each wave
W1_a = 0.013
W2_a = 0.003
W3_a = 0.012
W4_a = 0.003

# Find sigma using sigma = 2*pi/T
W1_sig = 2*pi/T12
W2_sig = 2*pi/T12
W3_sig = 2*pi/T34
W4_sig = 2*pi/T34

# Find Cp using Cp = sigma/k
W1_Cp = W1_sig/W1_k
W2_Cp = W2_sig/W2_k
W3_Cp = W3_sig/W3_k
W4_Cp = W4_sig/W4_k

# Find u using u = a*k*Cp
W1_u = W1_a * W1_k * W1_Cp
W2_u = W2_a * W2_k * W2_Cp
W3_u = W3_a * W3_k * W3_Cp
W4_u = W4_a * W4_k * W4_Cp

# Find Reynolds number using Re = u*D/v
v = 1.003*10^-6
W1_Re = W1_u * D/v
W2_Re = W2_u * D/v
W3_Re = W3_u * D/v
W4_Re = W4_u * D/v

### 4. Find Cd and Cm for each wave case
rho_g_cm3 = 1
# To find Cd, first find local maxima of Fd timeseries and take average to find Fd average
# At du/dt = 0, Ftot = Fd, which means that at the wave peak, the entire force is equal to the drag force
# The average of the maxima are around 0.2, so 
W1_Fd = 0.2
W2_Fd = 0.018
W3_Fd = 0.35
W4_Fd = 0.07

# Then, u can be solved for using u = a*k*Cp*cos(k*x-sigma*t)
# Fd = integral(-L,0)(0.5*rho*D*Cd*u*abs(u))dz
# Fd = -h/2(0.5*rho*D*Cd*u*abs(u))
# Cd = -4*Fd/(h*rho*D*Cd*u*abs(u))
W1_Cd = -4*W1_Fd/(h_cm*rho_g_cm3*D*(W1_u)^2*cos(W1_sig*0)*abs(cos(W1_sig*0)))

W1_Cd = 2*W1_Fd/(rho_g_cm3*D*(W1_u)*abs(W1_u))

W1_Cd = 3*pi*W1_a/4*rho_g_cm3*D

W2_Cd = -4*W2_Fd/(h_cm*rho_g_cm3*D*W2_u*abs(W1_u))
W3_Cd = -4*W3_Fd/(h_cm*rho_g_cm3*D*W3_u*abs(W1_u))
W4_Cd = -4*W4_Fd/(h_cm*rho_g_cm3*D*W4_u*abs(W1_u))

# At x=0, du/dt = -a*k*Cp*sin(-sigma*t)

