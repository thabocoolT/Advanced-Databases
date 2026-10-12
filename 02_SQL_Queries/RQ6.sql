
-- RQ6: Estimated Driver Net Earnings After Fuel Costs
-- PostgreSQL
--
-- Method:
-- 1. Use one monthly fuel-price table for every comparison.
-- 2. Estimate fuel consumption from vehicle-model assumptions.
-- 3. Include completed trips with positive duration.
-- 4. Include only drivers with exactly one vehicle record because the
--    supplied trip schema does not identify the vehicle used per trip.
-- 5. Treat earnings after fuel as an estimate, not complete profit.
--
-- Run this entire file in one database session because it uses TEMP tables.

-- ============================================================
-- 1. Vehicle fuel-consumption assumptions
-- ============================================================

DROP TABLE IF EXISTS rq6_trip_estimates;
DROP TABLE IF EXISTS rq6_vehicle_fuel_rates;
DROP TABLE IF EXISTS rq6_monthly_fuel_prices;

CREATE TEMP TABLE rq6_vehicle_fuel_rates (
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    litres_per_100km NUMERIC(6,2) NOT NULL
        CHECK (litres_per_100km > 0),
    PRIMARY KEY (make, model)
);

INSERT INTO rq6_vehicle_fuel_rates (make, model, litres_per_100km)
VALUES
    ('BMW', '3 Series', 6.5),
    ('Hyundai', 'Grand i10', 5.5),
    ('Kia', 'Picanto', 5.1),
    ('Nissan', 'Almera', 6.3),
    ('Renault', 'Triber', 5.5),
    ('Suzuki', 'Ertiga', 5.5),
    ('Toyota', 'Avanza', 7.6),
    ('Toyota', 'Corolla Quest', 6.3),
    ('Volkswagen', 'Polo Vivo', 5.9);

-- ============================================================
-- 2. Monthly fuel-price assumptions
-- Columns: year, month, inland price, coastal price (ZAR/litre)
-- These are the project's current assumptions. Verify them against
-- the sources agreed upon by the group before final submission.
-- ============================================================

CREATE TEMP TABLE rq6_monthly_fuel_prices (
    trip_year INTEGER NOT NULL,
    trip_month INTEGER NOT NULL CHECK (trip_month BETWEEN 1 AND 12),
    inland_price NUMERIC(6,2) NOT NULL CHECK (inland_price > 0),
    coastal_price NUMERIC(6,2) NOT NULL CHECK (coastal_price > 0),
    PRIMARY KEY (trip_year, trip_month)
);

INSERT INTO rq6_monthly_fuel_prices
    (trip_year, trip_month, inland_price, coastal_price)
VALUES
    (2025, 3, 22.34, 21.55),
    (2025, 4, 21.62, 20.79),
    (2025, 5, 21.40, 20.57),
    (2025, 6, 21.35, 20.52),
    (2025, 7, 21.87, 21.04),
    (2025, 8, 21.59, 20.76),
    (2025, 9, 21.55, 20.72),
    (2025, 10, 21.63, 20.80),
    (2025, 11, 21.12, 20.29),
    (2025, 12, 21.41, 20.58),
    (2026, 1, 20.75, 19.92),
    (2026, 2, 20.10, 19.27),
    (2026, 3, 20.30, 19.47);

-- ============================================================
-- 3. Build the shared trip-level estimate
-- ============================================================

CREATE TEMP TABLE rq6_trip_estimates AS
WITH vehicle_counts AS (
    SELECT
        driver_id,
        COUNT(*) AS vehicle_record_count
    FROM vehicles
    GROUP BY driver_id
),
single_vehicle_drivers AS (
    SELECT
        v.driver_id,
        v.make,
        v.model,
        v.year AS vehicle_year
    FROM vehicles AS v
    INNER JOIN vehicle_counts AS vc
        ON vc.driver_id = v.driver_id
    WHERE vc.vehicle_record_count = 1
),
trip_inputs AS (
    SELECT
        th.trip_id,
        th.request_timestamp,
        sd.driver_id,
        sd.operating_city,
        sv.make,
        sv.model,
        sv.vehicle_year,
        tf.distance_km,
        tf.duration_minutes,
        tf.driver_payout_zar,
        vfr.litres_per_100km,
        CASE
            WHEN sd.operating_city IN
                ('Cape Town', 'Durban', 'Gqeberha')
                THEN fp.coastal_price
            ELSE fp.inland_price
        END AS fuel_price_per_litre,
        CASE
            WHEN th.request_timestamp < TIMESTAMP '2026-03-01'
                THEN 28.79::NUMERIC
            ELSE 30.23::NUMERIC
        END AS minimum_wage_benchmark
    FROM trip_headers AS th
    INNER JOIN sa_drivers AS sd
        ON sd.driver_id = th.driver_id
    INNER JOIN trip_fare_breakdown AS tf
        ON tf.trip_id = th.trip_id
    INNER JOIN single_vehicle_drivers AS sv
        ON sv.driver_id = th.driver_id
    INNER JOIN rq6_vehicle_fuel_rates AS vfr
        ON vfr.make = sv.make
       AND vfr.model = sv.model
    INNER JOIN rq6_monthly_fuel_prices AS fp
        ON fp.trip_year =
            EXTRACT(YEAR FROM th.request_timestamp)::INTEGER
       AND fp.trip_month =
            EXTRACT(MONTH FROM th.request_timestamp)::INTEGER
    WHERE th.trip_status = 'COMPLETED'
      AND tf.duration_minutes > 0
      AND tf.distance_km >= 0
      AND tf.driver_payout_zar >= 0
)
SELECT
    *,
    distance_km * litres_per_100km / 100
        AS estimated_litres_used,
    distance_km * litres_per_100km / 100
        * fuel_price_per_litre
        AS estimated_fuel_cost,
    driver_payout_zar
        - (
            distance_km * litres_per_100km / 100
            * fuel_price_per_litre
        ) AS estimated_net_earnings
FROM trip_inputs;

-- ============================================================
-- 4. Main RQ6 result: hourly earnings against period benchmark
-- ============================================================

SELECT
    CASE
        WHEN request_timestamp < TIMESTAMP '2026-03-01'
            THEN 'March 2025 - February 2026'
        ELSE 'March 2026'
    END AS period,
    COUNT(*) AS completed_trips,
    ROUND(AVG(driver_payout_zar), 2) AS avg_driver_payout_zar,
    ROUND(AVG(estimated_fuel_cost), 2) AS avg_estimated_fuel_cost_zar,
    ROUND(AVG(estimated_net_earnings), 2)
        AS avg_estimated_net_earnings_zar,
    ROUND(
        SUM(estimated_net_earnings)
        / NULLIF(SUM(duration_minutes / 60.0), 0),
        2
    ) AS estimated_net_earnings_per_hour_zar,
    MIN(minimum_wage_benchmark) AS benchmark_zar_per_hour,
    CASE
        WHEN
            SUM(estimated_net_earnings)
            / NULLIF(SUM(duration_minutes / 60.0), 0)
            >= MIN(minimum_wage_benchmark)
        THEN 'MEETS OR EXCEEDS BENCHMARK'
        ELSE 'BELOW BENCHMARK'
    END AS benchmark_result
FROM rq6_trip_estimates
GROUP BY
    CASE
        WHEN request_timestamp < TIMESTAMP '2026-03-01'
            THEN 'March 2025 - February 2026'
        ELSE 'March 2026'
    END
ORDER BY MIN(request_timestamp);

-- ============================================================
-- 5. Vehicle-model comparison
-- ============================================================

SELECT
    make,
    model,
    COUNT(*) AS completed_trips,
    ROUND(AVG(driver_payout_zar), 2) AS avg_driver_payout_zar,
    ROUND(AVG(estimated_fuel_cost), 2) AS avg_estimated_fuel_cost_zar,
    ROUND(AVG(estimated_net_earnings), 2)
        AS avg_estimated_net_earnings_zar,
    ROUND(
        SUM(estimated_net_earnings)
        / NULLIF(SUM(duration_minutes / 60.0), 0),
        2
    ) AS estimated_net_earnings_per_hour_zar
FROM rq6_trip_estimates
GROUP BY make, model
ORDER BY estimated_net_earnings_per_hour_zar DESC;

-- ============================================================
-- 6. City comparison
-- ============================================================

SELECT
    operating_city,
    COUNT(*) AS completed_trips,
    ROUND(AVG(driver_payout_zar), 2) AS avg_driver_payout_zar,
    ROUND(AVG(estimated_fuel_cost), 2) AS avg_estimated_fuel_cost_zar,
    ROUND(AVG(estimated_net_earnings), 2)
        AS avg_estimated_net_earnings_zar,
    ROUND(
        SUM(estimated_net_earnings)
        / NULLIF(SUM(duration_minutes / 60.0), 0),
        2
    ) AS estimated_net_earnings_per_hour_zar
FROM rq6_trip_estimates
GROUP BY operating_city
ORDER BY estimated_net_earnings_per_hour_zar DESC;

-- ============================================================
-- 7. Validation A: drivers with multiple vehicle records
-- Trips from these drivers are excluded from the estimates above.
-- ============================================================

SELECT
    driver_id,
    COUNT(*) AS vehicle_record_count,
    STRING_AGG(
        make || ' ' || model || ' (' || year::TEXT || ')',
        ', ' ORDER BY make, model, year
    ) AS recorded_vehicles
FROM vehicles
GROUP BY driver_id
HAVING COUNT(*) > 1
ORDER BY vehicle_record_count DESC, driver_id;

-- ============================================================
-- 8. Validation B: vehicle models without a fuel-rate assumption
-- ============================================================

SELECT DISTINCT
    v.make,
    v.model
FROM vehicles AS v
LEFT JOIN rq6_vehicle_fuel_rates AS r
    ON r.make = v.make
   AND r.model = v.model
WHERE r.make IS NULL
ORDER BY v.make, v.model;

-- ============================================================
-- 9. Validation C: coverage and exclusions
-- ============================================================

SELECT
    (SELECT COUNT(*)
     FROM trip_headers
     WHERE trip_status = 'COMPLETED')
        AS all_completed_trip_headers,
    (SELECT COUNT(*)
     FROM rq6_trip_estimates)
        AS trips_in_rq6_estimates,
    (SELECT COUNT(DISTINCT driver_id)
     FROM vehicles)
        AS drivers_with_vehicle_records,
    (SELECT COUNT(*)
     FROM (
         SELECT driver_id
         FROM vehicles
         GROUP BY driver_id
         HAVING COUNT(*) = 1
     ) AS one_vehicle)
        AS drivers_with_exactly_one_vehicle_record;
