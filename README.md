# 🚦 Smart Accident Visualization

### Road Accident Analysis, Risk Assessment, Visualization & Machine Learning

Smart Accident Visualization is an R-based data science project that analyzes **20,000 road accident records** to identify accident patterns, severity, risk factors, weather and traffic relationships, accident causes, hotspots, and machine-learning-based severity predictions.

---

## 🎯 Objectives

- Analyze road accident patterns
- Identify accident-prone cities and hotspots
- Study accidents by year and hour
- Analyze accident severity
- Analyze weather and traffic conditions
- Calculate and compare accident risks
- Study accident causes
- Analyze vehicles and casualties
- Build machine learning models
- Compare Random Forest and Logistic Regression
- Create visualizations and a Smart Traffic dashboard
- Generate HTML and PDF reports

---

## 🛠️ Technologies

| Technology | Purpose |
|---|---|
| R | Data analysis & ML |
| RStudio | Development |
| dplyr / Tidyverse | Data processing |
| ggplot2 | Visualization |
| randomForest | Machine learning |
| R Markdown | Reporting |
| LaTeX / TinyTeX | PDF generation |
| Git & GitHub | Version control |

---

## 📊 Dataset

**Total records: 20,000**

The dataset contains accident-related information including:

- City
- Location
- Date / Year
- Hour
- Weather
- Traffic density
- Accident cause
- Accident severity
- Risk score
- Vehicles involved
- Casualties

---

# 🔄 Analysis Workflow

```text
Accident Dataset
       ↓
Data Inspection
       ↓
Data Cleaning & Preprocessing
       ↓
Exploratory Data Analysis
       ↓
City / Year / Hour Analysis
       ↓
Weather / Traffic Analysis
       ↓
Severity & Cause Analysis
       ↓
Risk Analysis
       ↓
Hotspot Analysis
       ↓
Visualization
       ↓
Feature Preparation
       ↓
Train / Test Split
       ↓
Machine Learning
   ↙             ↘
Random Forest   Logistic Regression
   ↘             ↙
Model Evaluation
       ↓
Model Comparison
       ↓
Smart Traffic Dashboard
       ↓
HTML + PDF Reports

## 🔍 Main Analysis

The Smart Accident Visualization project performs a complete analysis of road accident data using multiple dimensions.

---

## 1. 🏙️ City Analysis

City-wise accident counts were analyzed to identify accident-prone locations.

**Key finding:**

> Chandigarh recorded the highest number of accidents with **2,577 accidents**.

![Accidents by City](images/accidents_by_city.png)

---

## 2. 📅 Year-wise Analysis

Accidents were analyzed by year to identify changes and trends over time.

![Accidents by Year](images/accidents_by_year.png)

---

## 3. ⏰ Hour-wise Analysis

Accident frequency was analyzed across different hours of the day.

![Accidents by Hour](images/accidents_by_hour.png)

Severity was also analyzed by hour.

![Severity by Hour](images/severity_by_hour.png)

---

## 4. ⚠️ Severity Analysis

The dataset contains three accident severity categories.

| Severity | Accidents |
|---|---:|
| Minor | 11,025 |
| Major | 5,988 |
| Fatal | 2,987 |
| **Total** | **20,000** |

![Accidents by Severity](images/accidents_by_severity.png)

---

## 5. 🌦️ Weather Analysis

Weather conditions were analyzed to understand their relationship with accident risk.

**Highest average weather risk:**

> **Fog — 0.589**

![Accidents by Weather](images/accidents_by_weather.png)

![Weather Risk](images/weather_risk.png)

---

## 6. 🚗 Traffic Density Analysis

Traffic density was analyzed to identify conditions associated with higher accident risk.

**Highest average traffic risk:**

> **High traffic — 0.595**

---

## 7. 📊 Risk Analysis

Risk scores were analyzed using weather, traffic density, severity and other accident characteristics.

### Risk Score Distribution

![Risk Score Distribution](images/risk_score_distribution.png)

### Risk by Weather

![Risk by Weather](images/risk_by_weather.png)

### Risk Levels

![Risk Levels](images/accidents_by_risk_level.png)

---

## 8. 🚨 Weather + Traffic Risk Analysis

Weather and traffic density were combined to identify high-risk conditions.

### Highest-risk condition

| Weather | Traffic | Severity | Average Risk |
|---|---|---|---:|
| Fog | High | Fatal | **0.919** |

![Weather Traffic Risk](images/weather_traffic_risk.png)

---

## 9. 🛣️ Accident Cause Analysis

Accident causes were compared with accident severity to understand which causes are associated with different outcomes.

![Cause Severity](images/cause_severity.png)

---

## 10. 📍 Traffic Hotspot Analysis

Geographical accident locations were analyzed to identify areas with high accident concentration.

**Highest identified hotspot: approximately 636 accidents.**

![Traffic Hotspots](images/traffic_hotspots.png)

---

## 11. 🚗 Vehicle and Casualty Analysis

The relationship between vehicles involved, casualties and risk was analyzed.

| Vehicles Involved | Accident Count | Avg. Casualties | Avg. Risk |
|---:|---:|---:|---:|
| 1 | 4,030 | 0.573 | 0.438 |
| 2 | 4,030 | 1.160 | 0.437 |
| 3 | 4,007 | 1.710 | 0.434 |
| 4 | 3,936 | 2.310 | 0.445 |
| 5 | 3,997 | 2.900 | 0.435 |

**Observation:** Average casualties increase as the number of vehicles involved increases.

---

# 🤖 Machine Learning Analysis

Machine learning was used to predict **accident severity**.

Two models were evaluated:

- Random Forest
- Logistic Regression

### Model Comparison

| Model | Accuracy |
|---|---:|
| Random Forest | **68.45%** |
| Logistic Regression | **68.45%** |

![Model Accuracy Comparison](images/model_accuracy_comparison.png)

---

## 🌳 Random Forest Analysis

Random Forest was trained using **300 trees**.

![Random Forest Confusion Matrix](images/rf_confusion_matrix.png)

### Classification Performance

| Severity | Precision | Recall | F1 Score |
|---|---:|---:|---:|
| Minor | 63.84% | **96.88%** | **76.96%** |
| Major | 39.64% | 3.57% | **6.56%** |
| Fatal | **99.83%** | **98.82%** | **99.32%** |

### Feature Importance

![Feature Importance](images/feature_importance.png)

![RF Variable Importance](images/rf_variable_importance.png)

### Error Rate

![RF Error Rate](images/rf_error_rate.png)

---

## 📈 Logistic Regression Analysis

Logistic Regression was used as a baseline classification model.

**Accuracy: 68.45%**

![Logistic Regression Confusion Matrix](images/logistic_confusion_matrix.png)

---

## 🧠 Main Analysis Findings

| Analysis | Main Finding |
|---|---|
| City | Chandigarh had the highest accident count |
| Severity | Minor accidents were most common |
| Weather | Fog had the highest average risk |
| Traffic | High traffic had the highest average risk |
| Combined Risk | Fog + High Traffic + Fatal had risk **0.919** |
| Hotspot | Highest hotspot had approximately **636 accidents** |
| Random Forest | Accuracy **68.45%** |
| Logistic Regression | Accuracy **68.45%** |
| Fatal Classification | F1-score **99.32%** |
| Minor Classification | Recall **96.88%** |
| Major Classification | F1-score **6.56%** |

---

# 📌 Overall Analysis Conclusion

The analysis shows that accident patterns vary across **location, time, weather, traffic density, causes and severity**.

The strongest identified risk condition was:

> **Fog + High Traffic + Fatal Severity → Average Risk 0.919**

Machine learning successfully classified fatal accidents with very high performance, while **major accident classification remains the main challenge**.

These findings provide the foundation for the future **Smart Traffic 2.0** system with real-time traffic, weather, risk prediction, interactive maps and automated alerts.
# 👩‍💻 Author

### Harshitha

GitHub:

https://github.com/vemalaharshitha

Repository:

https://github.com/vemalaharshitha/Smart-Traffic-Accident-Visualization

---

# 📜 License

This project is intended for:

- Educational purposes
- Academic submission
- Research
- Data science portfolio
- Machine learning demonstration

---

# ⭐ Conclusion

**Smart Accident Visualization 1.0** demonstrates a complete data science workflow for analyzing road accident data.

The project combines:

- Data cleaning and preparation
- Exploratory data analysis
- Accident severity analysis
- Weather analysis
- Traffic-density analysis
- Accident-cause analysis
- Vehicle and casualty analysis
- Risk-score analysis
- Accident hotspot analysis
- Data visualization
- Machine learning
- Random Forest
- Logistic Regression
- Feature importance
- Model evaluation
- Smart Traffic dashboard
- HTML report
- PDF report

The analysis identified important patterns across **location, time, weather, traffic density, severity, causes, vehicles, casualties and accident hotspots**.

The machine-learning models achieved an overall accuracy of **68.45%**.

The strongest classification performance was obtained for **fatal accidents**, with an **F1-score of 99.32%**.

The major-accident category remains the main classification challenge, with an **F1-score of 6.56%**.

The most important risk finding was:

> 🚨 **Fog + High Traffic + Fatal Severity → Average Risk 0.919**

This project provides the foundation for **Smart Traffic 2.0**, where the historical analysis can be extended into a real-time intelligent traffic-safety system using:

- 🌦️ Live weather data
- 🚗 Real-time traffic data
- 🗺️ Interactive accident-risk maps
- 🤖 Real-time risk prediction
- 🚨 Automated safety alerts
- 📊 Live dashboards
- 🌐 Web application
- ☁️ Cloud deployment

---

# 🚦 Smart Accident Visualization

### Analyze → Understand → Predict → Improve

**Smart Traffic 1.0 → Smart Traffic 2.0 → Smarter & Safer Roads**
