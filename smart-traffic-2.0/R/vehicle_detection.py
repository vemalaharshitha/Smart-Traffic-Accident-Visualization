from ultralytics import YOLO
import glob
import csv
import os

model = YOLO('yolo11n.pt')

frames = sorted(glob.glob('outputs/frames/*.jpg'))
output_file = 'outputs/vehicle_counts.csv'

os.makedirs('outputs', exist_ok=True)

vehicle_classes = {'car', 'motorcycle', 'bus', 'truck'}

with open(output_file, 'w', newline='') as f:
    writer = csv.writer(f)
    writer.writerow(['frame', 'cars', 'motorcycles', 'buses', 'trucks', 'total_vehicles'])

    for frame in frames:
        results = model.predict(frame, conf=0.4, verbose=False)

        counts = {'car': 0, 'motorcycle': 0, 'bus': 0, 'truck': 0}

        for result in results:
            for box in result.boxes:
                class_id = int(box.cls[0])
                class_name = model.names[class_id]

                if class_name in vehicle_classes:
                    counts[class_name] += 1

        total = sum(counts.values())

        writer.writerow([
            os.path.basename(frame),
            counts['car'],
            counts['motorcycle'],
            counts['bus'],
            counts['truck'],
            total
        ])

print('Vehicle detection completed successfully!')
print('Results saved to:', output_file)
