-- -------------------------------------------------------------------------
-- 4A. Peak vs Off-Peak
-- -------------------------------------------------------------------------
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM t.request_timestamp) >= 6  AND EXTRACT(HOUR FROM t.request_timestamp) < 9  THEN 'Peak'
        WHEN EXTRACT(HOUR FROM t.request_timestamp) >= 16 AND EXTRACT(HOUR FROM t.request_timestamp) < 19 THEN 'Peak'
        ELSE 'Off-Peak'
    END                                                                       AS period,
    COUNT(*)                                                                  AS completed_trips,
    ROUND(AVG(f.distance_km), 2)                                              AS avg_distance_km,
    ROUND(AVG(f.duration_minutes), 1)                                         AS avg_duration_min,
    ROUND(AVG(f.surge_multiplier), 2)                                         AS avg_surge_multiplier,
    ROUND(AVG(f.driver_payout_zar), 2)                                        AS avg_payout_zar,
    ROUND(AVG(f.driver_payout_zar / NULLIF(f.duration_minutes, 0) * 60), 2)   AS avg_payout_per_hour_zar
FROM trip_headers t
JOIN trip_fare_breakdown f ON f.trip_id = t.trip_id
WHERE t.trip_status = 'COMPLETED'
GROUP BY period
ORDER BY period;


-- -------------------------------------------------------------------------
-- 4B. Surge pricing bands
-- -------------------------------------------------------------------------
SELECT
    CASE
        WHEN f.surge_multiplier = 1.0 THEN '1. No Surge (1.0)'
        WHEN f.surge_multiplier < 1.5 THEN '2. Low (1.01-1.49)'
        WHEN f.surge_multiplier < 2.0 THEN '3. Medium (1.5-1.99)'
        ELSE                               '4. High (2.0+)'
    END                                                                       AS surge_band,
    COUNT(*)                                                                  AS completed_trips,
    ROUND(AVG(f.total_fare_zar), 2)                                           AS avg_total_fare_zar,
    ROUND(AVG(f.driver_payout_zar), 2)                                        AS avg_payout_zar,
    ROUND(AVG(f.driver_payout_zar / NULLIF(f.duration_minutes, 0) * 60), 2)   AS avg_payout_per_hour_zar
FROM trip_headers t
JOIN trip_fare_breakdown f ON f.trip_id = t.trip_id
WHERE t.trip_status = 'COMPLETED'
GROUP BY surge_band
ORDER BY surge_band;


-- -------------------------------------------------------------------------
-- 4C. Trip distance bands
-- -------------------------------------------------------------------------
SELECT
    CASE
        WHEN f.distance_km < 5   THEN '1. Short (<5 km)'
        WHEN f.distance_km < 15  THEN '2. Medium (5-14.99 km)'
        WHEN f.distance_km < 30  THEN '3. Long (15-29.99 km)'
        ELSE                          '4. Very long (30+ km)'
    END                                                                       AS distance_band,
    COUNT(*)                                                                  AS completed_trips,
    ROUND(AVG(f.driver_payout_zar), 2)                                        AS avg_payout_zar,
    ROUND(AVG(f.driver_payout_zar / NULLIF(f.distance_km, 0)), 2)             AS avg_payout_per_km_zar,
    ROUND(AVG(f.driver_payout_zar / NULLIF(f.duration_minutes, 0) * 60), 2)   AS avg_payout_per_hour_zar
FROM trip_headers t
JOIN trip_fare_breakdown f ON f.trip_id = t.trip_id
WHERE t.trip_status = 'COMPLETED'
GROUP BY distance_band
ORDER BY distance_band;


-- -------------------------------------------------------------------------
-- 4D. Trip duration bands
-- -------------------------------------------------------------------------
SELECT
    CASE
        WHEN f.duration_minutes < 15 THEN '1. Quick (<15 min)'
        WHEN f.duration_minutes < 30 THEN '2. Standard (15-29 min)'
        WHEN f.duration_minutes < 60 THEN '3. Extended (30-59 min)'
        ELSE                              '4. Long (60+ min)'
    END                                                                       AS duration_band,
    COUNT(*)                                                                  AS completed_trips,
    ROUND(AVG(f.driver_payout_zar), 2)                                        AS avg_payout_zar,
    ROUND(AVG(f.driver_payout_zar / NULLIF(f.duration_minutes, 0) * 60), 2)   AS avg_payout_per_hour_zar
FROM trip_headers t
JOIN trip_fare_breakdown f ON f.trip_id = t.trip_id
WHERE t.trip_status = 'COMPLETED'
GROUP BY duration_band
ORDER BY duration_band;


-- -------------------------------------------------------------------------
-- 4E. Peak period x surge band (combined view)
-- -------------------------------------------------------------------------
WITH trip_conditions AS (
    SELECT
        CASE
            WHEN EXTRACT(HOUR FROM t.request_timestamp) >= 6  AND EXTRACT(HOUR FROM t.request_timestamp) < 9  THEN 'Peak'
            WHEN EXTRACT(HOUR FROM t.request_timestamp) >= 16 AND EXTRACT(HOUR FROM t.request_timestamp) < 19 THEN 'Peak'
            ELSE 'Off-Peak'
        END AS period,
        CASE
            WHEN f.surge_multiplier = 1.0 THEN '1. No Surge'
            WHEN f.surge_multiplier < 1.5 THEN '2. Low Surge'
            WHEN f.surge_multiplier < 2.0 THEN '3. Medium Surge'
            ELSE                               '4. High Surge'
        END AS surge_band,
        f.driver_payout_zar,
        f.duration_minutes
    FROM trip_headers t
    JOIN trip_fare_breakdown f ON f.trip_id = t.trip_id
    WHERE t.trip_status = 'COMPLETED'
)
SELECT
    period,
    surge_band,
    COUNT(*)                                                                  AS completed_trips,
    ROUND(AVG(driver_payout_zar), 2)                                          AS avg_payout_zar,
    ROUND(AVG(driver_payout_zar / NULLIF(duration_minutes, 0) * 60), 2)       AS avg_payout_per_hour_zar
FROM trip_conditions
GROUP BY period, surge_band
ORDER BY period, surge_band;


-- -------------------------------------------------------------------------
-- 4F. Correlation of each trip condition with driver payout
-- (values range from -1 to +1; closer to +/-1 = stronger linear relationship)
-- -------------------------------------------------------------------------
SELECT
    ROUND(CORR(f.distance_km,       f.driver_payout_zar)::numeric, 3) AS corr_distance_vs_payout,
    ROUND(CORR(f.duration_minutes,  f.driver_payout_zar)::numeric, 3) AS corr_duration_vs_payout,
    ROUND(CORR(f.surge_multiplier,  f.driver_payout_zar)::numeric, 3) AS corr_surge_vs_payout,
    ROUND(CORR(f.tip_zar,           f.driver_payout_zar)::numeric, 3) AS corr_tip_vs_payout
FROM trip_headers t
JOIN trip_fare_breakdown f ON f.trip_id = t.trip_id
WHERE t.trip_status = 'COMPLETED';
