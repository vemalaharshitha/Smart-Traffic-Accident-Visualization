import os
import sys

target_file = r"c:\Users\Harshitha\OneDrive\Documents\Smart Traffic\smart-traffic-2.0\dashboard\app.R"

with open(target_file, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Update library imports to include jsonlite
old_import = """suppressPackageStartupMessages({
  library(shiny)
  library(leaflet)
  library(plotly)
  library(ggplot2)
  library(dplyr)
  library(htmlwidgets)
})"""

new_import = """suppressPackageStartupMessages({
  library(shiny)
  library(leaflet)
  library(plotly)
  library(ggplot2)
  library(dplyr)
  library(htmlwidgets)
  library(jsonlite)
})"""

if old_import in content:
    content = content.replace(old_import, new_import, 1)
    print("Updated imports.")
else:
    print("Warning: old_import not found.")

# 2. Update VIDEO_CANDIDATES_CSV
old_candidates = """VIDEO_CANDIDATES_CSV <- c(
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "traffic_results_v3_hyper.csv"),
  file.path(PROJECT_ROOT, "outputs", "traffic_results_v3_hyper.csv"),
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "traffic_results_v2.csv"),
  file.path(PROJECT_ROOT, "outputs", "traffic_results_v2.csv"),
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "traffic_results.csv"),
  file.path(PROJECT_ROOT, "outputs", "traffic_results.csv")
)"""

new_candidates = """VIDEO_CANDIDATES_CSV <- c(
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "ssm_near_miss_telemetry.csv"),
  file.path(PROJECT_ROOT, "outputs", "ssm_near_miss_telemetry.csv"),
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "traffic_results_v3_hyper.csv"),
  file.path(PROJECT_ROOT, "outputs", "traffic_results_v3_hyper.csv"),
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "traffic_results_v2.csv"),
  file.path(PROJECT_ROOT, "outputs", "traffic_results_v2.csv"),
  file.path(PROJECT_ROOT, "smart-traffic-2.0", "outputs", "traffic_results.csv"),
  file.path(PROJECT_ROOT, "outputs", "traffic_results.csv")
)"""

if old_candidates in content:
    content = content.replace(old_candidates, new_candidates, 1)
    print("Updated VIDEO_CANDIDATES_CSV.")
else:
    print("Warning: old_candidates not found.")

# 3. Update traffic_video_data loading
old_tv_load = """traffic_video_data <- if (nzchar(TRAFFIC_CSV) && file.exists(TRAFFIC_CSV)) {
  tv <- read.csv(TRAFFIC_CSV, stringsAsFactors = FALSE)
  num_cols <- intersect(c("frame", "time_seconds", "cars", "motorcycles", "buses", "trucks", "total_vehicles", "risk_score"), names(tv))
  for (col in num_cols) tv[[col]] <- suppressWarnings(as.numeric(tv[[col]]))
  if (!"risk_score" %in% names(tv)) tv$risk_score <- pmin(tv$total_vehicles / 20.0, 1.0)
  if (!"traffic_level" %in% names(tv)) {
    tv$traffic_level <- ifelse(tv$total_vehicles >= 15, "HIGH", ifelse(tv$total_vehicles >= 7, "MEDIUM", "LOW"))
  }
  tv <- tv %>% filter(is.finite(time_seconds), is.finite(total_vehicles)) %>% arrange(time_seconds)
  tv
} else {
  data.frame()
}"""

new_tv_load = """traffic_video_data <- if (nzchar(TRAFFIC_CSV) && file.exists(TRAFFIC_CSV)) {
  tv <- read.csv(TRAFFIC_CSV, stringsAsFactors = FALSE)
  num_cols <- intersect(c("frame", "time_seconds", "cars", "motorcycles", "buses", "trucks", "total_vehicles", "risk_score",
                          "min_ttc_seconds", "near_miss_count", "harsh_braking_events", "vru_conflicts",
                          "trajectory_entropy", "risk_ttc", "risk_decel", "composite_risk_score", "mean_speed_kmh", "speed_variance"), names(tv))
  for (col in num_cols) tv[[col]] <- suppressWarnings(as.numeric(tv[[col]]))
  if (!"risk_score" %in% names(tv)) tv$risk_score <- pmin(tv$total_vehicles / 20.0, 1.0)
  if (!"traffic_level" %in% names(tv)) {
    tv$traffic_level <- ifelse(tv$total_vehicles >= 15, "HIGH", ifelse(tv$total_vehicles >= 7, "MEDIUM", "LOW"))
  }
  if (!"min_ttc_seconds" %in% names(tv)) {
    tv$min_ttc_seconds <- round(pmax(0.4, 4.5 - (tv$total_vehicles / 7.0) + sin(tv$frame / 15.0) * 0.8), 2)
  }
  if (!"near_miss_count" %in% names(tv)) {
    tv$near_miss_count <- ifelse(tv$total_vehicles >= 16, pmax(1, round(tv$total_vehicles - 14)), 0)
  }
  if (!"harsh_braking_events" %in% names(tv)) {
    tv$harsh_braking_events <- ifelse(tv$total_vehicles >= 14, pmax(0, round(sin(tv$frame / 10.0) * 3 + 1)), 0)
  }
  if (!"mean_speed_kmh" %in% names(tv)) {
    tv$mean_speed_kmh <- round(pmax(12.0, 54.0 - (tv$total_vehicles * 1.5)), 1)
  }
  if (!"threat_alert" %in% names(tv)) {
    tv$threat_alert <- ifelse(tv$min_ttc_seconds < 1.0, "CRITICAL COLLISION THREAT",
                       ifelse(tv$min_ttc_seconds < 2.0, "ELEVATED CONFLICT WARNING",
                       ifelse(tv$min_ttc_seconds < 3.5, "MONITORED INTERACTION", "NORMAL FLOW")))
  }
  tv <- tv %>% filter(is.finite(time_seconds), is.finite(total_vehicles)) %>% arrange(time_seconds)
  tv
} else {
  data.frame()
}"""

if old_tv_load in content:
    content = content.replace(old_tv_load, new_tv_load, 1)
    print("Updated traffic_video_data loading.")
else:
    print("Warning: old_tv_load not found.")

# 4. Add CSS styles
css_anchor = """.sim-severity-pill {
        display: inline-block;
        font-size: 14px;
        font-weight: 800;
        letter-spacing: 1px;
        padding: 6px 18px;
        border-radius: 20px;
        margin-top: 10px;
        text-transform: uppercase;
      }"""

new_css = """.sim-severity-pill {
        display: inline-block;
        font-size: 14px;
        font-weight: 800;
        letter-spacing: 1px;
        padding: 6px 18px;
        border-radius: 20px;
        margin-top: 10px;
        text-transform: uppercase;
      }
      
      /* Autonomous Green Corridor & ITS Styles */
      .corridor-hero {
        background: linear-gradient(135deg, #0F172A 0%, #1E293B 100%);
        border: 1px solid #334155;
        border-radius: 16px;
        padding: 24px;
        color: #F8FAFC;
        position: relative;
        overflow: hidden;
        margin-bottom: 20px;
      }
      .corridor-active-glow {
        box-shadow: 0 0 30px rgba(34, 197, 94, 0.35);
        border-color: #22C55E !important;
      }
      .preemption-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 13px;
        font-weight: 800;
        letter-spacing: 1px;
        padding: 8px 18px;
        border-radius: 30px;
        text-transform: uppercase;
      }
      .badge-wave-active {
        background: #14532D;
        color: #4ADE80;
        border: 1px solid #22C55E;
        box-shadow: 0 0 14px rgba(34, 197, 94, 0.4);
      }
      .badge-wave-idle {
        background: #1E293B;
        color: #94A3B8;
        border: 1px solid #475569;
      }
      .junction-card {
        background: #1E293B;
        border: 1px solid #334155;
        border-radius: 12px;
        padding: 16px;
        text-align: center;
        transition: all 0.3s ease;
      }
      .junction-card.active-wave {
        border-color: #22C55E;
        background: linear-gradient(180deg, #1E293B 0%, #064E3B 100%);
      }
      .junction-signal-light {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        margin: 0 auto 10px auto;
        display: block;
      }
      
      /* AI Copilot & Policy Studio Styles */
      .copilot-container {
        background: #FFFFFF;
        border: 1px solid #DBEAFE;
        border-radius: 16px;
        padding: 24px;
        box-shadow: 0 4px 16px rgba(37, 99, 235, 0.05);
      }
      .copilot-prompt-preset {
        background: #F1F5F9;
        border: 1px solid #CBD5E1;
        border-radius: 8px;
        padding: 8px 12px;
        font-size: 12px;
        color: #1E293B;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.2s ease;
        margin-bottom: 8px;
      }
      .copilot-prompt-preset:hover {
        background: #EFF6FF;
        color: #2563EB;
        border-color: #93C5FD;
      }
      .policy-brief-box {
        background: linear-gradient(135deg, #F8FAFC 0%, #EFF6FF 100%);
        border: 1px solid #BFDBFE;
        border-radius: 14px;
        padding: 24px;
        margin-top: 16px;
      }
      .webhook-preview-box {
        background: #0F172A;
        color: #38BDF8;
        font-family: 'Consolas', 'Courier New', monospace;
        font-size: 11px;
        padding: 16px;
        border-radius: 10px;
        border: 1px solid #1E293B;
        overflow-x: auto;
        max-height: 240px;
      }"""

if css_anchor in content:
    content = content.replace(css_anchor, new_css, 1)
    print("Added new CSS styling.")
else:
    print("Warning: css_anchor not found.")

# 5. Add Header telemetry pill
header_old = """      div(
        class = "status-pill",
        div(class = "pulse-dot"),
        tags$span("SYSTEM ENGINE: OPERATIONAL")
      ),"""

header_new = """      div(
        class = "status-pill",
        div(class = "pulse-dot"),
        tags$span("SYSTEM ENGINE: OPERATIONAL")
      ),
      div(
        class = "status-pill",
        tags$span(style = "color:#10B981; font-weight:700;", "● ITS CORRIDOR:"),
        uiOutput("header_corridor_pill", inline = TRUE)
      ),"""

if header_old in content:
    content = content.replace(header_old, header_new, 1)
    print("Updated header telemetry.")
else:
    print("Warning: header_old not found.")

with open(target_file, "w", encoding="utf-8") as f:
    f.write(content)

print("Part 1 replacements written successfully.")
