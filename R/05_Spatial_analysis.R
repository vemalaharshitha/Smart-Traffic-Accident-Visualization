library(tidyverse)
library(leaflet)

# Load data
accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)

# City analysis
city_accidents <- accidents %>%
  count(city, name = "accident_count") %>%
  arrange(desc(accident_count))

print(city_accidents)

# State analysis
state_accidents <- accidents %>%
  count(state, name = "accident_count") %>%
  arrange(desc(accident_count))

print(state_accidents)

# Create spatial grid
spatial_analysis <- accidents %>%
  mutate(
    lat_grid = round(latitude, 1),
    lon_grid = round(longitude, 1)
  ) %>%
  group_by(lat_grid, lon_grid) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    total_casualties = sum(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(accident_count))

print(spatial_analysis)

# Top hotspot zones
top_hotspots <- spatial_analysis %>%
  slice_head(n = 20)

print(top_hotspots)

# Create hotspot map
hotspot_map <- leaflet(top_hotspots) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~lon_grid,
    lat = ~lat_grid,
    radius = ~sqrt(accident_count) * 3,
    popup = ~paste(
      "<b>Accidents:</b>", accident_count,
      "<br><b>Average Risk:</b>", round(avg_risk, 2),
      "<br><b>Total Casualties:</b>", total_casualties
    ),
    stroke = TRUE,
    fillOpacity = 0.7
  )

hotspot_map

# Save hotspot map
htmlwidgets::saveWidget(
  hotspot_map,
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/traffic_hotspot_map.html",
  selfcontained = TRUE
)
hotspot_map