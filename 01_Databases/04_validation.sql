-- =========================================================
-- DATA VALIDATION
-- =========================================================

SELECT COUNT(*) AS driver_count
FROM sa_drivers;

SELECT COUNT(*) AS rider_count
FROM sa_riders;

SELECT COUNT(*) AS vehicle_count
FROM vehicles;

SELECT COUNT(*) AS zone_count
FROM pricing_surge_zones;

SELECT COUNT(*) AS trip_count
FROM trip_headers;

SELECT COUNT(*) AS fare_count
FROM trip_fare_breakdown;

SELECT COUNT(*) AS review_count
FROM trip_reviews;