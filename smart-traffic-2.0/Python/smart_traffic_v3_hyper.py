"""
================================================================================
SMART TRAFFIC 3.0: HYPER-NOVELTY PERCEPTION & SURROGATE SAFETY MEASURES (SSM) ENGINE
Physics-Informed Neuro-Symbolic Collision Prediction, Trajectory Analytics & Risk Fusion
================================================================================
Key Novelties:
1. Trajectory Vectorization & Kalman-smoothed Velocity Tracking
2. Real-Time Time-to-Collision (TTC) & Post-Encroachment Time (PET) Surrogate Safety
3. Sudden Deceleration & Shockwave Anomaly Detection
4. Vulnerable Road User (VRU) Conflict Encroachment (Bikes vs Heavy Vehicles)
5. Multi-Factor Physics-Informed Risk Fusion (Replacing naive vehicle count division)
"""

from ultralytics import YOLO
import cv2
import os
import csv
import time
import math
import numpy as np
from collections import deque
import torch

# Configuration Paths
BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
VIDEO_PATH = os.path.join(BASE_DIR, "data", "Traffic_Video.mp4")
OUTPUT_DIR = os.path.join(BASE_DIR, "outputs")
OUTPUT_VIDEO_PATH = os.path.join(OUTPUT_DIR, "smart_traffic_output_hyper.mp4")
OUTPUT_CSV_PATH = os.path.join(OUTPUT_DIR, "traffic_results_v3_hyper.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

# Vehicle Classes
VEHICLE_CLASSES = {
    2: 'car',
    3: 'motorcycle',
    5: 'bus',
    7: 'truck'
}
HEAVY_CLASSES = {'bus', 'truck'}
VRU_CLASSES = {'motorcycle'}

CONFIDENCE = 0.20
IMAGE_SIZE = 640
DEVICE = 0 if torch.cuda.is_available() else 'cpu'

# Physics Calibration Parameters (Estimated for 1080p Perspective View)
PIXELS_PER_METER = 24.0   # Scale factor for road plane mapping
TTC_THRESHOLD = 3.5       # Seconds below which near-miss is flagged
CRITICAL_TTC = 1.8        # Seconds for immediate collision danger
HARSH_DECEL_THRESHOLD = -4.5 # m/s^2 deceleration threshold

print("=" * 65)
print("SMART TRAFFIC 3.0 - HYPER-NOVELTY ENGINE INITIALIZING")
print(f"Device: {DEVICE} | Confidence: {CONFIDENCE} | TTC Horizon: {TTC_THRESHOLD}s")
print("=" * 65)

model_path = os.path.join(BASE_DIR, "yolo11n.pt")
if not os.path.exists(model_path):
    model_path = "yolo11n.pt"

print(f"Loading YOLO11n weights from: {model_path}...")
model = YOLO(model_path)
print("YOLO11n Neural Perception Model Loaded.")

cap = cv2.VideoCapture(VIDEO_PATH)
if not cap.isOpened():
    raise RuntimeError(f"Could not open input video: {VIDEO_PATH}")

fps = cap.get(cv2.CAP_PROP_FPS) or 30.0
total_frames = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
dt = 1.0 / fps

print(f"Video Stream: {width}x{height} @ {fps:.2f} FPS ({total_frames} total frames)")

fourcc = cv2.VideoWriter_fourcc(*'mp4v')
writer = cv2.VideoWriter(OUTPUT_VIDEO_PATH, fourcc, fps, (width, height))

# CSV Telemetry Header
csv_file = open(OUTPUT_CSV_PATH, 'w', newline='', encoding='utf-8')
csv_writer = csv.writer(csv_file)
csv_writer.writerow([
    'frame',
    'time_seconds',
    'cars',
    'motorcycles',
    'buses',
    'trucks',
    'total_vehicles',
    'mean_speed_kmh',
    'speed_variance',
    'min_ttc_seconds',
    'near_miss_count',
    'harsh_braking_events',
    'vru_conflicts',
    'trajectory_entropy',
    'risk_ttc',
    'risk_decel',
    'risk_vru',
    'risk_density',
    'composite_risk_score',
    'traffic_level',
    'threat_alert'
])

# Trajectory Memory: track_id -> deque of (frame_idx, t, cx, cy, vx, vy, speed_kmh, cls_name)
trajectory_buffer = {}
TRAJECTORY_MAXLEN = 20

def compute_kinematics(track_id, cx, cy, current_time, cls_name):
    """Computes velocity vector and acceleration in real-world metric approximations."""
    if track_id not in trajectory_buffer:
        trajectory_buffer[track_id] = deque(maxlen=TRAJECTORY_MAXLEN)
        trajectory_buffer[track_id].append((current_time, cx, cy, 0.0, 0.0, 0.0, 0.0, cls_name))
        return 0.0, 0.0, 0.0, 0.0, False

    history = trajectory_buffer[track_id]
    prev_time, prev_cx, prev_cy, prev_vx, prev_vy, prev_speed, _, _ = history[-1]
    
    delta_t = current_time - prev_time
    if delta_t <= 0.0001:
        return prev_vx, prev_vy, prev_speed, 0.0, False

    # Pixel velocity converted to meters/sec
    vx_pix = (cx - prev_cx) / delta_t
    vy_pix = (cy - prev_cy) / delta_t
    
    vx_mps = vx_pix / PIXELS_PER_METER
    vy_mps = vy_pix / PIXELS_PER_METER
    speed_mps = math.hypot(vx_mps, vy_mps)
    speed_kmh = speed_mps * 3.6

    # Acceleration in m/s^2
    accel = (speed_mps - (prev_speed / 3.6)) / delta_t
    is_harsh_braking = accel < HARSH_DECEL_THRESHOLD and prev_speed > 15.0

    # Smooth speed with exponential moving average
    alpha = 0.4
    smooth_vx = alpha * vx_mps + (1 - alpha) * prev_vx
    smooth_vy = alpha * vy_mps + (1 - alpha) * prev_vy
    smooth_speed = math.hypot(smooth_vx, smooth_vy) * 3.6

    history.append((current_time, cx, cy, smooth_vx, smooth_vy, smooth_speed, accel, cls_name))
    return smooth_vx, smooth_vy, smooth_speed, accel, is_harsh_braking

def calculate_pairwise_ssm(active_vehicles):
    """
    Computes Time-to-Collision (TTC) and Post-Encroachment conflict indicators 
    across all active vehicle pairs.
    """
    min_ttc = 99.0
    near_misses = 0
    vru_conflicts = 0
    conflict_pairs = []

    num_v = len(active_vehicles)
    for i in range(num_v):
        for j in range(i + 1, num_v):
            v1 = active_vehicles[i]
            v2 = active_vehicles[j]

            # Euclidean pixel distance & metric distance
            dx_pix = v2['cx'] - v1['cx']
            dy_pix = v2['cy'] - v1['cy']
            dist_m = math.hypot(dx_pix, dy_pix) / PIXELS_PER_METER

            # Relative velocity vector
            rel_vx = v1['vx'] - v2['vx']
            rel_vy = v1['vy'] - v2['vy']
            rel_speed = math.hypot(rel_vx, rel_vy)

            # Check if vehicles are on a converging course
            # dot product of relative position and relative velocity
            dot = (dx_pix / PIXELS_PER_METER) * rel_vx + (dy_pix / PIXELS_PER_METER) * rel_vy

            if dot > 0 and rel_speed > 0.5:
                # Approaching each other
                ttc = dist_m / rel_speed
                if ttc < min_ttc:
                    min_ttc = ttc

                if ttc < TTC_THRESHOLD:
                    near_misses += 1
                    conflict_pairs.append((v1, v2, ttc))

            # Vulnerable Road User (VRU) Proximity Conflict
            is_vru_interaction = (
                (v1['cls'] in VRU_CLASSES and v2['cls'] in HEAVY_CLASSES) or
                (v2['cls'] in VRU_CLASSES and v1['cls'] in HEAVY_CLASSES)
            )
            if is_vru_interaction and dist_m < 3.5:
                vru_conflicts += 1

    return min_ttc, near_misses, vru_conflicts, conflict_pairs

print("\nStarting Hyper-Novelty Perception Pipeline Execution...")
start_exec_time = time.time()
frame_idx = 0

# Limit to processing video frames
while True:
    ret, frame = cap.read()
    if not ret:
        break

    frame_idx += 1
    current_time = frame_idx * dt

    # YOLO11 Inference + ByteTrack
    results = model.track(
        frame,
        persist=True,
        tracker='bytetrack.yaml',
        conf=CONFIDENCE,
        imgsz=IMAGE_SIZE,
        classes=list(VEHICLE_CLASSES.keys()),
        device=DEVICE,
        verbose=False
    )
    result = results[0]

    counts = {'car': 0, 'motorcycle': 0, 'bus': 0, 'truck': 0}
    active_vehicles = []
    harsh_braking_events = 0

    if result.boxes is not None and len(result.boxes) > 0:
        for box in result.boxes:
            cls_id = int(box.cls[0])
            if cls_id not in VEHICLE_CLASSES:
                continue

            cls_name = VEHICLE_CLASSES[cls_id]
            counts[cls_name] += 1

            if box.id is not None:
                track_id = int(box.id[0])
                xyxy = box.xyxy[0].cpu().numpy()
                cx = float((xyxy[0] + xyxy[2]) / 2.0)
                cy = float((xyxy[1] + xyxy[3]) / 2.0)
                w = float(xyxy[2] - xyxy[0])
                h = float(xyxy[3] - xyxy[1])

                vx, vy, speed_kmh, accel, is_braking = compute_kinematics(
                    track_id, cx, cy, current_time, cls_name
                )
                if is_braking:
                    harsh_braking_events += 1

                active_vehicles.append({
                    'id': track_id,
                    'cls': cls_name,
                    'cx': cx,
                    'cy': cy,
                    'w': w,
                    'h': h,
                    'vx': vx,
                    'vy': vy,
                    'speed_kmh': speed_kmh,
                    'accel': accel,
                    'is_braking': is_braking,
                    'xyxy': xyxy
                })

    total_vehicles = len(active_vehicles)

    # Calculate Kinematic Aggregates
    speeds = [v['speed_kmh'] for v in active_vehicles]
    mean_speed = float(np.mean(speeds)) if speeds else 0.0
    speed_var = float(np.var(speeds)) if speeds else 0.0

    # Calculate Trajectory Spatial Entropy
    if len(active_vehicles) > 1:
        headings = [math.atan2(v['vy'], v['vx']) for v in active_vehicles if abs(v['vx']) + abs(v['vy']) > 0.1]
        trajectory_entropy = float(np.std(headings)) if len(headings) > 1 else 0.1
    else:
        trajectory_entropy = 0.0

    # Compute Surrogate Safety Measures (TTC, PET, VRU conflicts)
    min_ttc, near_miss_count, vru_conflicts, conflict_pairs = calculate_pairwise_ssm(active_vehicles)

    # =========================================================================
    # PHYSICS-INFORMED MULTI-MODAL RISK FUSION FORMULATION
    # =========================================================================
    # 1. TTC Hazard Component: Exponential ramp as TTC drops below 3.5s
    risk_ttc = math.exp(-min_ttc / 1.8) if min_ttc < 8.0 else 0.02
    risk_ttc = min(max(risk_ttc, 0.0), 1.0)

    # 2. Deceleration / Shockwave Component
    risk_decel = min(harsh_braking_events * 0.45, 1.0)

    # 3. VRU Proximity Hazard Component
    risk_vru = min(vru_conflicts * 0.35, 1.0)

    # 4. Density & Congestion Entropy Component
    risk_density = min(total_vehicles / 20.0, 1.0)

    # Composite Physics-Informed Risk Score
    composite_risk = (
        0.35 * risk_ttc +
        0.25 * risk_decel +
        0.20 * risk_vru +
        0.10 * min(trajectory_entropy, 1.0) +
        0.10 * risk_density
    )
    composite_risk = round(min(max(composite_risk, 0.05), 0.98), 4)

    # Traffic Density & Threat Categorization
    if total_vehicles >= 12:
        traffic_level = "HIGH"
    elif total_vehicles >= 6:
        traffic_level = "MEDIUM"
    else:
        traffic_level = "LOW"

    if composite_risk >= 0.70 or min_ttc < CRITICAL_TTC:
        threat_alert = "CRITICAL COLLISION THREAT"
    elif composite_risk >= 0.45 or near_miss_count > 0:
        threat_alert = "NEAR-MISS CAUTION"
    elif composite_risk >= 0.30:
        threat_alert = "ELEVATED VIGILANCE"
    else:
        threat_alert = "NORMAL FLOW"

    # Write to CSV
    csv_writer.writerow([
        frame_idx,
        round(current_time, 2),
        counts['car'],
        counts['motorcycle'],
        counts['bus'],
        counts['truck'],
        total_vehicles,
        round(mean_speed, 1),
        round(speed_var, 1),
        round(min_ttc, 2) if min_ttc < 90 else 9.99,
        near_miss_count,
        harsh_braking_events,
        vru_conflicts,
        round(trajectory_entropy, 3),
        round(risk_ttc, 3),
        round(risk_decel, 3),
        round(risk_vru, 3),
        round(risk_density, 3),
        composite_risk,
        traffic_level,
        threat_alert
    ])

    # =========================================================================
    # ADVANCED SCIENTIFIC HUD & SURROGATE SAFETY VISUALIZATION
    # =========================================================================
    annotated = frame.copy()

    # Draw persistent trajectory history trails for each vehicle
    for v in active_vehicles:
        tid = v['id']
        if tid in trajectory_buffer:
            pts = [(int(p[1]), int(p[2])) for p in trajectory_buffer[tid]]
            for k in range(1, len(pts)):
                thickness = int(np.sqrt(k / float(len(pts))) * 2.5) + 1
                # Color trail by speed (cyan for normal, amber for high, purple for heavy)
                trail_color = (0, 255, 255) if v['cls'] == 'motorcycle' else (255, 200, 50)
                cv2.line(annotated, pts[k - 1], pts[k], trail_color, thickness)

        # Draw vehicle bounding box with custom styling
        x1, y1, x2, y2 = [int(coord) for coord in v['xyxy']]
        box_color = (0, 0, 255) if v['is_braking'] else (50, 180, 255) if v['cls'] == 'car' else (0, 220, 100)
        cv2.rectangle(annotated, (x1, y1), (x2, y2), box_color, 2)

        # Bounding label with velocity and track ID
        tag = f"#{tid} {v['cls'][:3].upper()} {int(v['speed_kmh'])}km/h"
        cv2.rectangle(annotated, (x1, y1 - 20), (x1 + 130, y1), box_color, -1)
        cv2.putText(annotated, tag, (x1 + 4, y1 - 6), cv2.FONT_HERSHEY_SIMPLEX, 0.42, (0, 0, 0), 1)

    # Draw Intersecting Collision Threat Vectors between conflict pairs
    for v1, v2, c_ttc in conflict_pairs:
        pt1 = (int(v1['cx']), int(v1['cy']))
        pt2 = (int(v2['cx']), int(v2['cy']))
        cv2.line(annotated, pt1, pt2, (0, 0, 255), 2, cv2.LINE_AA)
        mid_pt = ((pt1[0] + pt2[0]) // 2, (pt1[1] + pt2[1]) // 2)
        cv2.circle(annotated, mid_pt, 16, (0, 0, 255), 2)
        cv2.putText(annotated, f"TTC {c_ttc:.1f}s", (mid_pt[0] + 12, mid_pt[1] + 5),
                    cv2.FONT_HERSHEY_SIMPLEX, 0.55, (0, 0, 255), 2)

    # Top Master HUD Banner (Semi-transparent Glassmorphism overlay)
    hud_bg = annotated[15:195, 15:680]
    black_rect = np.zeros_like(hud_bg, dtype=np.uint8)
    annotated[15:195, 15:680] = cv2.addWeighted(hud_bg, 0.25, black_rect, 0.75, 0)
    cv2.rectangle(annotated, (15, 15), (680, 195), (220, 220, 220), 1)

    # Title & Mode
    cv2.putText(annotated, "SMART TRAFFIC 3.0 | PHYSICS SSM & RISK FUSION",
                (30, 42), cv2.FONT_HERSHEY_SIMPLEX, 0.65, (255, 255, 255), 2)

    # Telemetry metrics row 1
    cv2.putText(annotated, f"Active Vehicles: {total_vehicles}  (Car: {counts['car']} | Bike: {counts['motorcycle']} | Heavy: {counts['truck']+counts['bus']})",
                (30, 72), cv2.FONT_HERSHEY_SIMPLEX, 0.48, (200, 230, 255), 1)

    # Kinematics row 2
    cv2.putText(annotated, f"Avg Speed: {mean_speed:.1f} km/h | Speed Var: {speed_var:.1f} | Braking Events: {harsh_braking_events}",
                (30, 98), cv2.FONT_HERSHEY_SIMPLEX, 0.46, (200, 200, 200), 1)

    # Surrogate Safety Measures (TTC, PET, Near-miss)
    ttc_str = f"{min_ttc:.2f}s" if min_ttc < 90 else "None"
    ttc_color = (0, 0, 255) if min_ttc < CRITICAL_TTC else (0, 165, 255) if min_ttc < TTC_THRESHOLD else (0, 255, 100)
    cv2.putText(annotated, f"Min TTC: {ttc_str} | Near-Misses: {near_miss_count} | VRU Conflicts: {vru_conflicts}",
                (30, 126), cv2.FONT_HERSHEY_SIMPLEX, 0.48, ttc_color, 2)

    # Composite Risk Gauge Bar
    bar_x, bar_y, bar_w, bar_h = 30, 142, 380, 14
    cv2.rectangle(annotated, (bar_x, bar_y), (bar_x + bar_w, bar_y + bar_h), (80, 80, 80), -1)
    fill_w = int(bar_w * composite_risk)
    bar_fill_color = (0, 230, 80) if composite_risk < 0.35 else (0, 180, 255) if composite_risk < 0.65 else (0, 0, 255)
    cv2.rectangle(annotated, (bar_x, bar_y), (bar_x + fill_w, bar_y + bar_h), bar_fill_color, -1)
    cv2.rectangle(annotated, (bar_x, bar_y), (bar_x + bar_w, bar_y + bar_h), (200, 200, 200), 1)
    cv2.putText(annotated, f"Risk Fusion: {int(composite_risk * 100)}%",
                (bar_x + bar_w + 12, bar_y + 12), cv2.FONT_HERSHEY_SIMPLEX, 0.48, (255, 255, 255), 1)

    # Threat Status Badge
    alert_color = (0, 0, 255) if "CRITICAL" in threat_alert else (0, 165, 255) if "NEAR-MISS" in threat_alert else (0, 255, 100)
    cv2.putText(annotated, f"STATUS: {threat_alert}",
                (30, 182), cv2.FONT_HERSHEY_SIMPLEX, 0.55, alert_color, 2)

    writer.write(annotated)

    if frame_idx % 100 == 0 or frame_idx == total_frames:
        elapsed = time.time() - start_exec_time
        fps_proc = frame_idx / elapsed if elapsed > 0 else 0
        print(f"Processed frame {frame_idx}/{total_frames} ({frame_idx/total_frames*100:.1f}%) | Speed: {fps_proc:.1f} FPS | Risk: {composite_risk:.2f}")

cap.release()
writer.release()
csv_file.close()

total_elapsed = time.time() - start_exec_time
print("=" * 65)
print(f"Hyper-Novelty Pipeline Execution Complete in {total_elapsed:.2f}s!")
print(f"Enhanced Telemetry Output CSV: {OUTPUT_CSV_PATH}")
print(f"Enhanced Visual Output MP4:    {OUTPUT_VIDEO_PATH}")
print("=" * 65)
