BEGIN;
SET TRANSACTION READ ONLY;

-- Compare all ride categories. The arithmetic mean of per-trip ratios gives
-- each trip equal weight; the weighted ratio is total payout / total fare.
WITH eligible_trips AS (
    SELECT
        th.trip_id,
        th.driver_id,
        th.ride_category,
        tfb.total_fare_zar,
        tfb.driver_payout_zar,
        tfb.platform_commission_zar,
        tfb.distance_km,
        tfb.duration_minutes,
        tfb.driver_payout_zar / NULLIF(tfb.total_fare_zar, 0)
            AS payout_to_fare_ratio
    FROM trip_headers AS th
    INNER JOIN trip_fare_breakdown AS tfb
        ON tfb.trip_id = th.trip_id
    WHERE th.trip_status = 'COMPLETED'
      AND tfb.total_fare_zar > 0
),
category_summary AS (
    SELECT
        e.ride_category,
        COUNT(*) AS completed_trip_count,
        COUNT(DISTINCT d.driver_id) AS driver_count,
        AVG(e.driver_payout_zar) AS average_driver_payout_zar,
        PERCENTILE_CONT(0.5) WITHIN GROUP (
            ORDER BY e.driver_payout_zar
        ) AS median_driver_payout_zar,
        AVG(e.total_fare_zar) AS average_total_fare_zar,
        AVG(e.payout_to_fare_ratio) AS average_trip_payout_to_fare_ratio,
        SUM(e.driver_payout_zar) / NULLIF(SUM(e.total_fare_zar), 0)
            AS weighted_payout_to_fare_ratio,
        AVG(e.platform_commission_zar) AS average_platform_commission_zar,
        AVG(e.distance_km) AS average_distance_km,
        AVG(e.duration_minutes) AS average_duration_minutes
    FROM eligible_trips AS e
    LEFT JOIN sa_drivers AS d
        ON d.driver_id = e.driver_id
    GROUP BY e.ride_category
)
SELECT
    ride_category,
    completed_trip_count,
    driver_count,
    ROUND(average_driver_payout_zar, 2) AS average_driver_payout_zar,
    ROUND(median_driver_payout_zar::numeric, 2) AS median_driver_payout_zar,
    ROUND(average_total_fare_zar, 2) AS average_total_fare_zar,
    ROUND(average_trip_payout_to_fare_ratio * 100, 2)
        AS average_trip_payout_to_fare_pct,
    ROUND(weighted_payout_to_fare_ratio * 100, 2)
        AS weighted_payout_to_fare_pct,
    ROUND(average_platform_commission_zar, 2)
        AS average_platform_commission_zar,
    ROUND(average_distance_km, 2) AS average_distance_km,
    ROUND(average_duration_minutes, 2) AS average_duration_minutes,
    RANK() OVER (ORDER BY average_driver_payout_zar DESC)
        AS average_payout_rank,
    RANK() OVER (ORDER BY average_trip_payout_to_fare_ratio DESC)
        AS average_trip_payout_to_fare_rank,
    RANK() OVER (ORDER BY weighted_payout_to_fare_ratio DESC)
        AS weighted_payout_to_fare_rank
FROM category_summary
ORDER BY
    average_payout_rank,
    average_trip_payout_to_fare_rank,
    weighted_payout_to_fare_rank,
    ride_category;

-- Show categories whose mean trip payout is above the overall completed-trip
-- mean. This HAVING clause uses a scalar subquery as a category-level filter.
WITH eligible_trips AS (
    SELECT
        th.ride_category,
        tfb.driver_payout_zar,
        tfb.total_fare_zar
    FROM trip_headers AS th
    INNER JOIN trip_fare_breakdown AS tfb
        ON tfb.trip_id = th.trip_id
    WHERE th.trip_status = 'COMPLETED'
      AND tfb.total_fare_zar > 0
)
SELECT
    ride_category,
    COUNT(*) AS completed_trip_count,
    ROUND(AVG(driver_payout_zar), 2) AS average_driver_payout_zar,
    ROUND(
        AVG(driver_payout_zar / NULLIF(total_fare_zar, 0)) * 100,
        2
    ) AS average_trip_payout_to_fare_pct
FROM eligible_trips
GROUP BY ride_category
HAVING AVG(driver_payout_zar) > (
    SELECT AVG(driver_payout_zar)
    FROM eligible_trips
)
ORDER BY average_driver_payout_zar DESC;

COMMIT;
