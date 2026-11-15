# APPENDIX A — Reproducibility and Technical Execution Guide

This document specifies the exact environment, dependencies, and command sequence required to replicate the **SMART TRAFFIC** platform and its experimental findings.

---

## 1. Hardware and Operating System Specifications

- **Operating System:** Microsoft Windows 11 64-bit (Build 26100+)
- **Processor:** Intel Core i7 / AMD Ryzen 7 (x86_64 architecture)
- **System Memory (RAM):** 16.0 GB or higher
- **Graphics Processing Unit (GPU):** NVIDIA GeForce RTX GPU with CUDA 12.x or CPU execution mode
- **Storage:** Minimum 5.0 GB available SSD space for models, video feeds, and generated output CSVs

---

## 2. Software Runtime and Library Versions

### A. R Statistical Computing Environment
- **R Engine:** Version 4.5.1 (2025-06-13)
- **R Packages:**
  - `shiny` (v1.14.0) — Reactive web application framework
  - `leaflet` (v2.2.3) — Geospatial OpenStreetMap mapping
  - `plotly` (v4.12.1) — WebGL and SVG interactive charting
  - `ggplot2` (v4.0.3) — Grammatical statistical plotting
  - `dplyr` (v1.2.1) — Tabular data wrangling and pipelines
  - `htmlwidgets` (v1.6.4) — JavaScript widget bindings
  - `randomForest` (v4.7-1.2) — Ensemble classification modeling
  - `nnet` (v7.3-20) — Multinomial logistic regression

### B. Python Deep Learning Environment
- **Python Runtime:** Version 3.13.14 64-bit
- **Python Libraries:**
  - `ultralytics` (v8.4.132) — YOLO11n neural network execution
  - `torch` (v2.13.0) & `torchvision` (v0.28.0) — Tensor calculation backend
  - `opencv-python` (v5.0.0.93) — Video frame decoding and visualization
  - `pandas` (v3.0.5) & `numpy` (v2.5.2) — Tabular data handling
  - `playwright` (v1.64.0) — Automated browser verification and screenshot capture

---

## 3. Step-by-Step Launch Instructions

### Step 1: Launch the Interactive R Shiny Dashboard
Open a terminal in the project root directory and execute:
```powershell
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" -e "shiny::runApp('smart-traffic-2.0/dashboard', port=7878, launch.browser=TRUE)"
```
The dashboard will open automatically in your default web browser at `http://127.0.0.1:7878`.

### Step 2: Run the YOLO11n Video AI Perception Pipeline
To re-process the urban traffic surveillance video:
```powershell
python smart-traffic-2.0\Python\smart_traffic_v2.py
```
This reads `data/Traffic_Video.mp4`, applies YOLO11n vehicle detection with ByteTrack tracking, and generates `outputs/smart_traffic_output_v2.mp4` and `outputs/traffic_results_v2.csv`.

### Step 3: Run Historical Statistical & Machine Learning Scripts
To replicate the tabular data preprocessing and modeling:
```powershell
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/02_Data_Preprocessing.R
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/03_Feature_Engineering.R
& "C:\Program Files\R\R-4.5.1\bin\Rscript.exe" R/08_severity_casualty_analysis.R
```
