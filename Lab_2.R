# Ecohydrology 2018
# In Class Assignment 7

setwd("~/github/Coastal_Engineering")

# Load in data and sort in descending order
df_75mm <- df_75mm_1_[, (-c(1,2,3))]
df_75mm <- df_75mm[-(0:123), ]
names(df_75mm) <- c("u_ms", "w_ms")

df_100mm <- df_100mm_1_[, (-c(1,2,3))]
df_100mm <- df_100mm[-(0:161), ]
names(df_100mm) <- c("u_ms", "w_ms")

df_125mm <- df_125mm_1_[, (-c(1,2,3))]
names(df_125mm) <- c("u_ms", "w_ms")

df_175mm <- df_175mm_1_[, (-c(1,2,3))]
df_175mm <- df_175mm[-(0:165), ]
names(df_175mm) <- c("u_ms", "w_ms")

# Sort data and take highest 10% of values 
uamp_75mm = mean(tail(sort(abs(df_75mm$u_ms)), n=800))
wamp_75mm = mean(tail(sort(abs(df_75mm$w_ms)), n=800))

uamp_100mm = mean(tail(sort(abs(df_100mm$u_ms)), n=800))
wamp_100mm = mean(tail(sort(abs(df_100mm$w_ms)), n=800))

uamp_125mm = mean(tail(sort(abs(df_125mm$u_ms)), n=800))
wamp_125mm = mean(tail(sort(abs(df_125mm$w_ms)), n=800))

uamp_175mm = mean(tail(sort(abs(df_175mm$u_ms)), n=800))
wamp_175mm = mean(tail(sort(abs(df_175mm$w_ms)), n=800))

# Plot A, the velocity amplitudes 