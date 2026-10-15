library(tidyverse)
library(plotly)
library(htmlwidgets)

# Create output folder
dir.create(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations",
  recursive = TRUE,
  showWarnings = FALSE
)

# Load data
accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)

# Create risk level
accidents <- accidents %>%
  mutate(
    risk_level = case_when(
      risk_score >= 0.7 ~ "High Risk",
      risk_score >= 0.4 ~ "Medium Risk",
      TRUE ~ "Low Risk"
    )
  )

# Cause risk chart
p_cause <- ggplot(
  accidents %>%
    group_by(cause) %>%
    summarise(avg_risk = mean(risk_score)),
  aes(x = reorder(cause, avg_risk), y = avg_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Average Accident Risk by Cause",
    x = "Cause",
    y = "Average Risk Score"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/risk_by_cause.png",
  p_cause,
  width = 10,
  height = 6
)

saveWidget(
  ggplotly(p_cause),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/risk_by_cause.html",
  selfcontained = TRUE
)

# Weather risk chart
p_weather <- ggplot(
  accidents %>%
    group_by(weather) %>%
    summarise(avg_risk = mean(risk_score)),
  aes(x = weather, y = avg_risk)
) +
  geom_col() +
  labs(
    title = "Average Accident Risk by Weather",
    x = "Weather",
    y = "Average Risk Score"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/risk_by_weather.png",
  p_weather,
  width = 10,
  height = 6
)

saveWidget(
  ggplotly(p_weather),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/risk_by_weather.html",
  selfcontained = TRUE
)

# Traffic density risk chart
p_traffic <- ggplot(
  accidents %>%
    group_by(traffic_density) %>%
    summarise(avg_risk = mean(risk_score)),
  aes(x = traffic_density, y = avg_risk)
) +
  geom_col() +
  labs(
    title = "Average Accident Risk by Traffic Density",
    x = "Traffic Density",
    y = "Average Risk Score"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/risk_by_traffic.png",
  p_traffic,
  width = 10,
  height = 6
)

saveWidget(
  ggplotly(p_traffic),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/risk_by_traffic.html",
  selfcontained = TRUE
)

# Combined risk conditions
combined_risk <- accidents %>%
  group_by(weather, traffic_density, accident_severity) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    total_casualties = sum(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

# Top 15 risk conditions
top_risk_conditions <- combined_risk %>%
  slice_head(n = 15)

# Combined risk chart
p_combined <- ggplot(
  top_risk_conditions,
  aes(
    x = reorder(
      paste(weather, traffic_density, accident_severity, sep = " + "),
      avg_risk
    ),
    y = avg_risk
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 15 High-Risk Accident Conditions",
    x = "Conditions",
    y = "Average Risk Score"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/top_risk_conditions.png",
  p_combined,
  width = 11,
  height = 8
)

saveWidget(
  ggplotly(p_combined),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/top_risk_conditions.html",
  selfcontained = TRUE
)