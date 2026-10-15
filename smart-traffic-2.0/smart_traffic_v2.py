
setwd("C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/smart-traffic-2.0")

cat("Python version:\n")
system2("py", c("-3.13", "--version"))

cat("\nRequired libraries:\n")
system2(
  "py",
  c("-3.13", "-c",
    shQuote("import cv2, torch; from ultralytics import YOLO; print('OpenCV:', cv2.__version__); print('PyTorch:', torch.__version__); print('CUDA available:', torch.cuda.is_available())")
  )
)

cat("\nBackup verification:\n")
print(file.info(file.path(
  "outputs", "backup_before_fix",
  c("smart_traffic.py", "traffic_results.csv", "smart_traffic_output.mp4")
))[, "size", drop = FALSE])
