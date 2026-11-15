# APPENDIX B — Dataset Codebook and Field Dictionary

This codebook documents all 24 attributes contained in `data/indian_roads_dataset.csv` (20,000 incident rows) and all 9 attributes in `smart-traffic-2.0/outputs/traffic_results_v2.csv` (901 video frames).

---

## Table 1: Indian Roads Accident Dataset (20,000 Records)

| Column Index | Field Name | Type | Allowed / Observed Range | Missing Count | Description |
|:---|:---|:---|:---|:---|:---|
| 1 | `accident_id` | Integer | 0 to 19,999 | 0 | Unique sequential incident identifier |
| 2 | `city` | Factor | 8 Cities (Chandigarh, Chennai, Kolkata, Pune, Mumbai, Bangalore, Delhi, Hyderabad) | 0 | Municipal metropolitan jurisdiction |
| 3 | `state` | Factor | 7 State / UT Jurisdictions | 0 | Administrative State / Union Territory |
| 4 | `latitude` | Float | 12.800172 to 30.799960 °N | 0 | Geographic WGS-84 latitude |
| 5 | `longitude` | Float | 72.820000 to 88.420000 °E | 0 | Geographic WGS-84 longitude |
| 6 | `date` | Date | 2018-01-01 to 2023-12-31 | 0 | Calendar date of crash occurrence |
| 7 | `time` | Time | 00:00:00 to 23:59:59 | 0 | Wall-clock timestamp of incident |
| 8 | `hour` | Integer | 0 to 23 | 0 | Hour of day (24-hour military clock) |
| 9 | `day_of_week` | Factor | Monday through Sunday | 0 | Day of the week name |
| 10 | `is_weekend` | Integer | 0 (Weekday), 1 (Weekend) | 0 | Flag indicating Saturday or Sunday |
| 11 | `road_type` | Factor | urban (6,745), rural (6,639), highway (6,616) | 0 | Infrastructure roadway classification |
| 12 | `lanes` | Integer | 1 to 6 | 0 | Number of operational vehicular travel lanes |
| 13 | `traffic_signal` | Integer | 0 (No Signal), 1 (Signal Present) | 0 | Intersection signal control indicator |
| 14 | `weather` | Factor | clear (6,690), rain (6,677), fog (6,633) | 0 | Atmospheric conditions at time of collision |
| 15 | `visibility` | Factor | low, medium, high | 0 | Subjective visual line-of-sight rating |
| 16 | `temperature` | Float | 10.0 to 45.0 °C | 0 | Ambient outdoor temperature |
| 17 | `traffic_density` | Factor | low (7,067), high (7,034), medium (5,899) | 0 | Pre-crash flow density on roadway |
| 18 | `cause` | Factor | distraction (4,026), overspeeding (4,025), weather (3,997), drunk driving (3,978), poor road (3,974) | 0 | Primary police-reported contributory factor |
| 19 | `accident_severity`| Factor | minor (11,025), major (5,988), fatal (2,987) | 0 | Ground-truth crash severity classification [TARGET] |
| 20 | `vehicles_involved`| Integer | 1 to 6 | 0 | Total number of colliding vehicles |
| 21 | `casualties` | Integer | 0 to 8 | 0 | Total injured or deceased individuals |
| 22 | `is_peak_hour` | Integer | 0 (Off-Peak), 1 (Peak) | 0 | Indicator for rush hours (8-11 AM, 5-8 PM) |
| 23 | `festival` | Factor | Diwali, Holi, Eid, New Year, None | 19,885 | Indicator for festive public holidays (99.4% None) |
| 24 | `risk_score` | Float | 0.10 to 1.00 | 0 | Domain composite crash risk index |

---

## Table 2: Video AI Telemetry Dataset (901 Continuous Video Frames)

| Column Index | Field Name | Type | Range Observed | Description |
|:---|:---|:---|:---|:---|
| 1 | `frame` | Integer | 1 to 901 | Sequential video frame index |
| 2 | `time_seconds` | Float | 0.017 to 15.030 s | Elapsed video duration at 59.94 FPS |
| 3 | `cars` | Integer | 3 to 7 (Mean: 6.14) | Concurrent tracked passenger cars |
| 4 | `motorcycles` | Integer | 6 to 14 (Mean: 11.62) | Concurrent tracked two-wheelers (Motorcycles) |
| 5 | `buses` | Integer | 0 (Mean: 0.00) | Concurrent tracked passenger buses |
| 6 | `trucks` | Integer | 1 to 3 (Mean: 2.36) | Concurrent tracked freight trucks |
| 7 | `total_vehicles` | Integer | 17 to 23 (Mean: 20.12) | Sum of active tracked vehicle instances |
| 8 | `traffic_level` | String | HIGH (100% of frames) | Flow state classification (total >= 15 -> HIGH) |
| 9 | `risk_score` | Float | 0.85 to 1.00 (Mean: 0.985) | Heuristic congestion risk: min(total / 20.0, 1.0) |
