demo_script <- file.path(
  project_dir,
  "R",
  "smart_traffic_demo.py"
)

writeLines(c(
"from ultralytics import YOLO",
"import cv2",
"",
"VIDEO = r'C:\\Users\\Harshitha\\OneDrive\\Documents\\Smart Traffic\\smart-traffic-2.0\\data\\Traffic_Video.mp4'",
"",
"model = YOLO('yolo11n.pt')",
"cap = cv2.VideoCapture(VIDEO)",
"",
"if not cap.isOpened():",
"    raise RuntimeError('Could not open Traffic_Video.mp4')",
"",
"while True:",
"    ret, frame = cap.read()",
"",
"    if not ret:",
"        break",
"",
"    results = model(frame, conf=0.4, verbose=False)",
"    annotated = results[0].plot()",
"",
"    counts = {'car': 0, 'motorcycle': 0, 'bus': 0, 'truck': 0}",
"",
"    for box in results[0].boxes:",
"        name = model.names[int(box.cls[0])]",
"        if name in counts:",
"            counts[name] += 1",
"",
"    total = sum(counts.values())",
"",
"    if total >= 15:",
"        traffic = 'HIGH'",
"        risk = 'HIGH RISK'",
"    elif total >= 7:",
"        traffic = 'MEDIUM'",
"        risk = 'MEDIUM RISK'",
"    else:",
"        traffic = 'LOW'",
"        risk = 'LOW RISK'",
"",
"    cv2.rectangle(annotated, (20, 20), (520, 155), (0, 0, 0), -1)",
"",
"    cv2.putText(annotated, f'VEHICLES: {total}', (40, 55),",
"                cv2.FONT_HERSHEY_SIMPLEX, 0.9, (255,255,255), 2)",
"",
"    cv2.putText(annotated, f'Cars: {counts[\"car\"]}  Bikes: {counts[\"motorcycle\"]}',",
"                (40, 85), cv2.FONT_HERSHEY_SIMPLEX, 0.65, (255,255,255), 2)",
"",
"    cv2.putText(annotated, f'Buses: {counts[\"bus\"]}  Trucks: {counts[\"truck\"]}',",
"                (40, 112), cv2.FONT_HERSHEY_SIMPLEX, 0.65, (255,255,255), 2)",
"",
"    cv2.putText(annotated, f'Traffic: {traffic} | {risk}',",
"                (40, 142), cv2.FONT_HERSHEY_SIMPLEX, 0.65, (255,255,255), 2)",
"",
"    cv2.imshow('Smart Traffic 2.0 - Real-Time Demo', annotated)",
"",
"    if cv2.waitKey(1) & 0xFF == ord('q'):",
"        break",
"",
"cap.release()",
"cv2.destroyAllWindows()"
), demo_script)

file.exists(demo_script)

system("python -m pip install opencv-python")

system2(
  "python",
  args = shQuote(demo_script)
)

system("python -m pip install opencv-python")
