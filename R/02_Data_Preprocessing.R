library(tidyverse)
library(lubridate)

# ------------------------------------------------------------
# 1. Load the dataset
# ------------------------------------------------------------

accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)

# ------------------------------------------------------------
# 2. Convert date and time to appropriate formats
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    date = as.Date(date),
    time = as.POSIXct(time, format = "%H:%M:%S")
  )

# ------------------------------------------------------------
# 3. Convert categorical variables to factors
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    city = as.factor(city),
    state = as.factor(state),
    day_of_week = as.factor(day_of_week),
    road_type = as.factor(road_type),
    weather = as.factor(weather),
    traffic_density = as.factor(traffic_density),
    cause = as.factor(cause),
    accident_severity = as.factor(accident_severity),
    festival = as.factor(festival)
  )

# ------------------------------------------------------------
# 4. Validate numerical ranges
# ------------------------------------------------------------

summary(accidents$latitude)
summary(accidents$longitude)
summary(accidents$hour)
summary(accidents$lanes)
summary(accidents$temperature)
summary(accidents$vehicles_involved)
summary(accidents$casualties)
summary(accidents$risk_score)

# ------------------------------------------------------------
# 5. Check for invalid values
# ------------------------------------------------------------

sum(accidents$hour < 0 | accidents$hour > 23)
sum(accidents$lanes < 1)
sum(accidents$vehicles_involved < 1)
sum(accidents$casualties < 0)
sum(accidents$risk_score < 0 | accidents$risk_score > 1)

# ------------------------------------------------------------
# 6. Final dataset structure
# ------------------------------------------------------------

glimpse(accidents)

# ------------------------------------------------------------
# 7. Final dimensions
# ------------------------------------------------------------

dim(accidents)