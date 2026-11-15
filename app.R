# ==============================================================================
# SMART TRAFFIC — ROOT LAUNCHER
# Allows running shiny::runApp(".") directly from the project root directory
# ==============================================================================

dashboard_file <- file.path(getwd(), "smart-traffic-2.0", "dashboard", "app.R")
if (!file.exists(dashboard_file)) {
  dashboard_file <- file.path("C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/smart-traffic-2.0/dashboard/app.R")
}

res <- source(dashboard_file, local = FALSE)
res$value
