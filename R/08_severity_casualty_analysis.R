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

# Severity summary
severity_analysis <- accidents %>%
  group_by(accident_severity) %>%
  summarise(
    accident_count = n(),
    avg_casualties = mean(casualties),
    avg_vehicles = mean(vehicles_involved),
    avg_risk = mean(risk_score),
    total_casualties = sum(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(severity_analysis)

# Cause and severity
cause_severity <- accidents %>%
  count(cause, accident_severity, name = "accident_count")

print(cause_severity)

# Vehicles and casualties
vehicle_casualty <- accidents %>%
  group_by(vehicles_involved) %>%
  summarise(
    accident_count = n(),
    avg_casualties = mean(casualties),
    avg_risk = mean(risk_score),
    .groups = "drop"
  )

print(vehicle_casualty)

# Severity chart
p_severity <- ggplot(
  severity_analysis,
  aes(x = accident_severity, y = accident_count)
) +
  geom_col() +
  labs(
    title = "Accidents by Severity",
    x = "Severity",
    y = "Number of Accidents"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/accidents_by_severity.png",
  p_severity,
  width = 10,
  height = 6
)

saveWidget(
  ggplotly(p_severity),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/accidents_by_severity.html",
  selfcontained = TRUE
)

# Casualties by severity
p_casualties <- ggplot(
  severity_analysis,
  aes(x = accident_severity, y = avg_casualties)
) +
  geom_col() +
  labs(
    title = "Average Casualties by Accident Severity",
    x = "Severity",
    y = "Average Casualties"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/casualties_by_severity.png",
  p_casualties,
  width = 10,
  height = 6
)

saveWidget(
  ggplotly(p_casualties),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/casualties_by_severity.html",
  selfcontained = TRUE
)

# Vehicles vs casualties
p_vehicle <- ggplot(
  vehicle_casualty,
  aes(x = vehicles_involved, y = avg_casualties)
) +
  geom_col() +
  labs(
    title = "Vehicle Involvement vs Average Casualties",
    x = "Vehicles Involved",
    y = "Average Casualties"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/vehicles_vs_casualties.png",
  p_vehicle,
  width = 10,
  height = 6
)

saveWidget(
  ggplotly(p_vehicle),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/vehicles_vs_casualties.html",
  selfcontained = TRUE
)

# Cause × severity chart
p_cause_severity <- ggplot(
  cause_severity,
  aes(x = cause, y = accident_count, fill = accident_severity)
) +
  geom_col(position = "dodge") +
  labs(
    title = "Accident Causes by Severity",
    x = "Cause",
    y = "Number of Accidents"
  )

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/cause_by_severity.png",
  p_cause_severity,
  width = 11,
  height = 7
)

saveWidget(
  ggplotly(p_cause_severity),
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/outputs/visualizations/cause_by_severity.html",
  selfcontained = TRUE
)

severity_hour <- accidents %>%
  group_by(hour, accident_severity) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    .groups = "drop"
  )

severity_hour

p <- ggplot(severity_hour,
            aes(x = hour, y = accident_count,
                color = accident_severity)) +
  geom_line(linewidth = 1) +
  geom_point() +
  labs(
    title = "Accident Severity by Hour",
    x = "Hour of Day",
    y = "Number of Accidents",
    color = "Severity"
  ) +
  theme_minimal()

print(p)

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/severity_by_hour.png",
  p,
  width = 10,
  height = 6,
  dpi = 300
)

weather_plot <- ggplot(
  weather_risk,
  aes(x = weather, y = avg_risk)
) +
  geom_col() +
  geom_text(
    aes(label = round(avg_risk, 2)),
    vjust = -0.3
  ) +
  labs(
    title = "Accident Risk by Weather Condition",
    x = "Weather",
    y = "Average Risk Score"
  ) +
  theme_minimal()

print(weather_plot)

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/weather_risk.png",
  weather_plot,
  width = 10,
  height = 6,
  dpi = 300
)

cause_severity_plot <- ggplot(
  cause_severity,
  aes(
    x = cause,
    y = accident_count,
    fill = accident_severity
  )
) +
  geom_col(position = "dodge") +
  labs(
    title = "Accident Causes by Severity",
    x = "Cause",
    y = "Number of Accidents",
    fill = "Severity"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )

print(cause_severity_plot)

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/cause_severity.png",
  cause_severity_plot,
  width = 10,
  height = 6,
  dpi = 300
)

hotspot_plot <- ggplot(
  spatial_analysis,
  aes(
    x = lon_grid,
    y = lat_grid,
    size = accident_count
  )
) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Traffic Accident Hotspot Distribution",
    x = "Longitude",
    y = "Latitude",
    size = "Accidents"
  ) +
  theme_minimal()

print(hotspot_plot)

ggsave(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/traffic_hotspots.png",
  hotspot_plot,
  width = 10,
  height = 7,
  dpi = 300
)

model_data <- accidents %>%
  select(
    accident_severity,
    hour,
    is_weekend,
    road_type,
    lanes,
    traffic_signal,
    weather,
    visibility,
    temperature,
    traffic_density,
    cause,
    vehicles_involved,
    casualties,
    is_peak_hour,
    festival,
    risk_score
  ) %>%
  drop_na()

table(model_data$accident_severity)

set.seed(123)

train_index <- sample(
  1:nrow(model_data),
  size = 0.8 * nrow(model_data)
)

train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

dim(train_data)
dim(test_data)

# Prepare ML target
model_data <- accidents %>%
  select(
    accident_severity,
    hour,
    is_weekend,
    road_type,
    lanes,
    traffic_signal,
    weather,
    visibility,
    temperature,
    traffic_density,
    cause,
    vehicles_involved,
    casualties,
    is_peak_hour,
    festival,
    risk_score
  ) %>%
  drop_na()

# Convert target to classification
model_data$accident_severity <- factor(
  model_data$accident_severity,
  levels = c("minor", "major", "fatal")
)

# Train-test split
set.seed(123)

train_index <- sample(
  1:nrow(model_data),
  size = 0.8 * nrow(model_data)
)

train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

# Check data
dim(train_data)
dim(test_data)
table(train_data$accident_severity)
table(test_data$accident_severity)
# Create output folders
image_dir <- "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/images"
result_dir <- "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/results"

if (!dir.exists(image_dir)) {
  dir.create(image_dir, recursive = TRUE)
}

if (!dir.exists(result_dir)) {
  dir.create(result_dir, recursive = TRUE)
}

# Prepare ML data
model_data <- accidents %>%
  select(
    accident_severity,
    hour,
    is_weekend,
    road_type,
    lanes,
    traffic_signal,
    weather,
    visibility,
    temperature,
    traffic_density,
    cause,
    vehicles_involved,
    casualties,
    is_peak_hour,
    festival,
    risk_score
  ) %>%
  drop_na()

# Convert target to factor
model_data$accident_severity <- factor(
  model_data$accident_severity,
  levels = c("minor", "major", "fatal")
)

# Split data
set.seed(123)

train_index <- sample(
  1:nrow(model_data),
  size = 0.8 * nrow(model_data)
)

train_data <- model_data[train_index, ]
test_data <- model_data[-train_index, ]

# Check split
dim(train_data)
dim(test_data)
# Random Forest
library(randomForest)
library(tidyverse)

# Create output folders
base_dir <- "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic"

result_dir <- file.path(base_dir, "results")
image_dir <- file.path(base_dir, "images")

dir.create(result_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(image_dir, showWarnings = FALSE, recursive = TRUE)

set.seed(123)

# Train model
rf_model <- randomForest(
  accident_severity ~ .,
  data = train_data,
  ntree = 300,
  importance = TRUE
)

print(rf_model)

# Predictions
rf_predictions <- predict(
  rf_model,
  newdata = test_data
)

# Confusion matrix
confusion_matrix <- table(
  Actual = test_data$accident_severity,
  Predicted = rf_predictions
)

print(confusion_matrix)

# Save confusion matrix
write.csv(
  as.data.frame(confusion_matrix),
  file.path(result_dir, "confusion_matrix.csv"),
  row.names = FALSE
)

# Accuracy
accuracy <- mean(
  rf_predictions == test_data$accident_severity
)

print(paste(
  "Model Accuracy:",
  round(accuracy * 100, 2),
  "%"
))

# Save accuracy
write.csv(
  data.frame(
    metric = "Accuracy",
    value = accuracy
  ),
  file.path(result_dir, "model_accuracy.csv"),
  row.names = FALSE
)

# Feature importance
importance_data <- as.data.frame(
  importance(rf_model)
)

importance_data$feature <- rownames(importance_data)
rownames(importance_data) <- NULL

importance_data <- importance_data %>%
  arrange(desc(MeanDecreaseGini))

print(importance_data)

# Save feature importance
write.csv(
  importance_data,
  file.path(result_dir, "feature_importance.csv"),
  row.names = FALSE
)

# Feature importance plot
importance_plot <- ggplot(
  importance_data,
  aes(
    x = reorder(feature, MeanDecreaseGini),
    y = MeanDecreaseGini
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Random Forest Feature Importance",
    x = "Features",
    y = "Importance"
  ) +
  theme_minimal()

print(importance_plot)

# Save feature importance image
ggsave(
  file.path(image_dir, "feature_importance.png"),
  importance_plot,
  width = 10,
  height = 7,
  dpi = 300
)

# Class performance
classes <- levels(test_data$accident_severity)

metrics <- data.frame()

for (cls in classes) {
  
  actual <- test_data$accident_severity == cls
  predicted <- rf_predictions == cls
  
  tp <- sum(actual & predicted)
  fp <- sum(!actual & predicted)
  fn <- sum(actual & !predicted)
  
  precision <- ifelse(
    tp + fp == 0,
    0,
    tp / (tp + fp)
  )
  
  recall <- ifelse(
    tp + fn == 0,
    0,
    tp / (tp + fn)
  )
  
  f1 <- ifelse(
    precision + recall == 0,
    0,
    2 * precision * recall /
      (precision + recall)
  )
  
  metrics <- rbind(
    metrics,
    data.frame(
      severity = cls,
      precision = precision,
      recall = recall,
      F1_score = f1
    )
  )
}

print(metrics)

# Save classification metrics
write.csv(
  metrics,
  file.path(result_dir, "classification_metrics.csv"),
  row.names = FALSE
)

# Save confusion matrix plot
confusion_data <- as.data.frame(confusion_matrix)

confusion_plot <- ggplot(
  confusion_data,
  aes(
    x = Predicted,
    y = Actual,
    fill = Freq
  )
) +
  geom_tile() +
  geom_text(aes(label = Freq), size = 5) +
  labs(
    title = "Random Forest Confusion Matrix",
    x = "Predicted Severity",
    y = "Actual Severity",
    fill = "Count"
  ) +
  theme_minimal()

print(confusion_plot)

ggsave(
  file.path(image_dir, "confusion_matrix.png"),
  confusion_plot,
  width = 8,
  height = 6,
  dpi = 300
)

# Save model summary
capture.output(
  print(rf_model),
  file = file.path(result_dir, "random_forest_model.txt")
)

# Check saved files
list.files(result_dir)
list.files(image_dir)

# Random Forest evaluation plots

# 1. Variable importance plot
varImpPlot(
  rf_model,
  main = "Random Forest Variable Importance"
)

dev.copy(
  png,
  filename = file.path(image_dir, "rf_variable_importance.png"),
  width = 1000,
  height = 700,
  res = 120
)

dev.off()

# 2. Error rate plot
png(
  file.path(image_dir, "rf_error_rate.png"),
  width = 1000,
  height = 700,
  res = 120
)

plot(
  rf_model,
  main = "Random Forest Error Rate"
)

dev.off()

# 3. Confusion matrix heatmap
png(
  file.path(image_dir, "rf_confusion_matrix.png"),
  width = 1000,
  height = 700,
  res = 120
)

print(confusion_plot)

dev.off()

# Check saved images
list.files(image_dir)

# Logistic Regression

library(nnet)

set.seed(123)

logit_model <- multinom(
  accident_severity ~ .,
  data = train_data,
  trace = FALSE
)

print(logit_model)

# Predictions
logit_predictions <- predict(
  logit_model,
  newdata = test_data
)

# Confusion matrix
logit_confusion <- table(
  Actual = test_data$accident_severity,
  Predicted = logit_predictions
)

print(logit_confusion)

# Accuracy
logit_accuracy <- mean(
  logit_predictions == test_data$accident_severity
)

print(paste(
  "Logistic Regression Accuracy:",
  round(logit_accuracy * 100, 2),
  "%"
))

# Save confusion matrix
write.csv(
  as.data.frame(logit_confusion),
  file.path(result_dir, "logistic_confusion_matrix.csv"),
  row.names = FALSE
)

# Save accuracy
write.csv(
  data.frame(
    model = "Logistic Regression",
    accuracy = logit_accuracy
  ),
  file.path(result_dir, "logistic_accuracy.csv"),
  row.names = FALSE
)

# Confusion matrix plot
logit_confusion_data <- as.data.frame(logit_confusion)

logit_plot <- ggplot(
  logit_confusion_data,
  aes(
    x = Predicted,
    y = Actual,
    fill = Freq
  )
) +
  geom_tile() +
  geom_text(aes(label = Freq), size = 5) +
  labs(
    title = "Logistic Regression Confusion Matrix",
    x = "Predicted Severity",
    y = "Actual Severity",
    fill = "Count"
  ) +
  theme_minimal()

print(logit_plot)

ggsave(
  file.path(image_dir, "logistic_confusion_matrix.png"),
  logit_plot,
  width = 8,
  height = 6,
  dpi = 300
)

# Save model summary
capture.output(
  summary(logit_model),
  file = file.path(result_dir, "logistic_regression_model.txt")
)

# Check saved files
list.files(result_dir)
list.files(image_dir)

# Model comparison

model_comparison <- data.frame(
  model = c(
    "Random Forest",
    "Logistic Regression"
  ),
  accuracy = c(
    accuracy,
    logit_accuracy
  )
)

print(model_comparison)

# Save comparison
write.csv(
  model_comparison,
  file.path(result_dir, "model_comparison.csv"),
  row.names = FALSE
)

# Comparison plot
comparison_plot <- ggplot(
  model_comparison,
  aes(
    x = model,
    y = accuracy
  )
) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(accuracy * 100, 2), "%")),
    vjust = -0.3,
    size = 5
  ) +
  labs(
    title = "Model Accuracy Comparison",
    x = "Model",
    y = "Accuracy"
  ) +
  theme_minimal()

print(comparison_plot)

# Save image
ggsave(
  file.path(image_dir, "model_accuracy_comparison.png"),
  comparison_plot,
  width = 9,
  height = 6,
  dpi = 300
)

# Save best model
best_model <- model_comparison %>%
  arrange(desc(accuracy)) %>%
  slice(1)

print(best_model)

write.csv(
  best_model,
  file.path(result_dir, "best_model.csv"),
  row.names = FALSE
)

# Check files
list.files(result_dir)
list.files(image_dir)

# Create risk levels

accidents <- accidents %>%
  mutate(
    risk_level = case_when(
      risk_score >= 0.7 ~ "High Risk",
      risk_score >= 0.4 ~ "Medium Risk",
      TRUE ~ "Low Risk"
    )
  )

# Risk analysis

risk_analysis <- accidents %>%
  group_by(risk_level) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    avg_casualties = mean(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(risk_analysis)

# Save results

write.csv(
  risk_analysis,
  file.path(result_dir, "risk_analysis.csv"),
  row.names = FALSE
)

# Risk level plot

risk_plot <- ggplot(
  risk_analysis,
  aes(
    x = reorder(risk_level, accident_count),
    y = accident_count
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Accidents by Risk Level",
    x = "Risk Level",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(risk_plot)

ggsave(
  file.path(image_dir, "accidents_by_risk_level.png"),
  risk_plot,
  width = 9,
  height = 6,
  dpi = 300
)

# Risk score distribution

risk_score_plot <- ggplot(
  accidents,
  aes(x = risk_score)
) +
  geom_histogram(bins = 20) +
  labs(
    title = "Risk Score Distribution",
    x = "Risk Score",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(risk_score_plot)

ggsave(
  file.path(image_dir, "risk_score_distribution.png"),
  risk_score_plot,
  width = 9,
  height = 6,
  dpi = 300
)

# Risk by weather

weather_risk_plot <- ggplot(
  weather_risk,
  aes(
    x = reorder(weather, avg_risk),
    y = avg_risk
  )
) +
  geom_col() +
  labs(
    title = "Average Risk by Weather",
    x = "Weather",
    y = "Average Risk Score"
  ) +
  theme_minimal()

print(weather_risk_plot)

ggsave(
  file.path(image_dir, "risk_by_weather.png"),
  weather_risk_plot,
  width = 9,
  height = 6,
  dpi = 300
)

# Check saved files

list.files(result_dir)
list.files(image_dir)

# Cause and severity analysis

cause_severity <- accidents %>%
  count(cause, accident_severity, name = "accident_count")

print(cause_severity)

# Save results

write.csv(
  cause_severity,
  file.path(result_dir, "cause_severity.csv"),
  row.names = FALSE
)

# Plot

cause_severity_plot <- ggplot(
  cause_severity,
  aes(
    x = cause,
    y = accident_count,
    fill = accident_severity
  )
) +
  geom_col(position = "dodge") +
  labs(
    title = "Accident Severity by Cause",
    x = "Cause",
    y = "Number of Accidents",
    fill = "Severity"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 30, hjust = 1)
  )

print(cause_severity_plot)

# Save image

ggsave(
  file.path(image_dir, "cause_severity.png"),
  cause_severity_plot,
  width = 10,
  height = 6,
  dpi = 300
)

# Check saved files

list.files(result_dir)
list.files(image_dir)

# Weather and traffic risk

weather_traffic_risk <- accidents %>%
  group_by(weather, traffic_density) %>%
  summarise(
    accident_count = n(),
    avg_risk = mean(risk_score),
    avg_casualties = mean(casualties),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_risk))

print(weather_traffic_risk)

# Save results

write.csv(
  weather_traffic_risk,
  file.path(result_dir, "weather_traffic_risk.csv"),
  row.names = FALSE
)

# Risk heatmap

weather_traffic_plot <- ggplot(
  weather_traffic_risk,
  aes(
    x = traffic_density,
    y = weather,
    fill = avg_risk
  )
) +
  geom_tile() +
  geom_text(
    aes(label = round(avg_risk, 2)),
    size = 5
  ) +
  labs(
    title = "Average Accident Risk by Weather and Traffic Density",
    x = "Traffic Density",
    y = "Weather",
    fill = "Average Risk"
  ) +
  theme_minimal()

print(weather_traffic_plot)

# Save image

ggsave(
  file.path(image_dir, "weather_traffic_risk.png"),
  weather_traffic_plot,
  width = 9,
  height = 6,
  dpi = 300
)

# Check saved files

list.files(result_dir)
list.files(image_dir)


# Final visualizations

# 1. Accidents by city

city_plot <- ggplot(
  city_accidents,
  aes(
    x = reorder(city, accident_count),
    y = accident_count
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Accidents by City",
    x = "City",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(city_plot)

ggsave(
  file.path(image_dir, "accidents_by_city.png"),
  city_plot,
  width = 9,
  height = 6,
  dpi = 300
)


# 2. Accidents by year

year_plot <- ggplot(
  yearly_accidents,
  aes(
    x = year,
    y = accident_count
  )
) +
  geom_col() +
  labs(
    title = "Accidents by Year",
    x = "Year",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(year_plot)

ggsave(
  file.path(image_dir, "accidents_by_year.png"),
  year_plot,
  width = 9,
  height = 6,
  dpi = 300
)


# 3. Accidents by hour

hour_plot <- ggplot(
  hourly_accidents,
  aes(
    x = hour,
    y = accident_count
  )
) +
  geom_line(linewidth = 1) +
  geom_point() +
  labs(
    title = "Accidents by Hour",
    x = "Hour",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(hour_plot)

ggsave(
  file.path(image_dir, "accidents_by_hour.png"),
  hour_plot,
  width = 9,
  height = 6,
  dpi = 300
)


# 4. Accidents by severity

severity_plot <- ggplot(
  severity_analysis,
  aes(
    x = accident_severity,
    y = accident_count
  )
) +
  geom_col() +
  labs(
    title = "Accidents by Severity",
    x = "Severity",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(severity_plot)

ggsave(
  file.path(image_dir, "accidents_by_severity.png"),
  severity_plot,
  width = 9,
  height = 6,
  dpi = 300
)


# 5. Accidents by weather

weather_plot <- ggplot(
  weather_risk,
  aes(
    x = weather,
    y = accident_count
  )
) +
  geom_col() +
  labs(
    title = "Accidents by Weather",
    x = "Weather",
    y = "Number of Accidents"
  ) +
  theme_minimal()

print(weather_plot)

ggsave(
  file.path(image_dir, "accidents_by_weather.png"),
  weather_plot,
  width = 9,
  height = 6,
  dpi = 300
)


# Check all images

list.files(image_dir)


# Model comparison

rf_accuracy <- mean(rf_predictions == test_data$accident_severity)

logistic_predictions <- predict(
  logistic_model,
  newdata = test_data,
  type = "response"
)

logistic_accuracy <- mean(
  logistic_predictions == test_data$accident_severity
)

model_comparison <- data.frame(
  Model = c("Random Forest", "Logistic Regression"),
  Accuracy = c(rf_accuracy, logistic_accuracy)
)

print(model_comparison)

# Save comparison
write.csv(
  model_comparison,
  file.path(result_dir, "model_comparison.csv"),
  row.names = FALSE
)

# Best model
best_model <- model_comparison %>%
  arrange(desc(Accuracy)) %>%
  slice(1)

print(best_model)

write.csv(
  best_model,
  file.path(result_dir, "best_model.csv"),
  row.names = FALSE
)

# Comparison plot
model_plot <- ggplot(
  model_comparison,
  aes(x = Model, y = Accuracy)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(Accuracy * 100, 2), "%")),
    vjust = -0.3
  ) +
  scale_y_continuous(
    labels = scales::percent,
    limits = c(0, 1)
  ) +
  labs(
    title = "Model Accuracy Comparison",
    x = "Model",
    y = "Accuracy"
  ) +
  theme_minimal()

print(model_plot)

ggsave(
  file.path(image_dir, "model_accuracy_comparison.png"),
  model_plot,
  width = 10,
  height = 6,
  dpi = 300
)

# Check saved files
list.files(result_dir)
list.files(image_dir)
# Load logistic accuracy
logistic_result <- read.csv(
  file.path(result_dir, "logistic_accuracy.csv")
)

print(logistic_result)

# Get logistic accuracy
logistic_accuracy <- logistic_result$value[1]

# Random Forest accuracy
rf_accuracy <- mean(
  rf_predictions == test_data$accident_severity
)

# Model comparison
model_comparison <- data.frame(
  Model = c("Random Forest", "Logistic Regression"),
  Accuracy = c(rf_accuracy, logistic_accuracy)
)

print(model_comparison)

# Save comparison
write.csv(
  model_comparison,
  file.path(result_dir, "model_comparison.csv"),
  row.names = FALSE
)

# Find best model
best_model <- model_comparison %>%
  arrange(desc(Accuracy)) %>%
  slice(1)

print(best_model)

write.csv(
  best_model,
  file.path(result_dir, "best_model.csv"),
  row.names = FALSE
)

# Accuracy plot
model_plot <- ggplot(
  model_comparison,
  aes(x = Model, y = Accuracy)
) +
  geom_col() +
  geom_text(
    aes(label = paste0(round(Accuracy * 100, 2), "%")),
    vjust = -0.3
  ) +
  scale_y_continuous(
    labels = scales::percent,
    limits = c(0, 1)
  ) +
  labs(
    title = "Model Accuracy Comparison",
    x = "Model",
    y = "Accuracy"
  ) +
  theme_minimal()

print(model_plot)

# Save PNG
ggsave(
  file.path(image_dir, "model_accuracy_comparison.png"),
  model_plot,
  width = 10,
  height = 6,
  dpi = 300
)

# Check saved files
list.files(result_dir)
list.files(image_dir)

# Compare model metrics

print(metrics)

# Check saved model comparison
model_comparison <- read.csv(
  file.path(result_dir, "model_comparison.csv")
)

print(model_comparison)

# Save final model comparison
write.csv(
  model_comparison,
  file.path(result_dir, "final_model_comparison.csv"),
  row.names = FALSE
)

# Final findings

final_findings <- c(
  "SMART TRAFFIC - FINAL FINDINGS",
  "",
  paste("Total accidents:", nrow(accidents)),
  "",
  "1. CITY FINDINGS",
  paste(
    "Highest accident count:",
    city_accidents$city[1],
    "-",
    city_accidents$accident_count[1],
    "accidents"
  ),
  "",
  "2. SEVERITY FINDINGS",
  paste(
    "Minor accidents:",
    severity_analysis$accident_count[
      severity_analysis$accident_severity == "minor"
    ]
  ),
  paste(
    "Major accidents:",
    severity_analysis$accident_count[
      severity_analysis$accident_severity == "major"
    ]
  ),
  paste(
    "Fatal accidents:",
    severity_analysis$accident_count[
      severity_analysis$accident_severity == "fatal"
    ]
  ),
  "",
  "3. WEATHER FINDINGS",
  paste(
    "Highest average risk weather:",
    weather_risk$weather[1],
    "-",
    round(weather_risk$avg_risk[1], 3)
  ),
  "",
  "4. TRAFFIC FINDINGS",
  paste(
    "Highest average risk traffic density:",
    traffic_risk$traffic_density[1],
    "-",
    round(traffic_risk$avg_risk[1], 3)
  ),
  "",
  "5. TOP RISK CONDITION",
  paste(
    "Weather:",
    top_risk_conditions$weather[1],
    "| Traffic:",
    top_risk_conditions$traffic_density[1],
    "| Severity:",
    top_risk_conditions$accident_severity[1],
    "| Average Risk:",
    round(top_risk_conditions$avg_risk[1], 3)
  ),
  "",
  "6. MACHINE LEARNING",
  paste("Random Forest accuracy:", round(rf_accuracy * 100, 2), "%"),
  paste("Logistic Regression accuracy:", round(logistic_accuracy * 100, 2), "%"),
  "",
  "7. CLASS PERFORMANCE",
  paste(
    "Fatal F1-score:",
    round(metrics$F1_score[metrics$severity == "fatal"] * 100, 2),
    "%"
  ),
  paste(
    "Major F1-score:",
    round(metrics$F1_score[metrics$severity == "major"] * 100, 2),
    "%"
  ),
  paste(
    "Minor F1-score:",
    round(metrics$F1_score[metrics$severity == "minor"] * 100, 2),
    "%"
  ),
  "",
  "8. CONCLUSION",
  "Both models achieved 68.45% accuracy.",
  "Fatal accidents were identified very effectively.",
  "Minor accidents had high recall.",
  "Major accidents were difficult to classify accurately.",
  "Weather and traffic density showed strong relationships with accident risk."
)

# Print findings
cat(paste(final_findings, collapse = "\n"))

# Save findings
writeLines(
  final_findings,
  file.path(result_dir, "final_findings.txt")
)

# Check file
list.files(result_dir)


# Final findings

final_findings <- data.frame(
  Category = c(
    "Total Accidents",
    "Highest Accident City",
    "Minor Accidents",
    "Major Accidents",
    "Fatal Accidents",
    "Highest Risk Weather",
    "Highest Risk Traffic",
    "Top Risk Condition",
    "Random Forest Accuracy",
    "Logistic Regression Accuracy",
    "Fatal F1 Score",
    "Major F1 Score",
    "Minor F1 Score"
  ),
  Finding = c(
    "20000",
    "Chandigarh - 2577",
    "11025",
    "5988",
    "2987",
    "Fog - 0.589",
    "High Traffic - 0.595",
    "Fog + High Traffic + Fatal - 0.919",
    "68.45%",
    "68.45%",
    "99.32%",
    "6.56%",
    "76.96%"
  )
)

print(final_findings)

write.csv(
  final_findings,
  file.path(result_dir, "final_findings.csv"),
  row.names = FALSE
)

# Final dashboard

dashboard_data <- data.frame(
  Metric = c(
    "Total Accidents",
    "Highest Risk Weather",
    "Highest Risk Traffic",
    "Top Risk Score",
    "Random Forest Accuracy",
    "Logistic Regression Accuracy"
  ),
  Value = c(
    "20,000",
    "Fog - 0.589",
    "High - 0.595",
    "0.919",
    "68.45%",
    "68.45%"
  )
)

print(dashboard_data)

write.csv(
  dashboard_data,
  file.path(result_dir, "dashboard_summary.csv"),
  row.names = FALSE
)

dashboard_plot <- ggplot(
  dashboard_data,
  aes(x = Metric, y = Value)
) +
  geom_text(size = 6) +
  coord_flip() +
  labs(
    title = "Smart Traffic - Final Dashboard",
    x = NULL,
    y = NULL
  ) +
  theme_void() +
  theme(
    plot.title = element_text(
      size = 20,
      face = "bold",
      hjust = 0.5
    )
  )

print(dashboard_plot)

ggsave(
  file.path(image_dir, "final_dashboard.png"),
  dashboard_plot,
  width = 12,
  height = 7,
  dpi = 300
)

list.files(image_dir)
list.files(result_dir)

library(ggplot2)
library(dplyr)

image_dir <- "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/images"
dir.create(image_dir, recursive = TRUE, showWarnings = FALSE)

dashboard_data <- data.frame(
  metric = c(
    "Total Accidents",
    "Highest City Accidents",
    "Highest Weather Risk",
    "Highest Traffic Risk",
    "Top Risk Condition",
    "Random Forest Accuracy"
  ),
  value = c(
    "20,000",
    "Chandigarh - 2,577",
    "Fog - 0.589",
    "High Traffic - 0.595",
    "Fog + High + Fatal - 0.919",
    "68.45%"
  )
)

dashboard_plot <- ggplot(
  dashboard_data,
  aes(
    x = metric,
    y = 1,
    label = value
  )
) +
  geom_point(size = 12) +
  geom_text(
    vjust = -1.5,
    size = 5
  ) +
  labs(
    title = "Smart Traffic Accident Analysis Dashboard",
    x = NULL,
    y = NULL
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 30,
      hjust = 1,
      size = 10
    ),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(
      size = 18,
      face = "bold",
      hjust = 0.5
    )
  )

print(dashboard_plot)

ggsave(
  file.path(image_dir, "smart_traffic_dashboard.png"),
  dashboard_plot,
  width = 12,
  height = 7,
  dpi = 300
)

library(rmarkdown)

project_dir <- "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic"
image_dir <- file.path(project_dir, "images")
result_dir <- file.path(project_dir, "results")

report_file <- file.path(project_dir, "final_report.Rmd")

report_text <- '
---
title: "Smart Traffic Accident Analysis"
author: "Harshitha"
date: "`r Sys.Date()`"
output:
  pdf_document:
    toc: true
    number_sections: true
---

# Introduction

This project analyzes 20,000 road accident records from Indian cities.

The analysis examines accident patterns based on time, location, weather, traffic density, severity, causes, casualties and risk scores. Machine learning models were also used to predict accident severity.

# Dataset Overview

The dataset contains 20,000 accident records and 24 original variables. Additional analytical variables were created during the analysis.

## Dataset Summary

- Total accidents: 20,000
- Cities: 8
- States: 7
- Years covered: 2022 to 2025
- Accident severity classes: Minor, Major and Fatal

# Accident Severity

The accident severity distribution was:

- Minor accidents: 11,025
- Major accidents: 5,988
- Fatal accidents: 2,987

![Accident Severity](images/accidents_by_severity.png)

# City Analysis

Chandigarh recorded the highest number of accidents with 2,577 accidents.

![Accidents by City](images/accidents_by_city.png)

# Accident Patterns by Hour

Accidents were analyzed across all 24 hours of the day.

![Accidents by Hour](images/accidents_by_hour.png)

# Accident Patterns by Year

The dataset contains accident records from 2022, 2023, 2024 and 2025.

![Accidents by Year](images/accidents_by_year.png)

# Weather Analysis

Fog had the highest average risk score:

- Fog: 0.589
- Rain: 0.488
- Clear: 0.237

![Weather Risk](images/weather_risk.png)

# Traffic Density Analysis

High traffic density had the highest average risk score:

- High: 0.595
- Medium: 0.368
- Low: 0.339

![Traffic Risk](images/risk_by_weather.png)

# Accident Causes

The main accident causes included overspeeding, poor road conditions, weather, drunk driving and distraction.

![Cause and Severity](images/cause_severity.png)

# Traffic Hotspots

Spatial analysis identified areas with high concentrations of accidents.

![Traffic Hotspots](images/traffic_hotspots.png)

# Risk Analysis

The highest-risk combination was:

**Fog + High Traffic + Fatal Accident**

Average risk score: **0.919**

![Weather Traffic Risk](images/weather_traffic_risk.png)

# Severity by Hour

Accident severity was also examined across different hours of the day.

![Severity by Hour](images/severity_by_hour.png)

# Machine Learning

Two machine learning models were evaluated:

- Random Forest
- Logistic Regression

The Random Forest model achieved an accuracy of **68.45%**.

![Model Comparison](images/model_accuracy_comparison.png)

# Random Forest Performance

The Random Forest model used 300 trees.

![Feature Importance](images/feature_importance.png)

The Random Forest confusion matrix is shown below.

![Random Forest Confusion Matrix](images/rf_confusion_matrix.png)

# Class Performance

The classification results were:

| Severity | Precision | Recall | F1 Score |
|---|---:|---:|---:|
| Fatal | 99.83% | 98.82% | 99.32% |
| Major | 39.64% | 3.57% | 6.56% |
| Minor | 63.84% | 96.88% | 76.96% |

Fatal accidents were identified very effectively. Minor accidents had high recall, while major accidents were difficult to classify accurately.

# Conclusion

The analysis shows that weather and traffic density have strong relationships with accident risk.

Fog conditions and high traffic density were associated with higher risk. The highest-risk condition identified was fog combined with high traffic and fatal accident severity.

The machine learning models achieved an accuracy of 68.45%. Fatal accidents were classified very effectively, while major accidents remained difficult to distinguish accurately.

Overall, the analysis demonstrates how accident data, risk analysis and machine learning can be used to understand road safety patterns and identify high-risk conditions.
'

writeLines(report_text, report_file)

render(
  input = report_file,
  output_file = file.path(project_dir, "final_report.pdf"),
  envir = new.env()
)

file.remove(report_file)

print("Final report created successfully!")
print(file.path(project_dir, "final_report.pdf"))

list.files(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic",
  pattern = "\\.Rmd$",
  recursive = TRUE,
  full.names = TRUE
)
