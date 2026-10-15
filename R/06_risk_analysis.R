library(tidyverse)
library(plotly)

# Load data
accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)

# Severity analysis
severity_analysis <- accidents %>%
  count(accident_severity, name = "accident_count") %>%
  arrange(desc(accident_count))

print(severity_analysis)

# Cause analysis
cause_analysis <- accidents %>%
  group_by(cause) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    total_casualties = sum(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(cause_analysis)

# Weather risk
weather_risk <- accidents %>%
  group_by(weather) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    avg_casualties = mean(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(weather_risk)

# Traffic risk
traffic_risk <- accidents %>%
  group_by(traffic_density) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    avg_casualties = mean(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(traffic_risk)

# Road risk
road_risk <- accidents %>%
  group_by(road_type) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    avg_casualties = mean(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(road_risk)

# Create risk levels
accidents <- accidents %>%
  mutate(
    risk_level = case_when(
      risk_score >= 0.7 ~ "High Risk",
      risk_score >= 0.4 ~ "Medium Risk",
      TRUE ~ "Low Risk"
    )
  )

# Risk level analysis
risk_analysis <- accidents %>%
  count(risk_level, name = "accident_count") %>%
  arrange(desc(accident_count))

print(risk_analysis)

# Combined risk analysis
combined_risk <- accidents %>%
  group_by(weather, traffic_density, accident_severity) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    total_casualties = sum(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(combined_risk)

# Top risk conditions
top_risk_conditions <- combined_risk %>%
  slice_head(n = 15)

print(top_risk_conditions)