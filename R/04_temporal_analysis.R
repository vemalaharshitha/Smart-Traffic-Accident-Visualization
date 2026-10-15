# ============================================================
# SMART TRAFFIC ACCIDENT VISUALIZATION SYSTEM
# File: 04_temporal_analysis.R
# Purpose: Analyze temporal patterns in traffic accidents
# ============================================================

library(tidyverse)
library(lubridate)

# ------------------------------------------------------------
# 1. Load dataset
# ------------------------------------------------------------

accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)

# ------------------------------------------------------------
# 2. Prepare date variables
# ------------------------------------------------------------

accidents <- accidents %>%
  mutate(
    date = as.Date(date),
    year = year(date),
    month = month(date),
    month_name = month(date, label = TRUE, abbr = FALSE),
    day_name = wday(date, label = TRUE, abbr = FALSE)
  )

# ------------------------------------------------------------
# 3. Accident count by hour
# ------------------------------------------------------------

hourly_accidents <- accidents %>%
  count(hour, name = "accident_count")

print(hourly_accidents)

# ------------------------------------------------------------
# 4. Accident count by day of week
# ------------------------------------------------------------

daily_accidents <- accidents %>%
  count(day_name, name = "accident_count")

print(daily_accidents)

# ------------------------------------------------------------
# 5. Accident count by month
# ------------------------------------------------------------

monthly_accidents <- accidents %>%
  count(month_name, name = "accident_count")

print(monthly_accidents)

# ------------------------------------------------------------
# 6. Accident count by year
# ------------------------------------------------------------

yearly_accidents <- accidents %>%
  count(year, name = "accident_count")

print(yearly_accidents)

# ------------------------------------------------------------
# 7. Weekday vs Weekend
# ------------------------------------------------------------

weekend_analysis <- accidents %>%
  mutate(
    day_type = if_else(
      is_weekend == 1,
      "Weekend",
      "Weekday"
    )
  ) %>%
  count(day_type, name = "accident_count")

print(weekend_analysis)

# ------------------------------------------------------------
# 8. Peak vs Non-Peak
# ------------------------------------------------------------

peak_analysis <- accidents %>%
  mutate(
    hour_type = if_else(
      is_peak_hour == 1,
      "Peak Hour",
      "Non-Peak Hour"
    )
  ) %>%
  count(hour_type, name = "accident_count")

print(peak_analysis)

# ------------------------------------------------------------
# 9. Hour × Day heatmap data
# ------------------------------------------------------------

hour_day_heatmap <- accidents %>%
  count(day_name, hour, name = "accident_count")

print(hour_day_heatmap)

# ------------------------------------------------------------
# 10. Weather × Hour analysis
# ------------------------------------------------------------

weather_hour_analysis <- accidents %>%
  count(weather, hour, name = "accident_count")

print(weather_hour_analysis)

# ------------------------------------------------------------
# 11. Severity × Hour analysis
# ------------------------------------------------------------

severity_hour_analysis <- accidents %>%
  count(accident_severity, hour, name = "accident_count")

print(severity_hour_analysis)

# Create output folder
output_dir <- "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations"

dir.create(
  output_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

# Save charts
ggsave(
  file.path(output_dir, "hourly_accidents.png"),
  p_hour,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  file.path(output_dir, "daily_accidents.png"),
  p_day,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  file.path(output_dir, "monthly_accidents.png"),
  p_month,
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  file.path(output_dir, "hour_day_heatmap.png"),
  p_heatmap,
  width = 10,
  height = 6,
  dpi = 300
)
library(plotly)

# Interactive hourly chart
plotly_hour <- ggplotly(p_hour)

plotly_hour
library(htmlwidgets)

# Create interactive charts
plotly_hour <- ggplotly(p_hour)
plotly_day <- ggplotly(p_day)
plotly_month <- ggplotly(p_month)
plotly_heatmap <- ggplotly(p_heatmap)

# Save interactive charts
saveWidget(
  plotly_hour,
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/hourly_accidents.html",
  selfcontained = TRUE
)

saveWidget(
  plotly_day,
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/daily_accidents.html",
  selfcontained = TRUE
)

saveWidget(
  plotly_month,
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/monthly_accidents.html",
  selfcontained = TRUE
)

saveWidget(
  plotly_heatmap,
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/hour_day_heatmap.html",
  selfcontained = TRUE
)