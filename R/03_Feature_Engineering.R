library(tidyverse)
library(lubridate)

# ------------------------------------------------------------
# 1. Load the preprocessed dataset
# ------------------------------------------------------------

accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)

# ------------------------------------------------------------
# 2. Convert required data types
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    date = as.Date(date),
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
# 3. Create time-based features
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    year = year(date),
    month = month(date),
    month_name = month(date, label = TRUE, abbr = FALSE),
    
    quarter = paste0("Q", quarter(date)),
    
    hour_group = case_when(
      hour >= 0 & hour < 6 ~ "Night",
      hour >= 6 & hour < 12 ~ "Morning",
      hour >= 12 & hour < 18 ~ "Afternoon",
      TRUE ~ "Evening"
    )
  )

# ------------------------------------------------------------
# 4. Create readable labels
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    weekend_label = if_else(
      is_weekend == 1,
      "Weekend",
      "Weekday"
    ),
    
    peak_label = if_else(
      is_peak_hour == 1,
      "Peak Hour",
      "Non-Peak Hour"
    ),
    
    signal_label = if_else(
      traffic_signal == 1,
      "Signal Present",
      "No Signal"
    )
  )

# ------------------------------------------------------------
# 5. Create risk categories
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    risk_level = case_when(
      risk_score < 0.4 ~ "Low Risk",
      risk_score < 0.7 ~ "Medium Risk",
      TRUE ~ "High Risk"
    )
  )

# ------------------------------------------------------------
# 6. Create casualty category
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    casualty_level = case_when(
      casualties == 0 ~ "No Casualties",
      casualties <= 2 ~ "Low Casualties",
      casualties <= 4 ~ "Moderate Casualties",
      TRUE ~ "High Casualties"
    )
  )

# ------------------------------------------------------------
# 7. Create accident severity order
# ------------------------------------------------------------

accidents$accident_severity <- factor(
  accidents$accident_severity,
  levels = c("minor", "major", "fatal"),
  ordered = TRUE
)

# ------------------------------------------------------------
# 8. Check newly created features
# ------------------------------------------------------------

glimpse(accidents)

# ------------------------------------------------------------
# 9. Check feature distributions
# ------------------------------------------------------------

table(accidents$year)
table(accidents$hour_group)
table(accidents$weekend_label)
table(accidents$peak_label)
table(accidents$risk_level)
table(accidents$casualty_level)

# ------------------------------------------------------------
# 10. Final dataset dimensions
# ------------------------------------------------------------

dim(accidents)