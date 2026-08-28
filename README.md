
# 🚦 Smart Accident Visualization

### Road Accident Analysis, Risk Assessment, Visualization & Machine Learning

Smart Accident Visualization is an R-based data science project that analyzes **20,000 road accident records** to identify accident patterns, severity, risk factors, weather and traffic relationships, accident causes, hotspots, and machine-learning-based severity predictions.

---

## 🎯 Objectives

- Analyze road accident patterns
- Identify accident-prone cities and hotspots
- Analyze accidents by year and hour
- Study accident severity
- Analyze weather and traffic conditions
- Calculate accident risk
- Study accident causes
- Analyze vehicles and casualties
- Build machine-learning models
- Compare Random Forest and Logistic Regression
- Create visualizations and a Smart Traffic dashboard
- Generate HTML and PDF reports

---

## 🛠️ Technologies

| Technology | Purpose |
|---|---|
| R | Data Analysis & Machine Learning |
| RStudio | Development |
| Tidyverse / dplyr | Data Processing |
| ggplot2 | Data Visualization |
| Random Forest | Machine Learning |
| Logistic Regression | Classification |
| R Markdown | Reporting |
| TinyTeX / LaTeX | PDF Generation |
| Git & GitHub | Version Control |

---

## 📊 Dataset

**Total Records: 20,000**

The dataset contains:

- City
- Location
- Date / Year
- Hour
- Weather
- Traffic Density
- Accident Cause
- Accident Severity
- Risk Score
- Vehicles Involved
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
       ↓
Model Evaluation
       ↓
Model Comparison
       ↓
Smart Traffic Dashboard
       ↓
HTML + PDF Reports
````

---

# 🔍 Main Analysis

## 🏙️ City Analysis

City-wise accident patterns were analyzed to identify accident-prone locations.

**Key finding:** Chandigarh recorded the highest number of accidents with **2,577 accidents**.

---

## 📅 Year-wise Analysis

Accidents were analyzed by year to identify trends and changes over time.

---

## ⏰ Hour-wise Analysis

Accident frequency and severity were analyzed across different hours of the day.

---

## ⚠️ Severity Analysis

Accidents were categorized into:

| Severity  |  Accidents |
| --------- | ---------: |
| Minor     |     11,025 |
| Major     |      5,988 |
| Fatal     |      2,987 |
| **Total** | **20,000** |

---

## 🌦️ Weather Analysis

Weather conditions were analyzed to understand their relationship with accident risk.

**Highest average weather risk:**

> Fog — **0.589**

---

## 🚗 Traffic Density Analysis

Traffic density was analyzed to identify conditions associated with higher accident risk.

**Highest average traffic risk:**

> High Traffic — **0.595**

---

## 📊 Risk Analysis

Risk scores were analyzed using:

* Weather
* Traffic density
* Accident severity
* Location
* Other accident characteristics

---

## 🚨 Weather + Traffic Risk Analysis

Weather and traffic conditions were combined to identify high-risk situations.

| Weather | Traffic | Severity | Average Risk |
| ------- | ------- | -------- | -----------: |
| Fog     | High    | Fatal    |    **0.919** |

---

## 🛣️ Accident Cause Analysis

Accident causes were compared with accident severity to identify relationships between causes and outcomes.

---

## 📍 Traffic Hotspot Analysis

Geographical accident locations were analyzed to identify accident hotspots.

**Highest identified hotspot:** approximately **636 accidents**.

---

## 🚙 Vehicle & Casualty Analysis

The relationship between vehicles involved, casualties and accident risk was analyzed.

| Vehicles Involved | Accident Count | Avg. Casualties | Avg. Risk |
| ----------------: | -------------: | --------------: | --------: |
|                 1 |          4,030 |           0.573 |     0.438 |
|                 2 |          4,030 |           1.160 |     0.437 |
|                 3 |          4,007 |           1.710 |     0.434 |
|                 4 |          3,936 |           2.310 |     0.445 |
|                 5 |          3,997 |           2.900 |     0.435 |

**Observation:** Average casualties increase as the number of vehicles involved increases.

---

# 🤖 Machine Learning

Machine learning was used to predict **accident severity**.

### Models

* 🌳 Random Forest
* 📈 Logistic Regression

---

## 📊 Model Comparison

| Model               |   Accuracy |
| ------------------- | ---------: |
| Random Forest       | **68.45%** |
| Logistic Regression | **68.45%** |

---

## 🌳 Random Forest

Random Forest was trained using **300 trees**.

### Classification Performance

| Severity |  Precision |     Recall |   F1 Score |
| -------- | ---------: | ---------: | ---------: |
| Minor    |     63.84% | **96.88%** | **76.96%** |
| Major    |     39.64% |      3.57% |  **6.56%** |
| Fatal    | **99.83%** | **98.82%** | **99.32%** |

### Key Result

**Fatal accidents achieved an F1-score of 99.32%.**

The major-accident category remains the main classification challenge.

---

# 🧠 Main Findings

| Analysis             | Finding                                   |
| -------------------- | ----------------------------------------- |
| City                 | Chandigarh had the highest accident count |
| Severity             | Minor accidents were most common          |
| Weather              | Fog had the highest average risk          |
| Traffic              | High traffic had the highest average risk |
| Combined Risk        | Fog + High Traffic + Fatal = **0.919**    |
| Hotspot              | Highest hotspot ≈ **636 accidents**       |
| Random Forest        | **68.45% accuracy**                       |
| Logistic Regression  | **68.45% accuracy**                       |
| Fatal Classification | **99.32% F1-score**                       |
| Minor Classification | **96.88% recall**                         |
| Major Classification | **6.56% F1-score**                        |

---

# 📊 Visualizations

The project includes visualizations for:

* City-wise accidents
* Year-wise accidents
* Hour-wise accidents
* Accident severity
* Weather conditions
* Traffic density
* Risk levels
* Weather risk
* Weather + traffic risk
* Accident causes
* Traffic hotspots
* Vehicle and casualty analysis
* Model accuracy
* Confusion matrices
* Feature importance
* Random Forest error rate

---

# 🖥️ Smart Traffic Dashboard

The Smart Traffic dashboard combines the major project findings:

* Accident statistics
* Severity analysis
* Weather risk
* Traffic risk
* Accident causes
* Risk analysis
* Hotspots
* Machine-learning results

---

# 📄 Reports

## 🌐 HTML Report

```text
final_report.html
```

Interactive HTML report containing the complete analysis and visualizations.

## 📑 PDF Report

```text
final_report.pdf
```

Printable PDF version of the project report.

---

# 📁 Project Structure

```text
Smart-Traffic-Accident-Visualization/
│
├── README.md
│
├── data/
│
├── R/
│
├── images/
│
├── results/
│
├── outputs/
│
├── final_report.html
│
└── final_report.pdf
```

---

# ⚠️ Limitations

* Historical accident data is used
* No live traffic data
* No live weather data
* No live accident feed
* Major accident classification has low recall
* No production deployment yet
* Current system is primarily an analytical platform

---

# 🚀 Smart Traffic 2.0

Future development can transform Smart Traffic 1.0 into a real-time intelligent traffic-safety system.

### Planned Features

* 🌦️ Real-time weather integration
* 🚗 Real-time traffic data
* 🗺️ Interactive accident-risk maps
* 🤖 Real-time risk prediction
* 🚨 Automated safety alerts
* 📊 Live dashboard
* 🌐 Web application
* ☁️ Cloud deployment

---

# 🛣️ Roadmap

```text
SMART TRAFFIC 1.0
       ↓
Historical Accident Analysis
       ↓
Risk Assessment
       ↓
Machine Learning
       ↓
Visualization & Dashboard
       ↓
HTML + PDF Reports
       ↓
SMART TRAFFIC 2.0
       ↓
Real-Time Weather
       +
Real-Time Traffic
       ↓
Live Risk Prediction
       ↓
Interactive Risk Map
       ↓
Smart Alerts
       ↓
Live Dashboard
       ↓
Web Application
       ↓
Cloud Deployment
```

---

# 👩‍💻 Author

### Harshitha

GitHub:

[https://github.com/vemalaharshitha](https://github.com/vemalaharshitha)

Repository:

[https://github.com/vemalaharshitha/Smart-Traffic-Accident-Visualization](https://github.com/vemalaharshitha/Smart-Traffic-Accident-Visualization)

---

# 📜 License

This project is intended for:

* Educational purposes
* Academic submission
* Research
* Data science portfolio
* Machine learning demonstration

---

# ⭐ Conclusion

**Smart Accident Visualization 1.0** demonstrates a complete data science workflow from accident data preparation and exploratory analysis to risk assessment, visualization, machine learning and decision support.

The project identifies important relationships between **location, time, weather, traffic density, accident causes, severity, vehicles, casualties and accident risk**.

The strongest identified risk condition was:

> 🚨 **Fog + High Traffic + Fatal Severity → Average Risk 0.919**

The machine-learning models achieved **68.45% accuracy**, with Random Forest achieving a **99.32% F1-score for fatal accidents**.

The project provides the foundation for **Smart Traffic 2.0**, with future capabilities including real-time traffic, weather integration, live risk prediction, interactive maps and automated safety alerts.

---

# 🚦 Smart Accident Visualization

### Analyze → Understand → Predict → Improve

**Smart Traffic 1.0 → Smart Traffic 2.0 → Smarter & Safer Roads**

```

**This is the one to use.** Replace the contents of your current `README.md` with this, save it, then commit it to GitHub.
```
