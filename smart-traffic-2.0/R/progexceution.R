library(av)
video_info <- av_media_info(video_path)

video_info

frames_dir <- file.path(project_dir, "outputs", "frames")

dir.create(frames_dir, recursive = TRUE, showWarnings = FALSE)

av_video_images(
  video_path,
  destdir = frames_dir,
  fps = 2,
  format = "jpg"
)

list.files(frames_dir, full.names = TRUE)

list.files(frames_dir, full.names = TRUE)[1]

test_frame <- file.path(
  project_dir,
  "outputs",
  "frames",
  "image_000001.jpg"
)

file.exists(test_frame)

yolo_test <- paste0(
  "python -c \"from ultralytics import YOLO; ",
  "model=YOLO('yolo11n.pt'); ",
  "model.predict('", test_frame, "', save=True, conf=0.4)\""
)

system(yolo_test)


yolo_script <- file.path(project_dir, "R", "vehicle_detection.py")

writeLines(c(
  "from ultralytics import YOLO",
  "import glob",
  "import csv",
  "import os",
  "",
  "model = YOLO('yolo11n.pt')",
  "",
  "frames = sorted(glob.glob('outputs/frames/*.jpg'))",
  "output_file = 'outputs/vehicle_counts.csv'",
  "",
  "os.makedirs('outputs', exist_ok=True)",
  "",
  "vehicle_classes = {'car', 'motorcycle', 'bus', 'truck'}",
  "",
  "with open(output_file, 'w', newline='') as f:",
  "    writer = csv.writer(f)",
  "    writer.writerow(['frame', 'cars', 'motorcycles', 'buses', 'trucks', 'total_vehicles'])",
  "",
  "    for frame in frames:",
  "        results = model.predict(frame, conf=0.4, verbose=False)",
  "",
  "        counts = {'car': 0, 'motorcycle': 0, 'bus': 0, 'truck': 0}",
  "",
  "        for result in results:",
  "            for box in result.boxes:",
  "                class_id = int(box.cls[0])",
  "                class_name = model.names[class_id]",
  "",
  "                if class_name in vehicle_classes:",
  "                    counts[class_name] += 1",
  "",
  "        total = sum(counts.values())",
  "",
  "        writer.writerow([",
  "            os.path.basename(frame),",
  "            counts['car'],",
  "            counts['motorcycle'],",
  "            counts['bus'],",
  "            counts['truck'],",
  "            total",
  "        ])",
  "",
  "print('Vehicle detection completed successfully!')",
  "print('Results saved to:', output_file)"
), yolo_script)

system2(
  "python",
  args = shQuote(yolo_script)
)
