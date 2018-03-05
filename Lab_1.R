# Zoe Maisel
# Coastal Engineering
# Lab 1

setwd("~/github/CoastalEngineering")

# Load in gdata library to allow for xls read in
library(gdata)
library(ggplot2)

# Load in calibration data, remove unnecessary columns and rename columns
calib1 <- read.xls("calib1.xlsx")
calib1 <- calib1[-c(1), (-c(3,4))]
colnames(calib1) <- c("time_s","calibration_sensor_volts")

calib2 <- read.xls("calib2.xlsx")
calib2 <- calib2[-c(1), (-c(3,4))]
colnames(calib2) <- c("time_s","calibration_sensor_volts")

calib3 <- read.xls("calib3.xlsx")
calib3 <- calib3[-c(1), (-c(3,4))]
colnames(calib3) <- c("time_s","calibration_sensor_volts")

calib4 <- read.xls("calib4.xlsx")
calib4 <- calib4[-c(1), (-c(3,4))]
colnames(calib4) <- c("time_s","calibration_sensor_volts")

# Find all the means for the calibration data and fill it in a datafram
mean_calibs = data.frame(matrix(nrow = 4, ncol = 0))
mean_calibs$distance_ft = c(0.0, 0.1, 0.2, 0.3)
mean_calibs$volts = c(mean(as.numeric(as.character(calib4$calibration_sensor_volts))),
                      mean(as.numeric(as.character(calib3$calibration_sensor_volts))),
                      mean(as.numeric(as.character(calib2$calibration_sensor_volts))),
                      mean(as.numeric(as.character(calib1$calibration_sensor_volts))))

# Plot the calibration data
qplot(mean_calibs$volts, mean_calibs$distance_ft, xlab = "Voltage (V)", ylab = "Distance (feet)", main = "Wave Gauge Calilbration Curve")
ggplot(mean_calibs, aes(x = mean_calibs$volts, y = mean_calibs$distance_ft)) + geom_smooth(method='lm',formula=y~x, se = FALSE) + geom_point() + 
  labs(title = 'Wave Gauge Calibration Curve', x = 'Voltage (V)', y = 'Distance (feet)')

calib_slope = coef(lm(mean_calibs$distance_ft ~ mean_calibs$volts,data=mean_calibs))[2]
calib_slope = -0.0859569  # feet/V
calib_slope = calib_slope*304.8 #mm/V

# Load in sensor data, delete extraneous points. Truncate data to have reasonable plots. Choose data from sensor 3 (downstream sensor)
# If all of the data is plotted, the curve is not the expected wave sine curve. The data was truncated to choose ranges that had reasonable sines
# Determine wave amplitude from voltage data
# Reset time to start at 0.0 s
# Use the given calibration of Sensor 3 which is 22.6 mm/V

calib_s3 = 22.6 # mm/V

# Keep all data rows
data1 <- read.csv("data1.csv")
data1 <- data1[-c(1), (-c(2,4))]
colnames(data1) <- c("time_s","sensor3_volts")
data1$wave_mm = data1$sensor3_volts * calib_s3
data1$time_s = data1$time_s - data1$time_s[1]
ggplot(data1, aes(x = time_s, y = wave_mm)) + geom_line() + geom_point() + 
    labs(title = 'Timeseries of 3 mm stroke wave with 2.0 Hz frequency', x = 'Time (s)', y = 'Wave Height (mm)')

# Keep all data rows
data2 <- read.csv("data2.csv")
data2 <- data2[-c(1), (-c(2,4))]
colnames(data2) <- c("time_s","sensor3_volts")
data2$wave_mm = data2$sensor3_volts * calib_s3
data2$time_s = data2$time_s - data2$time_s[1]
ggplot(data2, aes(x = time_s, y = wave_mm))+geom_line()+geom_point()+
  labs(title = 'Timeseries of 3 mm stroke wave with 2.5 Hz frequency', x = 'Time (s)', y = 'Wave Height (mm)')

# Keep data rows 181 to 547 
data3 <- read.csv("data3.csv")
data3 <- data3[-c(1), (-c(2,4))]
data3 <- data3[(181:547), ]
colnames(data3) <- c("time_s","sensor3_volts")
data3$wave_mm = data3$sensor3_volts * calib_s3
data3$time_s = data3$time_s - data3$time_s[1]
ggplot(data3, aes(x = time_s, y = wave_mm))+geom_line()+geom_point()+
  labs(title = 'Timeseries of 3 mm stroke wave with 3.0 Hz frequency', x = 'Time (s)', y = 'Wave Height (mm)')

# Keep all data rows
data4 <- read.csv("data4.csv")
data4 <- data4[-c(1), (-c(2,4))]
colnames(data4) <- c("time_s","sensor3_volts")
data4$wave_mm = data4$sensor3_volts * calib_s3
data4$time_s = data4$time_s - data4$time_s[1]
# Create a new dataframe 
datashort = data.frame(matrix(nrow = 3, ncol = 0))
datashort = data4[(1:1000),]
ggplot(datashort, aes(x = time_s, y = wave_mm))+geom_line()+geom_point()+
  labs(title = 'Timeseries of 4 mm stroke wave with 2.0 Hz frequency', x = 'Time (s)', y = 'Wave Height (mm)')

# Keep data rows 1 to 1204
data5 <- read.csv("data5.csv")
data5 <- data5[-c(1), (-c(2,4))]
data5 <- data5[(1:1204), ]
colnames(data5) <- c("time_s","sensor3_volts")
data5$wave_mm = data5$sensor3_volts * calib_s3
data5$time_s = data5$time_s - data5$time_s[1]
ggplot(data5, aes(x = time_s, y = wave_mm))+geom_line()+geom_point()+
  labs(title = 'Timeseries of 5 mm stroke wave with 2.0 Hz frequency', x = 'Time (s)', y = 'Wave Height (mm)')

# Find the amplitude of each wave
wave1_amp_mm = (max(data1$wave_mm) + abs(min(data1$wave_mm))) / 2
wave2_amp_mm = (max(data2$wave_mm) + abs(min(data2$wave_mm))) / 2
wave3_amp_mm = (max(data3$wave_mm) + abs(min(data3$wave_mm))) / 2
wave4_amp_mm = (max(data4$wave_mm) + abs(min(data4$wave_mm))) / 2
wave5_amp_mm = (max(data5$wave_mm) + abs(min(data5$wave_mm))) / 2

# Create a dataframe with stroke (mm), frequency (Hz), and amplitude (mm) for each wave
exp_conditions = data.frame(matrix(nrow = 5, ncol = 0))
exp_conditions$stroke_mm = c(3, 3, 3, 4, 5)
exp_conditions$freq_Hz = c(2.0, 2.5, 3.0, 2.0, 2.0)
exp_conditions$amp_mm = c(wave1_amp_mm, wave2_amp_mm, wave3_amp_mm, wave4_amp_mm, wave5_amp_mm)

# Create a dataframe for fixed stroke, using stroke = 3 mm
fixed_stroke = data.frame(matrix(nrow = 3, ncol = 0))
fixed_stroke$stroke_mm = c(3, 3, 3)
fixed_stroke$freq_Hz = c(2.0, 2.5, 3.0)
fixed_stroke$amp_mm = c(wave1_amp_mm, wave2_amp_mm, wave3_amp_mm)
ggplot(fixed_stroke, aes(x = freq_Hz, y = amp_mm))+geom_smooth()+geom_point()+
  labs(title = 'Wave amplitude as a function of wavemaker frequency for a fixed stroke', x = 'Frequency (Hz)', y = 'Wave Amplitude (mm)')

# Create a dataframe for fixed frequency, using frequency = 2.0 Hz
fixed_freq = data.frame(matrix(nrow = 3, ncol = 0))
fixed_freq$stroke_mm = c(3, 4, 5)
fixed_freq$freq_Hz = c(2.0, 2.0, 2.0)
fixed_freq$amp_mm = c(wave1_amp_mm, wave4_amp_mm, wave5_amp_mm)
ggplot(fixed_freq, aes(x = stroke_mm, y = amp_mm))+geom_smooth()+geom_point()+
  labs(title = 'Wave amplitude as a function of wavemaker stroke for a fixed frequency', x = 'Stroke (mm)', y = 'Wave Amplitude (mm)', color = "black")

