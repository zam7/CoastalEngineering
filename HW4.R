# Ecohydrology 2018
# In Class Assignment 7

setwd("~/github/Coastal_Engineering")
library(zoo)

##### Problem 1
# Load in data from csv file
# Time (s) eta (cm?)
wavedata = read.csv("waverecord_HW4.csv")
wavedata$time_s = wavedata[,1]
wavedata$eta_cm = wavedata[,2]

Nz = 139
N = Nz - 1
N3 = N/3

zero_cross = data.frame(matrix(nrow = Nz, ncol = 0))
num_samples = 1000

# Find the time of zero crossings
# Find the max and min wave height between zero crossings
j = 0
m = 0
for (i in 1:num_samples)
{
  if ((wavedata$eta_cm[i] < 0) & (wavedata$eta_cm[i+1] > 0))
  {
    j = j+1
    zero_cross$time_s[j] = (wavedata$time_s[i] + wavedata$time_s[i+1])/2
    zero_cross$H_i[j] = max(wavedata$eta_cm[(m:i)]) - min(wavedata$eta_cm[(m:i)])
    zero_cross$T_i[j] = max(wavedata$time_s[(m:i)]) - min(wavedata$time_s[(m:i)]) # wave periods,
    m = i
  }
}

# Sort the zero-crossings
zero_cross_sort_H_i = sort(zero_cross$H_i, decreasing = TRUE)
zero_cross_sort_T_i = sort(zero_cross$T_i, decreasing = TRUE)

# Calculate H_1/3
H_onethird = 3/N*sum(zero_cross_sort_H_i[1:N3])
# Calculate H_rms
H_rms = 1/N*sqrt(sum((zero_cross_sort_H_i[1:N3])^2))

# Calculate T_1/3 using zero crossings
T_onethird = 3/N*sum(zero_cross_sort_T_i[1:N3])

# Calculate T_c
# Assume that there are the same number maximum peaks as there are zero crossings
# On average, the period between the peaks will be the same,
# so they can be found by dividing the total time series by the number of zero crossings
T_c = max(wavedata$time_s)/Nz

# Make a histogram of wave heights
hist(zero_cross_sort_H_i, breaks = 20, main = "Histogram of Wave Heights")

#####

##### Problem 2
# Pierson Moskowitz frequency spectrum
f = seq(0.01, 5, by = 0.01)
Snn = 0.205 * H_onethird^2 * T_onethird^(-4) * f^(-5) * exp(-0.75 * (T_onethird * f)^(-4))
plot(f, Snn, main = "Pierson Moskowitz frequency spectrum")

# Calculate the area under the curve
id = order(f)
AUC = sum(diff(f[id])*rollmean(Snn[id],2))

# Calculate the variance to check that AUC is reasonable (it is)
# var = var(wavedata$eta_cm)

a_rms = sqrt(2*AUC)
H_rms2 = 2 * a_rms
H_max2 = sqrt(2)*H_rms2
H_onetenth2 = 20*sqrt(2)*H_rms2*sin(pi/20)/pi
H_onethird2 = 6*sqrt(2)*H_rms2*sin(pi/6)/pi

# Find maximum Snn to find the most energetic component of the total energy spectrum
Snn_max = max(Snn)

# Need to find the index of the max to find the wave frequency that it occurs at
i=0
for (i in 1:length(Snn))
{
  if (Snn[i] == Snn_max)
  {
    f_max = f[i]
  }
}

# Find dynamic pressure on seafloor
g = 9.81 # m/s
rho = 1000 # kg/m^3
h = 10 # m
k = 3.4 # calculated from T_onethird and h using a while loop and function in Python
Spp = sqrt(Snn)*g*rho/cosh(k*h)

plot(f, Spp, main = "Dynamic Pressure on the Seafloor")
#####

##### Problem 3
x_del = 0.1
x = seq((-4000-x_del), 0, by = x_del)
slope = 1/50
del_zero = 0
del_pos = 0.5
del_neg = -0.5

xo = -4000 #m
lambda = 5000 #m


h_x_1 = slope*(x + del_zero*xo*exp((-(x-xo)^2)/lambda))
h_x_2 = slope*(x + del_pos*xo*exp((-(x-xo)^2)/lambda))
h_x_3 = slope*(x + del_neg*xo*exp((-(x-xo)^2)/lambda))

print(h_x_1[2])

par(mfrow=c(3,1))
par(mar=c(4,4,4,4))
plot(x,h_x_1, ylab = "h(x)", xlab = "x", main = "Bathymetry Variation in the On-Offshore Direction")
plot(x,h_x_2, ylab = "h(x)", xlab = "x")
plot(x,h_x_3, ylab = "h(x)", xlab = "x")

# Calculate initial Kappa value using alpha_o and k_o
k = 10  # this is a guess to find what k is
g = 9.81 # m/s
T = 10 # s
diff = (((2*pi)/T)**2)-(g * k * tanh(k*h))
while (diff < 0)
  {
  x = xo
  h = slope*(x + del_zero*xo*exp((-(x-xo)^2)/lambda))
  LHS = ((2*pi)/T)**2
  RHS = g * k * tanh(k*h)
  diff = LHS - RHS
  k = k - 0.0001
  }

Kappa =

# Make a for loop to evaluate the wave ray and amplitude height as a function of x
for (i in 1:(length(x)-1))
{
  h = slope*(x + del_zero*xo*exp((-(x-xo)^2)/lambda))
  k = 10  # this is a guess to find what k is
  diff = (((2*np.pi)/T)**2)-(g.magnitude * k * np.tanh(k*h))
  while (diff<0)
    {LHS = ((2*np.pi)/T)**2
    RHS = g.magnitude * k * np.tanh(k*h)
    diff = LHS - RHS
    k = k - 0.0001
    }
  y_del = Kappa
}
#####
