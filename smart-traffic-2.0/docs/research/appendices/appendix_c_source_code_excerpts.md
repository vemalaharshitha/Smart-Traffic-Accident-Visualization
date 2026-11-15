# APPENDIX C — Representative Implementation Code Excerpts

This appendix provides key excerpts from the core computational modules of the **SMART TRAFFIC** platform.

---

## 1. Computer Vision & Multi-Object Tracking Pipeline (`smart_traffic_v2.py`)

```python
# Video processing loop using Ultralytics YOLO11n and ByteTrack association
results = model.track(
    frame,
    persist=True,
    tracker='bytetrack.yaml',
    conf=CONFIDENCE,     # 0.20
    imgsz=IMAGE_SIZE,    # 640
    classes=[2, 3, 5, 7],# COCO: car, motorcycle, bus, truck
    device=DEVICE,
    verbose=False
)

result = results[0]
tracked_ids = set()

if result.boxes is not None:
    for box in result.boxes:
        class_id = int(box.cls[0])
        if class_id in VEHICLE_CLASSES:
            counts[VEHICLE_CLASSES[class_id]] += 1
            if box.id is not None:
                tracked_ids.add(int(box.id[0]))

total = len(tracked_ids)

# Traffic flow state classification
if total >= 15:
    traffic_level = 'HIGH'
elif total >= 7:
    traffic_level = 'MEDIUM'
else:
    traffic_level = 'LOW'

# Dynamic heuristic congestion risk calculation
risk_score = min(total / 20.0, 1.0)
```

---

## 2. Machine Learning Severity Classifier (`randomForest` in R)

```r
# Random Forest model invocation
library(randomForest)

rf_model <- randomForest(
  formula = accident_severity ~ .,
  data = train_data,      # 16,000 samples (80% stratified split)
  ntree = 300,            # 300 decision trees
  mtry = 3,               # 3 variables sampled at each split
  importance = TRUE       # Record MeanDecreaseAccuracy & MeanDecreaseGini
)

# Test evaluation on 4,000 unseen samples
predictions <- predict(rf_model, newdata = test_data)
conf_matrix <- table(Actual = test_data$accident_severity, Predicted = predictions)
```

---

## 3. Demand-Responsive Adaptive Signal Controller (`app.R`)

```r
# Webster's Minimum Delay Adaptive Signal Phase Calculation
calculate_adaptive_signal <- function(vehicle_count, pcu_mix) {
  # Base green split calculation based on instantaneous vehicular queue
  if (vehicle_count >= 20) {
    green_phase <- 60 # Maximum green extension during heavy congestion
    amber_phase <- 4
    red_phase   <- 25
  } else if (vehicle_count >= 12) {
    green_phase <- 45
    amber_phase <- 3
    red_phase   <- 35
  } else {
    green_phase <- 30
    amber_phase <- 3
    red_phase   <- 45
  }
  list(green = green_phase, amber = amber_phase, red = red_phase)
}
```
