-- RQ5: Highest average driver payout by city + ride-category combination
WITH completed AS (
    SELECT
        z.city,
        h.ride_category,
        f.driver_payout_zar,
        f.total_fare_zar,
        f.distance_km,
        f.duration_minutes
    FROM trip_headers h
    INNER JOIN trip_fare_breakdown f  ON f.trip_id = h.trip_id
    INNER JOIN pricing_surge_zones z  ON z.zone_id = h.zone_id
    WHERE h.trip_status = 'COMPLETED'
      AND f.driver_payout_zar > 0
),
city_category AS (
    SELECT
        city,
        ride_category,
        COUNT(*)                                   AS trip_count,
        ROUND(AVG(driver_payout_zar), 2)           AS avg_driver_payout,
        ROUND(AVG(total_fare_zar), 2)              AS avg_total_fare,
        ROUND(AVG(distance_km), 2)                 AS avg_distance_km,
        ROUND(AVG(duration_minutes), 2)            AS avg_duration_min,
        ROUND(AVG(driver_payout_zar
                  / NULLIF(distance_km, 0)), 2)    AS payout_per_km,
        ROUND(AVG(driver_payout_zar
                  / NULLIF(duration_minutes / 60.0, 0)), 2) AS payout_per_hour
    FROM completed
    GROUP BY city, ride_category
    HAVING COUNT(*) >= 30
)
SELECT
    city,
    ride_category,
    trip_count,
    avg_driver_payout,
    avg_total_fare,
    avg_distance_km,
    avg_duration_min,
    payout_per_km,
    payout_per_hour,
    RANK() OVER (PARTITION BY city ORDER BY avg_driver_payout DESC) AS rank_within_city,
    DENSE_RANK() OVER (ORDER BY avg_driver_payout DESC)             AS rank_overall
FROM city_category
ORDER BY avg_driver_payout DESC
LIMIT 20;
