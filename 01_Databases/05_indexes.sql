CREATE INDEX idx_trip_headers_driver_id
ON trip_headers(driver_id);

CREATE INDEX idx_trip_headers_rider_id
ON trip_headers(rider_id);

CREATE INDEX idx_trip_headers_zone_id
ON trip_headers(zone_id);

CREATE INDEX idx_trip_headers_timestamp
ON trip_headers(request_timestamp);

CREATE INDEX idx_trip_headers_status
ON trip_headers(trip_status);

CREATE INDEX idx_trip_headers_ride_category
ON trip_headers(ride_category);

CREATE INDEX idx_fare_breakdown_trip_id
ON trip_fare_breakdown(trip_id);

CREATE INDEX idx_reviews_trip_id
ON trip_reviews(trip_id);