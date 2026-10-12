-- RQ6: Estimated Net Earnings After Fuel Costs

-- RQ6: Time-accurate minimum-wage benchmark comparison

WITH vehicle_fuel_rates AS (
    SELECT *
    FROM (VALUES
        ('BMW', '3 Series', 6.5::NUMERIC),
        ('Hyundai', 'Grand i10', 5.5::NUMERIC),
        ('Kia', 'Picanto', 5.1::NUMERIC),
        ('Nissan', 'Almera', 6.3::NUMERIC),
        ('Renault', 'Triber', 5.5::NUMERIC),
        ('Suzuki', 'Ertiga', 5.5::NUMERIC),
        ('Toyota', 'Avanza', 7.6::NUMERIC),
        ('Toyota', 'Corolla Quest', 6.3::NUMERIC),
        ('Volkswagen', 'Polo Vivo', 5.9::NUMERIC)
    ) AS rates(make, model, litres_per_100km)
),

fuel_prices AS (
    SELECT *
    FROM (VALUES
        (2025, 3, 22.34::NUMERIC, 21.55::NUMERIC),
        (2025, 4, 21.62, 20.79),
        (2025, 5, 21.40, 20.57),
        (2025, 6, 21.35, 20.52),
        (2025, 7, 21.87, 21.04),
        (2025, 8, 21.59, 20.76),
        (2025, 9, 21.55, 20.72),
        (2025, 10, 21.63, 20.80),
        (2025, 11, 21.12, 20.29),
        (2025, 12, 21.63, 20.80),
        (2026, 1, 20.75, 19.92),
        (2026, 2, 20.10, 19.27),
        (2026, 3, 20.30, 19.47)
    ) AS prices(trip_year, trip_month, inland_price, coastal_price)
),

completed_trips AS (
    SELECT
        th.trip_id,
        th.request_timestamp,
        tf.driver_payout_zar,
        tf.distance_km,
        tf.duration_minutes,
        vfr.litres_per_100km,

        CASE
            WHEN sd.operating_city IN (
                'Cape Town', 'Durban', 'Gqeberha'
            )
            THEN fp.coastal_price
            ELSE fp.inland_price
        END AS fuel_price_per_litre,

        CASE
            WHEN th.request_timestamp < TIMESTAMP '2026-03-01'
            THEN 28.79
            ELSE 30.23
        END AS minimum_wage_benchmark

    FROM trip_headers th

    JOIN sa_drivers sd
        ON th.driver_id = sd.driver_id

    JOIN trip_fare_breakdown tf
        ON th.trip_id = tf.trip_id

    JOIN vehicles v
        ON th.driver_id = v.driver_id

    JOIN vehicle_fuel_rates vfr
        ON v.make = vfr.make
       AND v.model = vfr.model

    JOIN fuel_prices fp
        ON EXTRACT(YEAR FROM th.request_timestamp)::INT = fp.trip_year
       AND EXTRACT(MONTH FROM th.request_timestamp)::INT = fp.trip_month

    WHERE th.trip_status = 'COMPLETED'
      AND tf.duration_minutes > 0
),

trip_estimates AS (
    SELECT
        *,
        driver_payout_zar -
        (
            distance_km
            * litres_per_100km / 100
            * fuel_price_per_litre
        ) AS estimated_net_earnings
    FROM completed_trips
)

SELECT
    CASE
        WHEN request_timestamp < TIMESTAMP '2026-03-01'
        THEN 'March 2025 - February 2026'
        ELSE 'March 2026'
    END AS period,

    COUNT(*) AS completed_trips,

    ROUND(AVG(driver_payout_zar), 2)
        AS avg_driver_payout,

    ROUND(AVG(
        distance_km * litres_per_100km / 100
        * fuel_price_per_litre
    ), 2) AS avg_estimated_fuel_cost,

    ROUND(AVG(estimated_net_earnings), 2)
        AS avg_estimated_net_earnings,

    ROUND(
        SUM(estimated_net_earnings)
        / NULLIF(SUM(duration_minutes / 60.0), 0),
        2
    ) AS estimated_net_earnings_per_hour,

    minimum_wage_benchmark,

    CASE
        WHEN
            SUM(estimated_net_earnings)
            / NULLIF(SUM(duration_minutes / 60.0), 0)
            >= minimum_wage_benchmark
        THEN 'MEETS OR EXCEEDS BENCHMARK'
        ELSE 'BELOW BENCHMARK'
    END AS benchmark_result

FROM trip_estimates

GROUP BY
    CASE
        WHEN request_timestamp < TIMESTAMP '2026-03-01'
        THEN 'March 2025 - February 2026'
        ELSE 'March 2026'
    END,
    minimum_wage_benchmark

ORDER BY MIN(request_timestamp);
-- ===========================================================================

-- Query 1: Completed trip validation
SELECT
    trip_status,
    COUNT(*) AS trip_count
FROM trip_headers
GROUP BY trip_status
ORDER BY trip_status;
-- ===========================================================================


-- Query 2: Vehicle validation
SELECT
    make,
    model,
    COUNT(*) AS vehicle_count
FROM vehicles
GROUP BY make, model
ORDER BY make, model;
-- ===========================================================================

-- RQ6 Query 4: Vehicle Model Comparison

WITH vehicle_fuel_rates AS (
    SELECT 'BMW' AS make, '3 Series' AS model, 6.5::NUMERIC AS litres_per_100km
    UNION ALL SELECT 'Hyundai', 'Grand i10', 5.5
    UNION ALL SELECT 'Kia', 'Picanto', 5.1
    UNION ALL SELECT 'Nissan', 'Almera', 6.3
    UNION ALL SELECT 'Renault', 'Triber', 5.5
    UNION ALL SELECT 'Suzuki', 'Ertiga', 5.5
    UNION ALL SELECT 'Toyota', 'Avanza', 7.6
    UNION ALL SELECT 'Toyota', 'Corolla Quest', 6.3
    UNION ALL SELECT 'Volkswagen', 'Polo Vivo', 5.9
),

completed_trips AS (
    SELECT
        th.trip_id,
        th.driver_id,
        th.request_timestamp,
        sd.operating_city,
        v.make,
        v.model,
        v.year,
        tf.distance_km,
        tf.duration_minutes,
        tf.driver_payout_zar,
        vfr.litres_per_100km,

        CASE
            -- 2025 Inland
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3 THEN 22.34

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 4 THEN 21.62

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 5 THEN 21.40

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 6 THEN 21.35

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 7 THEN 21.87

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 8 THEN 21.59

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 9 THEN 21.55

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 10 THEN 21.63

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 11 THEN 21.12

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 12 THEN 21.63

            -- 2025 Coastal
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3 THEN 21.55

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 4 THEN 20.79

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 5 THEN 20.57

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 6 THEN 20.52

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 7 THEN 21.04

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 8 THEN 20.76

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 9 THEN 20.72

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 10 THEN 20.80

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 11 THEN 20.29

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2025
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha')
             AND EXTRACT(MONTH FROM th.request_timestamp) = 12 THEN 20.80

            -- 2026 January
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 1
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.75

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 1
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.92

            -- 2026 February
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 2
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.10

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 2
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.27

            -- 2026 March
            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3
             AND sd.operating_city NOT IN ('Cape Town', 'Durban', 'Gqeberha') THEN 20.30

            WHEN EXTRACT(YEAR FROM th.request_timestamp) = 2026
             AND EXTRACT(MONTH FROM th.request_timestamp) = 3
             AND sd.operating_city IN ('Cape Town', 'Durban', 'Gqeberha') THEN 19.47
        END AS fuel_price_per_litre

    FROM trip_headers th
    INNER JOIN sa_drivers sd
        ON th.driver_id = sd.driver_id
    INNER JOIN vehicles v
        ON th.driver_id = v.driver_id
    INNER JOIN trip_fare_breakdown tf
        ON th.trip_id = tf.trip_id
    INNER JOIN vehicle_fuel_rates vfr
        ON v.make = vfr.make
       AND v.model = vfr.model

    WHERE th.trip_status = 'COMPLETED'
      AND tf.duration_minutes > 0
)

SELECT
    make,
    model,
    COUNT(*) AS completed_trips,

    ROUND(AVG(driver_payout_zar), 2)
        AS avg_driver_payout,

    ROUND(AVG(
        distance_km
        * litres_per_100km
        / 100
        * fuel_price_per_litre
    ), 2) AS avg_fuel_cost,

    ROUND(AVG(
        driver_payout_zar
        -
        (
            distance_km
            * litres_per_100km
            / 100
            * fuel_price_per_litre
        )
    ), 2) AS avg_net_earnings,

    ROUND(
        SUM(
            driver_payout_zar
            -
            (
                distance_km
                * litres_per_100km
                / 100
                * fuel_price_per_litre
            )
        )
        /
        SUM(duration_minutes / 60.0),
        2
    ) AS net_earnings_per_hour

FROM completed_trips

GROUP BY
    make,
    model

ORDER BY
    net_earnings_per_hour DESC;
-- ===========================================================================
-- Query 5: City comparison

-- RQ6 Query 5: City comparison using monthly fuel prices

WITH vehicle_fuel_rates AS (
    SELECT *
    FROM (VALUES
        ('BMW', '3 Series', 6.5::NUMERIC),
        ('Hyundai', 'Grand i10', 5.5::NUMERIC),
        ('Kia', 'Picanto', 5.1::NUMERIC),
        ('Nissan', 'Almera', 6.3::NUMERIC),
        ('Renault', 'Triber', 5.5::NUMERIC),
        ('Suzuki', 'Ertiga', 5.5::NUMERIC),
        ('Toyota', 'Avanza', 7.6::NUMERIC),
        ('Toyota', 'Corolla Quest', 6.3::NUMERIC),
        ('Volkswagen', 'Polo Vivo', 5.9::NUMERIC)
    ) AS rates(make, model, litres_per_100km)
),

fuel_prices AS (
    SELECT *
    FROM (VALUES
        (2025, 3, 22.34::NUMERIC, 21.55::NUMERIC),
        (2025, 4, 21.62, 20.79),
        (2025, 5, 21.40, 20.57),
        (2025, 6, 21.35, 20.52),
        (2025, 7, 21.87, 21.04),
        (2025, 8, 21.59, 20.76),
        (2025, 9, 21.55, 20.72),
        (2025, 10, 21.63, 20.80),
        (2025, 11, 21.63, 20.80),
        (2025, 12, 21.63, 20.80),
        (2026, 1, 20.75, 19.92),
        (2026, 2, 20.10, 19.27),
        (2026, 3, 20.30, 19.47)
    ) AS prices(trip_year, trip_month, inland_price, coastal_price)
),

completed_trips AS (
    SELECT
        sd.operating_city,
        tf.distance_km,
        tf.duration_minutes,
        tf.driver_payout_zar,
        vfr.litres_per_100km,

        CASE
            WHEN sd.operating_city IN (
                'Cape Town', 'Durban', 'Gqeberha'
            )
            THEN fp.coastal_price
            ELSE fp.inland_price
        END AS fuel_price_per_litre

    FROM trip_headers th

    JOIN sa_drivers sd
        ON th.driver_id = sd.driver_id

    JOIN trip_fare_breakdown tf
        ON th.trip_id = tf.trip_id

    JOIN vehicles v
        ON th.driver_id = v.driver_id

    JOIN vehicle_fuel_rates vfr
        ON v.make = vfr.make
       AND v.model = vfr.model

    JOIN fuel_prices fp
        ON EXTRACT(YEAR FROM th.request_timestamp)::INT = fp.trip_year
       AND EXTRACT(MONTH FROM th.request_timestamp)::INT = fp.trip_month

    WHERE th.trip_status = 'COMPLETED'
      AND tf.duration_minutes > 0
)

SELECT
    operating_city,
    COUNT(*) AS completed_trips,

    ROUND(AVG(driver_payout_zar), 2)
        AS avg_driver_payout,

    ROUND(AVG(
        distance_km * litres_per_100km / 100
        * fuel_price_per_litre
    ), 2) AS avg_estimated_fuel_cost,

    ROUND(AVG(
        driver_payout_zar -
        (distance_km * litres_per_100km / 100
        * fuel_price_per_litre)
    ), 2) AS avg_estimated_net_earnings,

    ROUND(
        SUM(
            driver_payout_zar -
            (distance_km * litres_per_100km / 100
            * fuel_price_per_litre)
        )
        / NULLIF(SUM(duration_minutes / 60.0), 0),
        2
    ) AS estimated_net_earnings_per_hour

FROM completed_trips
GROUP BY operating_city
ORDER BY estimated_net_earnings_per_hour DESC;


-- RQ6 validation A: Does any driver have multiple vehicle records?
SELECT
    driver_id,
    COUNT(*) AS vehicle_count,
    STRING_AGG(
        make || ' ' || model || ' (' || year::TEXT || ')',
        ', '
    ) AS vehicles
FROM vehicles
GROUP BY driver_id
HAVING COUNT(*) > 1
ORDER BY vehicle_count DESC, driver_id;


-- RQ6 validation B: Find models not covered by the current assumptions.
WITH fuel_rates(make, model) AS (
    VALUES
        ('BMW', '3 Series'),
        ('Hyundai', 'Grand i10'),
        ('Kia', 'Picanto'),
        ('Nissan', 'Almera'),
        ('Renault', 'Triber'),
        ('Suzuki', 'Ertiga'),
        ('Toyota', 'Avanza'),
        ('Toyota', 'Corolla Quest'),
        ('Volkswagen', 'Polo Vivo')
)
SELECT DISTINCT
    v.make,
    v.model
FROM vehicles AS v
LEFT JOIN fuel_rates AS r
    ON r.make = v.make
   AND r.model = v.model
WHERE r.make IS NULL
ORDER BY v.make, v.model;
