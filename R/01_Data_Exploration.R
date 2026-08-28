accidents <- read_csv(
  "C:/Users/Harshitha/OneDrive/Documents/Smart Traffic/data/indian_roads_dataset.csv"
)
dim(accidents)
glimpse(accidents)
# Check missing values in every column
colSums(is.na(accidents))
# Check duplicate rows
sum(duplicated(accidents))
unique(accidents$weather)
unique(accidents$accident_severity)
unique(accidents$vehicle_type)
unique(accidents$road_type)
names(accidents)
summary(accidents)
table(accidents$city)
table(accidents$weather)
table(accidents$traffic_density)
table(accidents$cause)
table(accidents$accident_severity)