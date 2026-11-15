# SMART TRAFFIC — Figure and Screenshot Inventory

This document provides a comprehensive inventory of all architectural diagrams, data graphs, and authentic application screenshots generated and inserted across the **SMART TRAFFIC** IEEE research paper and academic project report.

---

## 1. System Architecture & Workflow Diagrams (`figures/` & `diagram_sources/`)

| Figure ID | File Name | Diagram Type | Source File / Tool | Formal Caption | Document Sections |
|:---|:---|:---|:---|:---|:---|
| **Fig. 1** | `fig01_overall_system_architecture.png` | System Topology | Matplotlib + Mermaid (`fig01_overall_system_architecture.mmd`) | High-level system architecture of the SMART TRAFFIC platform illustrating data flow across acquisition, perception, statistical modeling, and operational delivery tiers. | IEEE Paper Sec. III; Report Chapter 4 & 6 |
| **Fig. 2** | `fig02_project_workflow_flowchart.png` | Flowchart | Matplotlib + Mermaid (`fig02_project_workflow_flowchart.mmd`) | End-to-end operational workflow flowchart showing data ingestion, feature engineering, YOLO11n tracking, model evaluation, and multi-user decision-support interaction. | IEEE Paper Sec. III; Report Chapter 6 |
| **Fig. 3** | `fig03_data_processing_pipeline.png` | Data Pipeline | Matplotlib + Mermaid (`fig03_data_processing_pipeline.mmd`) | Systematic data preprocessing and feature transformation pipeline covering validation, factor encoding, temporal extraction, risk scoring, and stratified partitioning. | IEEE Paper Sec. IV; Report Chapter 7 |
| **Fig. 4** | `fig04_vehicle_detection_workflow.png` | Vision Workflow | Matplotlib + Mermaid (`fig04_vehicle_detection_workflow.mmd`) | Computer vision vehicle detection and tracking workflow utilizing Ultralytics YOLO11n, ByteTrack association, modal counting, congestion scoring, and telemetry export. | IEEE Paper Sec. V; Report Chapter 8 |
| **Fig. 5** | `fig05_accident_analytics_workflow.png` | Modeling Pipeline | Matplotlib + Mermaid (`fig05_accident_analytics_workflow.mmd`) | Accident analytics and machine learning pipeline illustrating data partitioning, model training, evaluation, and operational integration. | IEEE Paper Sec. VII; Report Chapter 9 |
| **Fig. 6** | `fig06_dashboard_architecture.png` | Topology | Matplotlib + Mermaid (`fig06_dashboard_architecture.mmd`) | Architectural topology of the R Shiny dashboard platform connecting UI components with reactive server pipelines and data stores. | IEEE Paper Sec. VIII; Report Chapter 6 & 10 |
| **Fig. 7** | `fig07_use_case_diagram.png` | UML Use-Case | Matplotlib + Mermaid (`fig07_use_case_diagram.mmd`) | UML system use-case diagram illustrating operational stakeholder interactions across traffic monitoring, planning, and data science domains. | Report Chapter 6 |
| **Fig. 8** | `fig08_data_flow_diagram.png` | DFD Level 1 | Matplotlib + Mermaid (`fig08_data_flow_diagram.mmd`) | Data-Flow Diagram (Level 1) illustrating input entities, primary computational processes, data stores, and information flow. | Report Chapter 6 |
| **Fig. 9** | `fig09_data_schema_diagram.png` | Relational Schema | Matplotlib + Mermaid (`fig09_data_schema_diagram.mmd`) | Comprehensive relational entity-attribute schema diagram covering macro historical crash records and micro video surveillance telemetry. | Report Chapter 6 |
| **Fig. 10** | `fig10_model_evaluation_diagram.png` | Evaluation Chart | Matplotlib (`scratch/generate_academic_visuals.py`) | Model evaluation summary: (Left) Random Forest test confusion matrix; (Right) Per-class Precision, Recall, and F1-score across 4,000 test records. | IEEE Paper Sec. VII; Report Chapter 11 |

---

## 2. Real Data Analytical Graphs (`figures/`)

| Graph ID | File Name | Chart Type | Underlying Source Dataset | Formal Caption | Document Sections |
|:---|:---|:---|:---|:---|:---|
| **Graph 1** | `graph01_severity_distribution.png` | Bar Chart | `data/indian_roads_dataset.csv` | Accident severity distribution across the 20,000 historical records (Minor: 11,025, Major: 5,988, Fatal: 2,987). | IEEE Paper Sec. VI; Report Chapter 11 |
| **Graph 2** | `graph02_accidents_by_city.png` | Horizontal Bar | `data/indian_roads_dataset.csv` | Incident volume across 8 Indian metropolitan jurisdictions showing balanced regional representation. | IEEE Paper Sec. VI; Report Chapter 11 |
| **Graph 3** | `graph03_weather_risk_comparison.png` | Bar Chart | `data/indian_roads_dataset.csv` | Average accident risk score by atmospheric weather state showing elevated risk during fog and rain. | Report Chapter 11 |
| **Graph 4** | `graph04_traffic_density_risk.png` | Bar Chart | `data/indian_roads_dataset.csv` | Average accident risk score by traffic flow density showing higher hazard rates during high congestion. | Report Chapter 11 |
| **Graph 5** | `graph05_risk_weather_traffic_interaction.png` | Heatmap Matrix | `data/indian_roads_dataset.csv` | Cross-domain risk interaction matrix: Atmospheric Weather State vs Pre-Crash Traffic Density (Peak: 0.919 for Fog × High × Fatal). | IEEE Paper Sec. VI; Report Chapter 11 |
| **Graph 6** | `graph06_hourly_accident_patterns.png` | Line & Area | `data/indian_roads_dataset.csv` | Diurnal accident distribution across the 24-hour cycle highlighting morning (8-11 AM) and evening (5-8 PM) peak windows. | IEEE Paper Sec. VI; Report Chapter 11 |
| **Graph 7** | `graph07_day_of_week_distribution.png` | Bar Chart | `data/indian_roads_dataset.csv` | Accident frequency by day of week (weekday vs weekend comparative volume). | Report Chapter 11 |
| **Graph 8** | `graph11_feature_importance_rf.png` | Horizontal Bar | `results/feature_importance.csv` | Random Forest feature importance ranking quantified by Mean Decrease in Gini Impurity across all engineered and raw predictors. | IEEE Paper Sec. VII; Report Chapter 9 |
| **Graph 9** | `graph12_video_vehicle_category_distribution.png` | Bar Chart | `smart-traffic-2.0/outputs/traffic_results_v2.csv` | Mean concurrent vehicle distribution across 901 video frames categorized by COCO class (57.8% motorcycles, 30.5% cars, 11.7% trucks). | IEEE Paper Sec. V; Report Chapter 8 & 11 |
| **Graph 10** | `graph13_traffic_volume_timeseries.png` | Time Series | `smart-traffic-2.0/outputs/traffic_results_v2.csv` | Real-time vehicle flow telemetry across 15-second surveillance window showing total vehicles against the congestion threshold. | IEEE Paper Sec. V; Report Chapter 8 & 11 |
| **Graph 11** | `graph15_geographic_hotspot_clusters.png` | Geospatial Scatter | `data/indian_roads_dataset.csv` | Geospatial distribution of 20,000 verified accident coordinates across Indian metropolitan hubs colored by severity. | IEEE Paper Sec. VI; Report Chapter 11 |

---

## 3. Authentic Application Screenshots & Video Frames (`screenshots/`)

| Screenshot ID | File Name | Capture View / Provenance | Resolution | Formal Caption | Document Sections |
|:---|:---|:---|:---|:---|:---|
| **Shot 1** | `screenshot01_executive_overview.png` | Live R Shiny Browser (`deck` tab) | 1920 × 1080 | Actual dashboard screenshot: Executive Overview tab showing live KPI telemetry cards and multi-domain mobility plots. | IEEE Paper Sec. VIII; Report Chapter 10 |
| **Shot 2** | `screenshot02_kpi_telemetry_cards.png` | Live R Shiny Browser (KPI card crop) | 1920 × 1080 | Actual dashboard screenshot: Macro KPI telemetry card cluster displaying total incidents, processed frames, peak risk, and fatal recall. | Report Chapter 10 |
| **Shot 3** | `screenshot03_geographic_accident_map.png` | Live R Shiny Browser (`geo_map` tab) | 1920 × 1080 | Actual dashboard screenshot: Geographic Accident Map tab rendering interactive Leaflet OpenStreetMap tiles, cluster markers, and multi-attribute filters. | IEEE Paper Sec. VIII; Report Chapter 10 |
| **Shot 4** | `screenshot05_video_intelligence_studio.png`| Live R Shiny Browser (`video_studio` tab)| 1920 × 1080 | Actual dashboard screenshot: Video Intelligence & Signal Optimizer tab showing CCTV playback, live telemetry counters, and adaptive signal phase controls. | Report Chapter 10 |
| **Shot 5** | `screenshot07_deep_traffic_analytics.png` | Live R Shiny Browser (`deep_analytics` tab)| 1920 × 1080 | Actual dashboard screenshot: Deep Traffic Analytics tab showing multi-variable crash distributions and hourly patterns. | Report Chapter 10 |
| **Shot 6** | `screenshot08_temporal_accident_patterns.png` | Live R Shiny Browser (Hourly Plotly) | 1920 × 1080 | Actual dashboard screenshot: Diurnal hourly crash volume and weekday vs weekend comparison plots. | Report Chapter 10 |
| **Shot 7** | `screenshot09_ml_risk_intelligence_studio.png`| Live R Shiny Browser (`ml_models` tab) | 1920 × 1080 | Actual dashboard screenshot: ML & Risk Intelligence Studio featuring model performance metrics, confusion matrix, and What-If simulator HUD. | Report Chapter 10 |
| **Shot 8** | `screenshot11_data_explorer_table.png` | Live R Shiny Browser (`data_explorer` tab)| 1920 × 1080 | Actual dashboard screenshot: Incident Data Explorer tab featuring paginated cyber-table with severity badges and CSV streaming. | Report Chapter 10 |
| **Shot 9** | `screenshot12_official_city_briefing_modal.png` | Live R Shiny Browser (Modal dialog) | 1920 × 1080 | Actual dashboard screenshot: Official Municipal Briefing Report modal dialog summarizing key accident statistics. | Report Chapter 10 |
| **Shot 10** | `screenshot13_annotated_yolo_tracking_frame.png`| OpenCV Extraction (Frame 60 of output MP4) | 1920 × 1080 | Actual video frame: Annotated YOLO11n detection bounding boxes and ByteTrack persistent tracklet IDs from smart_traffic_output_v2.mp4. | IEEE Paper Sec. V; Report Chapter 8 |
| **Shot 11** | `screenshot14_annotated_yolo_telemetry_hud.png` | OpenCV Extraction (Frame 300 of output MP4)| 1920 × 1080 | Actual video frame: Annotated CCTV frame highlighting multi-class vehicle bounding boxes and live flow telemetry HUD overlay. | Report Chapter 8 |
