# Creating new table which combine the four tables into one

CREATE TABLE divvy_trips_combined AS
SELECT trip_id, start_time, end_time, bikeid, from_station_id, from_station_name, to_station_id, to_station_name, usertype, gender, birthyear, ride_length, day_of_week
FROM `Cyclistic_case_study`.`divvy_trips_2019_q2_working`;

# Updating birthyear column in 2019 Q3 table to be null if cell is empty

UPDATE `Cyclistic_case_study`.`divvy_trips_2019_q3_working`
SET birthyear = NULLIF(birthyear, '');

# Modifying the birthyear column in 2019 Q3 to be an INT to match other tables

ALTER TABLE `Cyclistic_case_study`.`divvy_trips_2019_q3_working`
MODIFY COLUMN birthyear INT;

# Inserting 2019 Q3 table into combined table

INSERT INTO `Cyclistic_case_study`.`divvy_trips_combined`
SELECT *
FROM `Cyclistic_case_study`.`divvy_trips_2019_q3_working`;

# Inserting 2019 Q4 table into combined table

INSERT INTO `Cyclistic_case_study`.`divvy_trips_combined`
SELECT *
FROM `Cyclistic_case_study`.`divvy_trips_2019_q4_working`;

# Updating the trip_id column in the combined table to be a string

ALTER TABLE `Cyclistic_case_study`.`divvy_trips_combined`
MODIFY COLUMN trip_id TEXT;

# Inserting 2020 Q1 table into combined table

INSERT INTO `Cyclistic_case_study`.`divvy_trips_combined` (trip_id, start_time, end_time, from_station_id, from_station_name, to_station_id, usertype, ride_length, day_of_week)
SELECT trip_id, start_time, end_time, from_station_id, from_station_name, to_station_id, usertype, ride_length, day_of_week
FROM `Cyclistic_case_study`.`divvy_trips_2020_q1_working`;

# Deleting null values from ride_length 

DELETE
FROM `Cyclistic_case_study`.`divvy_trips_combined`
WHERE ride_length LIKE '%#%';

# Updating member and casual to be subscriber and customer

UPDATE `Cyclistic_case_study`.`divvy_trips_combined`
SET usertype = 'Subscriber'
WHERE usertype = 'member';

UPDATE `Cyclistic_case_study`.`divvy_trips_combined`
SET usertype = 'Customer'
WHERE usertype = 'casual';

# Updating ride_length column to be in time format instead of a string

ALTER TABLE `Cyclistic_case_study`.`divvy_trips_combined`
MODIFY COLUMN ride_length TIME;

# Adding a new column to the combined table that converts ride_length to seconds

ALTER TABLE `Cyclistic_case_study`.`divvy_trips_combined`
ADD COLUMN ride_length_seconds INT;

UPDATE `Cyclistic_case_study`.`divvy_trips_combined`
SET ride_length_seconds = TIME_TO_SEC(ride_length);

# Deleting null values from combined table

DELETE
FROM `Cyclistic_case_study`.`divvy_trips_combined`
WHERE ride_length_seconds IS NULL;
















